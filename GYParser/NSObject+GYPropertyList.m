//
//  NSObject+GYPropertyList.m
//  GYParser
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import "NSObject+GYPropertyList.h"

@implementation NSObject (GYPropertyList)

/* 1、获取对象的所有属性，不包括属性值 */
+ (NSArray *)gy_getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
//        NSLog(@"attributes:%s",property_getAttributes(properties[i]));
    }
    free(properties);
    return propertiesArray;
}

/* 2、获取所有自定义参数类型 */
+ (NSDictionary *)gy_getAllType
{
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(self,&propertyCount);
    NSMutableDictionary *clsDic = @{}.mutableCopy;
    for (unsigned int i = 0; i < propertyCount; ++i) {
        objc_property_t property = properties[i];
        const char * name = property_getName(property);//获取属性名字
        const char * attributes = property_getAttributes(property);//获取属性类型
        NSString *attr = [NSString stringWithCString:attributes encoding:NSUTF8StringEncoding];
        if ([attr containsString:@"@"]) {
            NSString *cls = [[[attr componentsSeparatedByString:@","][0] componentsSeparatedByString:@"@"][1] substringFromIndex:1];
            cls = [cls substringToIndex:cls.length-1];
            if (![cls isEqualToString:@"NSString"] && ![cls containsString:@"NSDictionary"] && ![cls containsString:@"NSArray"]) { // 过滤
                clsDic[@(name)] = cls;
            }
        }
        
    }
    free(properties);
    return clsDic.copy;
}


@end
