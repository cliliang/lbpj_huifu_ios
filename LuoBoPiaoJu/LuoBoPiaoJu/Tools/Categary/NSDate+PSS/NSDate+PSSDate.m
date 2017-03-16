//
//  NSDate+PSSDate.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "NSDate+PSSDate.h"

@implementation NSDate (PSSDate)

// java 时间戳 转化成字符串
+ (NSString *)stringWithJavaTimeInter:(double)timeInt dateFormat:(NSString *)dateFormat
{
    NSTimeInterval theTimeInt = timeInt / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:theTimeInt];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    NSString *string = [dateFormatter stringFromDate:date];
    return string;
}

// 两个时间戳是否同一天
+ (BOOL)compareOneDayTimeInt1:(double)timeInt1 timeInt2:(double)timeInt2
{
    NSString *string1 = [NSDate stringWithJavaTimeInter:(double)timeInt1 * 1000 dateFormat:@"YYYY-MM-dd"];
    NSString *string2 = [NSDate stringWithJavaTimeInter:(double)timeInt2 * 1000 dateFormat:@"yyyy-MM-dd"];
    return [string1 isEqualToString:string2];
}

// 后面 减去 前面 --- 间隔时间
+ (NSInteger)compareDate1:(NSString *)oneStr date2:(NSString *)twoStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *date1 = [formatter dateFromString:oneStr];
    NSDate *date2 = [formatter dateFromString:twoStr];
    
    NSTimeInterval time1 = [date1 timeIntervalSince1970];
    NSTimeInterval time2 = [date2 timeIntervalSince1970];
    NSInteger secondNum = time2 - time1;
    NSInteger dayNum = 60 * 60 * 24;
    return secondNum / dayNum;
}


@end






