//
//  LBGestureTimeView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/7/15.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBGestureTimeView.h"

@interface LBGestureTimeView ()

@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UILabel *dayLabel;
@property (nonatomic, strong) UILabel *weekdayLabel;
@property (nonatomic, strong) UILabel *phoneLabel;

@property (nonatomic, strong) NSArray *weekDayArray;
@property (nonatomic, strong) NSArray *monthDayArray;

@end

@implementation LBGestureTimeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dayLabel = [[UILabel alloc] init];
        [self addSubview:_dayLabel];
        _dayLabel.font = [UIFont systemFontOfSize:div_2(88)];
        _dayLabel.textColor = [UIColor colorWithRGBString:@"5c5c5c"];
        [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.mas_equalTo(self);
            make.height.mas_equalTo(div_2(88));
        }];
        
        _monthLabel = [[UILabel alloc] init];
        [self addSubview:_monthLabel];
        _monthLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
        _monthLabel.textColor = kLightColor;
        [_monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(3);
            make.left.mas_equalTo(_dayLabel.mas_right).offset(14);
            make.height.mas_equalTo(14);
        }];
        
        _weekdayLabel = [[UILabel alloc] init];
        [self addSubview:_weekdayLabel];
        _weekdayLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
        _weekdayLabel.textColor = kLightColor;
        [_weekdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_monthLabel.mas_bottom).offset(7);
            make.left.mas_equalTo(_monthLabel);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(_dayLabel.mas_bottom).offset(12);
            make.height.mas_equalTo(0.5);
            make.width.mas_equalTo(150);
        }];
        
        _phoneLabel = [[UILabel alloc] init];
        [self addSubview:_phoneLabel];
        _phoneLabel.textColor = kLightColor;
        _phoneLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(lineView.mas_bottom).offset(12);
            make.height.mas_equalTo(14);
        }];
        [self whatTimeIsIt];
    }
    return self;
}

- (void)whatTimeIsIt
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday |  NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour fromDate:date];
//    NSLog(@"%ld", (long)components.month);
//    NSLog(@"%ld", (long)components.day);
//    NSLog(@"%ld", (long)components.weekday);
//    NSLog(@"%ld", (long)components.hour);
    
    _dayLabel.text = [NSString stringWithFormat:@"%ld", (long)components.day];
    _monthLabel.text = [NSString stringWithFormat:@"%@月", self.monthDayArray[(long)components.month - 1]];
    _weekdayLabel.text = self.weekDayArray[(long)components.weekday - 1];
    
    NSString *stringNum = [LBUserModel getInPhone].mobile;
    NSString *phoneStr = [NSString stringWithFormat:@"您好, %@****%@", [stringNum substringToIndex:3], [stringNum substringFromIndex:stringNum.length - 4]];
    _phoneLabel.text = phoneStr;
}

- (NSArray *)weekDayArray
{
    if (_weekDayArray == nil) {
        _weekDayArray = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    }
    return _weekDayArray;
}

-  (NSArray *)monthDayArray
{
    if (_monthDayArray == nil) {
        _monthDayArray = @[@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"十一", @"十二"];
    }
    return _monthDayArray;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
