//
//  NSObject+GYParse.h
//  GYParser
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KeyValue <NSObject>

/**
 *  解析字典转换成模型
 */
@optional
+ (instancetype)gy_parseWithDic:(NSDictionary *)dic;

/**
 *  解析数组字典转换成模型
 */
+ (NSArray *)gy_parseWithArrayDic:(NSArray *)array;


/**
 *  将字典中的key与模型中的属性对应 (名字不完全对应时使用)
 */
- (NSDictionary *)gy_replaceKeyWithNewName;

/**
 *  将模型中的属性与数组中的成员模型类型对应 (模型中有数组模型时使用)
 */
- (NSDictionary *)gy_mapingPropertyToObj;


/**
 *  解析Plist文件转换成模型
 */
+ (NSArray *)gy_parseWithPlist:(NSString *)fileName;


@end


@interface NSObject (GYParse)<KeyValue>


@end
