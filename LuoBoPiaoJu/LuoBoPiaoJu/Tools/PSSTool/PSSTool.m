//
//  PSSTool.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSTool.h"

@implementation PSSTool


+ (BOOL)compareDateWithNow:(NSString *)dateOne // 小于当前时间, return YES
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:dateOne];
    NSTimeInterval timeInt = [date timeIntervalSince1970];
    NSTimeInterval timeCount = timeInt;
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowTimeCount = [nowDate timeIntervalSince1970];
    if (timeCount < nowTimeCount) {
        return YES;
    } else {
        return NO;
    }
    return YES;
}


// 比较两个版本, 大于 -> 1, 等于 -> 0, 小于 -> -1;
+ (int)compareVersion:(NSString *)version1 withVersion:(NSString *)version2
{
    NSArray *arr1 = [version1 componentsSeparatedByString:@"."];
    NSArray *arr2 = [version2 componentsSeparatedByString:@"."];
    
    NSInteger count1 = arr1.count;
    NSInteger count2 = arr2.count;
    NSInteger minCount = count1 < count2 ? count1 : count2;
    for (int i = 0; i < minCount; i++) {
        int num1 = [arr1[i] intValue];
        int num2 = [arr2[i] intValue];
        if (num1 > num2) {
            return 1;
        } else if (num1 < num2) {
            return -1;
        } else {
            
        }
    }
    
    if (count1 > count2) {
        return 1;
    } else if (count1 < count2) {
        return -1;
    } else {
        return 0;
    }
}

+ (float)roundFloat:(float)price
{
    
    NSString *temp = [NSString stringWithFormat:@"%.7f",price];
    
    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:temp];
    
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       
                                       scale:2
                                       
                                       raiseOnExactness:NO
                                       
                                       raiseOnOverflow:NO
                                       
                                       raiseOnUnderflow:NO
                                       
                                       raiseOnDivideByZero:YES];
    
    return [[numResult decimalNumberByRoundingAccordingToBehavior:roundUp] floatValue];
    
}

// 大于万， 返回万为单位
+ (NSString *)wanWithNumber:(NSInteger)number
{
    if (number < 10000) {
        return [NSString stringWithFormat:@"%ld", number];
    } else {
        return [NSString stringWithFormat:@"%.2lf万", [self roundFloat:number * 1.0 / 10000]];
    }
    return nil;
}


@end


