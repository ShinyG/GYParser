//
//  Person.h
//  GYParserExample
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pet.h"
#import "Transport.h"
#import "Skill.h"

typedef enum : NSUInteger {
    Male,
    Female
} Sex;

@interface Person : NSObject

@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *age;
@property (nonatomic , strong) NSString *icon;
@property (nonatomic , strong) NSString *sex;

@property (nonatomic , strong) Pet *pet;
@property (nonatomic , strong) Transport *tp;

@property (nonatomic , strong) NSArray *skills;


@end
