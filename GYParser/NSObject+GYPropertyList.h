//
//  NSObject+GYPropertyList.h
//  GYParser
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


@interface NSObject (GYPropertyList)

/* 1、获取对象的所有属性，不包括属性值 */
+ (NSArray *)gy_getAllProperties;

/* 2、获取所有自定义参数类型 */
+ (NSDictionary *)gy_getAllType;

@end
