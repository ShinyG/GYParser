//
//  main.m
//  GYParserExample
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GYParse.h"
#import "Person.h"
#import "Pet.h"
#import "GoodsModel.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // 1.字典转模型
        NSDictionary *dic1 = @{@"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male)};
        NSLog(@"1. %@",[Person gy_parseWithDic:dic1]);
        
        // 2.模型中有模型
        NSDictionary *dic2 = @{@"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male),
                               @"pet" : @{@"name":@"旺财",@"age":@2,
                                          @"food":@{
                                                  @"name":@"fish"
                                                  }
                                          }
                               };
        NSLog(@"2. %@",[Person gy_parseWithDic:dic2]);
        
        // 3.模型中的属性名和字典中的key名不同时做映射:"transport"->"tp"
        NSDictionary *dic3 = @{@"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male),
                               @"pet" : @{@"name":@"旺财",@"age":@2,
                                          @"food":@{
                                                  @"name":@"fish"
                                                  }
                                          },
                               @"transport": @{@"name":@"car",@"money":@(1000000)}
                               };
        NSLog(@"3. %@",[Person gy_parseWithDic:dic3]);
        
        // 4.模型中有数组属性，数组的成员是自定义模型，并且数组的名字与key不同:"sks"->"skills"
        NSArray *skills = @[@{@"name":@"寒冰箭"},@{@"name":@"火焰冲击"},@{@"name":@"奥数飞弹"}];
        NSDictionary *dic4 = @{@"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male),
                               @"pet" : @{@"name":@"旺财",@"age":@2,
                                          @"food":@{
                                                  @"name":@"fish"
                                                  }
                                          },
                               @"transport": @{@"name":@"car",@"money":@(1000000)},
                               @"sks":skills
                               };
        NSLog(@"4. %@",[Person gy_parseWithDic:dic4]);
        
        // 5.将字典数组转成模型数组
        NSArray *sks = [Skill gy_parseWithArrayDic:skills];
        for (int i = 0; i < sks.count; i++) {
            NSLog(@"5. %@,%@",[sks[i] class],[sks[i] name]);
        }
        
        // 6.解析plist文件,二维数组->模型
        NSArray *goodModel = [GoodsModel gy_parseWithPlist:@"List"];
        for (int i = 0; i < goodModel.count; i++) {
            for (int j = 0; j < [goodModel[i] count]; j++) {
                NSLog(@"6. [%d][%d]%@",i,j,goodModel[i][j]);
            }
        }
        
    }
    return 0;
}