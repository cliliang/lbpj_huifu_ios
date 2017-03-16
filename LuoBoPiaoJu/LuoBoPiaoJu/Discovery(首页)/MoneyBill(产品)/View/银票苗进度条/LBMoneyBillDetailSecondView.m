//
//  LBMoneyBillDetailSecondView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMoneyBillDetailSecondView.h"
#import "LBSmallCircleView.h"

@interface LBMoneyBillDetailSecondView ()

//@property (nonatomic, strong) LBSmallCircleView *yuan_1; // 发售
//@property (nonatomic, strong) LBSmallCircleView *yuan_2; // 起息
//@property (nonatomic, strong) LBSmallCircleView *yuan_3; // 结息
//@property (nonatomic, strong) LBSmallCircleView *yuan_4; // 最迟到账日
@property (nonatomic, strong) NSMutableArray *yuanArray;
@property (nonatomic, strong) NSMutableArray *lineArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *timeArray;


@end

@implementation LBMoneyBillDetailSecondView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat height = frame.size.height;
        CGFloat s_yuan = 8; // 边长
        CGFloat x_yuan = 50;
        CGFloat y_yuan = (height - s_yuan) / 2;
        CGFloat jianGe = (kScreenWidth - 2 * x_yuan - s_yuan) / 3; // 间隔
        _yuanArray = [NSMutableArray new];
        for (int i = 0; i < 4; i++) {
            LBSmallCircleView *yuan = [[LBSmallCircleView alloc] initWithFrame:CGRectMake(x_yuan + i * jianGe, y_yuan, s_yuan, s_yuan)];
            [self addSubview:yuan];
            
            [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(x_yuan + i * jianGe);
                make.top.mas_equalTo(self).offset(y_yuan);
                make.width.and.height.mas_equalTo(s_yuan);
            }];
            
            [_yuanArray addObject:yuan];
        }
        
        _lineArray = [NSMutableArray new];
        for (int i = 0 ; i < _yuanArray.count; i++) {
            if (i == _yuanArray.count - 1) {
                break;
            }
            LBSmallCircleView *yuan_start = _yuanArray[i];
            LBSmallCircleView *yuan_ent = _yuanArray[i + 1];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(yuan_start.right, yuan_start.center.y, yuan_ent.left - yuan_start.right, 1)];
            [self addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(yuan_start.mas_right);
                make.right.mas_equalTo(yuan_ent.mas_left);
                make.centerY.mas_equalTo(yuan_ent);
                make.height.mas_equalTo(1);
            }];
            
            [_lineArray addObject:lineView];
            lineView.backgroundColor = [UIColor lightGrayColor];
        }
        
        _titleArray = [NSMutableArray new];
        NSArray *titleArray = @[@"起售日", @"停售日", @"结息日", @"到账日"];
        for (int i = 0; i < _yuanArray.count; i++) {
            LBSmallCircleView *yuan = _yuanArray[i];
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            label.textColor = [UIColor colorWithRGBString:@"707070" withAlpha:1];
            label.text = titleArray[i];
            label.font = [UIFont systemFontOfSize:10];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(yuan);
                make.top.mas_equalTo(self).offset(9);
                make.height.mas_equalTo(10);
            }];
            [_titleArray addObject:label];
        }
        
        _timeArray = [NSMutableArray new];
        for (int i = 0; i < _yuanArray.count; i++) {
            LBSmallCircleView *yuan = _yuanArray[i];
            UILabel *label = [[UILabel alloc] init];
            [self addSubview:label];
            label.textColor = [UIColor colorWithRGBString:@"707070" withAlpha:1];
            label.text = @"time";
            label.font = [UIFont systemFontOfSize:8];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(yuan);
                make.top.mas_equalTo(yuan.mas_bottom).offset(6);
                make.height.mas_equalTo(8);
            }];
            [_timeArray addObject:label];
        }
        
    }
    return self;
}


- (void)setTimeArr:(NSArray *)timeArr
{
    _timeArr = timeArr;
    for (int i = 0; i < timeArr.count; i++) {
        UILabel *label = _timeArray[i];
        label.text = timeArr[i];
        NSString *string = timeArr[i];
        if (i == 0 && string.length > 9) {
            label.text = [timeArr[i] substringToIndex:string.length - 9];
        }
    }
}

- (void)setProgressStyle:(LBProgressStyle)progressStyle
{
    _progressStyle = progressStyle;
    for (int i = 0; i < 4; i++) {
        if (i > progressStyle) {
            break;
        }
        LBSmallCircleView *view = _yuanArray[i];
        view.layer.borderColor = kNavBarColor.CGColor;
        if (i != 0) {
            UIView *lineView = _lineArray[i - 1];
            lineView.backgroundColor = kNavBarColor;
        }
    }
}

// 后来添加的线的进度
- (void)setLineColorWithStartTime:(NSString *)startTime endTime:(NSString *)endTime style:(LBProgressStyle)style
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *startDate = [formatter dateFromString:startTime];
    NSTimeInterval startCount = [startDate timeIntervalSince1970];
    
    NSDate *endDate = [formatter dateFromString:endTime];
    NSTimeInterval endCount = [endDate timeIntervalSince1970];
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowCount = [nowDate timeIntervalSince1970];
    
    CGFloat progress = 1.0 * (nowCount - startCount) / (endCount - startCount);
    UIView *lineView = _lineArray[style];
    if (lineView.subviews != nil && lineView.subviews.count != 0) {
        for (UIView *view in lineView.subviews) {
            if ([view isKindOfClass:[UIView class]]) {
                [view removeFromSuperview];
            }
        }
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lineView.width * progress, lineView.height)];
    view.backgroundColor = kNavBarColor;
    [lineView addSubview:view];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
