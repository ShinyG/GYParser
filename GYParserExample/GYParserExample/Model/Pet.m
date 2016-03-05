//
//  Pet.m
//  GYParserExample
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import "Pet.h"

@implementation Pet

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@,age:%@   food:%@",_name,_age,_food];
}

@end
