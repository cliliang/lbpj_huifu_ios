//
//  NSDate+PSSDate.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PSSDate)

/**
 *  java时间戳转换字符串 yyyy-MM-dd
 */
+ (NSString *)stringWithJavaTimeInter:(double)timeInt dateFormat:(NSString *)dateFormat;

/**
 *  判断两个时间戳是不是在同一天
 */
+ (BOOL)compareOneDayTimeInt1:(double)timeInt1 timeInt2:(double)timeInt2;
/**
 *  后面 减去 前面 --- 间隔时间
 */
+ (NSInteger)compareDate1:(NSString *)oneStr date2:(NSString *)twoStr;

@end
