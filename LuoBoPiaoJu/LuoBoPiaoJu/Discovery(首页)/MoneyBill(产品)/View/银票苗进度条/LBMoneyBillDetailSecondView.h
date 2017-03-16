//
//  LBMoneyBillDetailSecondView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  发售日 - 起息日 - 结息日 - 最迟到账日 View

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LBProgressFaShouRi, // 发售日
    LBProgressQiXiRi, // 起息日
    LBProgressJieXiRi, // 结息日
    LBProgressFinished, // 最迟到账日
} LBProgressStyle;
// 高55
// 小圆距离左右50
@interface LBMoneyBillDetailSecondView : UIView

@property (nonatomic, strong) NSArray *timeArr;
@property (nonatomic, assign) LBProgressStyle progressStyle;

- (void)setLineColorWithStartTime:(NSString *)startTime endTime:(NSString *)endTime style:(LBProgressStyle)style;

@end








