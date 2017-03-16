//
//  NSObject+PSSObjc.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/27.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "NSObject+PSSObjc.h"

@implementation NSObject (PSSObjc)

+ (NSInteger)vipWithMoney:(NSInteger)money
{
    if (kUserModel == nil) {
        return 100;
    }
    if (money >= 1000000) {
        return 5;
    } else if (money >= 200000) {
        return 4;
    } else if (money >= 30000) {
        return 3;
    } else if (money >= 5000) {
        return 2;
    } else if (![NSObject nullOrNilWithObjc:kUserModel.idCard] && kUserModel.idCard.length != 0) {
        return 1;
    } else {
        return 0;
    }
}

- (BOOL)isNullOrNil
{
    if ([self isKindOfClass:[NSNull class]] || self == nil) {
        return YES;
    }
    return NO;
}

+ (BOOL)nullOrNilWithObjc:(id)objc
{
    if ([objc isKindOfClass:[NSNull class]] || objc == nil) {
        return YES;
    }
    return NO;
}

@end
