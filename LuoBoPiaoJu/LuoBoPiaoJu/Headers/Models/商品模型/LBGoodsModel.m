//
//  LBGoodsModel.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBGoodsModel.h"

@implementation LBGoodsModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    kLog(@"%@ -- %@", key, value);
}
- (NSString *)bankName
{
    if (_payLabel.length > 8) {
        return [_payLabel substringWithRange:NSMakeRange(3, _payLabel.length - 8)];
    }
    return _payLabel;
}

/**
 *  获得投资天数
 */
- (NSInteger)getInvestDayNum
{
    return [self compareDateWithNow:self.valueTime];
}

- (NSInteger)compareDateWithNow:(NSString *)dateOne // dateOne距离当前时间天数
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *date1 = [formatter dateFromString:dateOne];
    
    NSDate *nowDate = [NSDate date];
    NSString *nowStr = [formatter stringFromDate:nowDate];
    NSDate *date0 = [formatter dateFromString:nowStr];
    
    NSTimeInterval time1 = [date1 timeIntervalSince1970];
    NSTimeInterval time0 = [date0 timeIntervalSince1970];
    
    NSInteger secondNum = time1 - time0;
    NSInteger dayNum = 60 * 60 * 24;
    
    return secondNum / dayNum;
}





@end
