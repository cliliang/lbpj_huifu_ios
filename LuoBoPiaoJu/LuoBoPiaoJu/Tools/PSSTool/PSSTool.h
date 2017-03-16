//
//  PSSTool.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSSTool : NSObject

+ (BOOL)compareDateWithNow:(NSString *)dateOne; // 小于当前时间, return YES

// 比较两个版本, 大于 -> 1, 等于 -> 0, 小于 -> -1;
+ (int)compareVersion:(NSString *)version1 withVersion:(NSString *)version2;



@end

@interface PSSTool (PSSNumberTool)

// 四舍五入， 保留两位小数
+ (float)roundFloat:(float)price;

// 大于万， 返回万为单位
+ (NSString *)wanWithNumber:(NSInteger)number;

@end




