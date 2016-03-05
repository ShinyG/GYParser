//
//  NSObject+GYParse.m
//  GYParser
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import "NSObject+GYParse.h"
#import "NSObject+GYPropertyList.h"

@implementation NSObject (GYParse)

+ (NSDictionary *)gy_replaceDic:(NSDictionary *)dic {
    NSMutableDictionary *mutDic = dic.mutableCopy;
    for (NSString *key in dic.allKeys) {
        if ([mutDic[key] isEqual:[NSNull null]]) {
            mutDic[key] = @"";
        } else if ([dic[key] isKindOfClass:[NSString class]]) {
            mutDic[key] = dic[key];
        } else if ([dic[key] isKindOfClass:[NSArray class]]) {
            NSArray *arr = dic[key];
            for (id obj in arr) {
                Class class = [obj class];
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    [class gy_replaceDic:obj];
                }
            }
            mutDic[key] = arr;
        } else if ([dic[key] isKindOfClass:[NSDictionary class]]){
            [self gy_replaceDic:dic[key]];
        } else {
            mutDic[key] = [NSString stringWithFormat:@"%@",dic[key]];
        }
    }
    
    return mutDic;
}

+ (instancetype)gy_parseWithDic:(NSDictionary *)dic{
    if ([dic isEqual:[NSNull null]] || dic == nil || ![dic isKindOfClass:[NSDictionary class]]) return nil;
    
    // 将dic中的基础类型转换为NSString类型
    dic = [self gy_replaceDic:dic];
    
    id obj = [[self alloc] init];
    
    //获取对象中所有属性名
    NSArray *arr = [self gy_getAllProperties];

    
    //如果对象实现了replaceKeyWithNewName方法，则替换key值
    if ([obj respondsToSelector:@selector(gy_replaceKeyWithNewName)]) {
        //将老字典转换为可变字典
        NSMutableDictionary *mutableDic = [dic mutableCopy];
        NSDictionary *map = [obj gy_replaceKeyWithNewName];
        
        //遍历替换的字典
        [map enumerateKeysAndObjectsUsingBlock:^(NSString *originalKey, NSString *newKey, BOOL *stop) {
            //将需要替换的key加入到新字典中
            dic[originalKey]?mutableDic[newKey] = dic[originalKey]:nil;
        }];

        dic = [mutableDic copy];
    }
    
    //如果对象实现了mapingPropertyToObj方法，则纪录该对象类型
    NSDictionary *mapingType = nil;
    if ([obj respondsToSelector:@selector(gy_mapingPropertyToObj)]) {
        //对象类型字典
        mapingType = [obj gy_mapingPropertyToObj];
    } else {
        //自定义类型字典
        mapingType = [self gy_getAllType];
    }
    
    
    for (NSString *str in arr) {
        
        //如果该属性是对象，则递归
        if (mapingType && mapingType[str]) {
            if (!dic[str]) {
                continue;
            }
            
            //取出属性的对象类型
            Class mapping = NSClassFromString(mapingType[str]);
            
            //dic[str]取出的是数组，则遍历转换成模型
            if ([dic[str] isKindOfClass:[NSArray class]]) {
                
                NSArray *modelList = dic[str];
                NSMutableArray *result = [NSMutableArray array];
                for (NSDictionary *dic in modelList) {
                    id otherObj = [mapping gy_parseWithDic:dic];
                    [result addObject:otherObj];
                }
                [obj setValue:result forKeyPath:str];

            }else{
                //dic[str]取出的是字典类型，直接转换成模型
                id otherObj = [mapping gy_parseWithDic:dic[str]];
                if (otherObj) {
                    [obj setValue:otherObj forKeyPath:str];
                }
                
                
            }
            continue;
        }
        
        dic[str]?[obj setValue:dic[str] forKeyPath:str]:nil;
    }

    return obj;
}

+ (NSArray *)gy_parseWithPlist:(NSString *)fileName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSArray *modelList = [NSArray arrayWithContentsOfFile:filePath];
    
    NSMutableArray *results = [NSMutableArray array];
    id model = nil;
    for (id obj in modelList) {
        
        if ([obj isKindOfClass:[NSDictionary class]]) {
            model = [self gy_parseWithDic:obj];
            [results addObject:model];
        } else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *objs = [self gy_parseWithArrayDic:obj];
            [results addObject:objs];
        }
        
    }
    
    return results;
    
}


+ (NSArray *)gy_parseWithArrayDic:(NSArray *)array{
    NSMutableArray *results = [NSMutableArray array];
    id model = nil;
    for (NSDictionary *dic in array) {
        
        model = [self gy_parseWithDic:dic];
        
        [results addObject:model];
    }
    
    return results;
}

@end
