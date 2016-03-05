//
//  Pet.h
//  GYParserExample
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Food.h"

@interface Pet : NSObject

@property (nonatomic , strong) NSString *name;
@property (nonatomic , strong) NSString *age;

@property (nonatomic , strong) Food *food;

@end
