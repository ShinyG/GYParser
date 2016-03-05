//
//  Person.m
//  GYParserExample
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import "Person.h"
#import "NSObject+GYParse.h"

@implementation Person

- (NSDictionary *)gy_replaceKeyWithNewName
{
    return @{@"transport":@"tp",@"sks":@"skills"};
}

- (NSDictionary *)gy_mapingPropertyToObj
{
    return @{@"skills":@"Skill"};
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@,age:%@,icon:%@,sex:%@,\npet:%@,\ntransport:%@\n      skills:%@",
            _name,_age,_icon,_sex,_pet,_tp,_skills];
}



// @"name":@"张三",@"age":@18,@"icon":@"icon.png",@"sex":@(Male)

@end
