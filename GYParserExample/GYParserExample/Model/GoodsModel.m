//
//  GoodsModel.m
//  GYParserExample
//
//  Created by GY on 16/3/6.
//  Copyright © 2016年 GY. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"title:%@,subTitle:%@,image:%@",_title,_subTitle,_image];
}

@end
