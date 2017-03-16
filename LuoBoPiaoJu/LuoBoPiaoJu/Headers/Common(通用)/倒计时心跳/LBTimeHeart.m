//
//  LBTimeHeart.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/11/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBTimeHeart.h"

@implementation LBTimeHeart

+ (instancetype)shareTime
{
    static LBTimeHeart *timeHeart = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (timeHeart == nil) {
            timeHeart = [[LBTimeHeart alloc] init];
            timeHeart.networking = YES;
        }
    });
    return timeHeart;
}

@end
