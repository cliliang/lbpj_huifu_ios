//
//  LBMyHeaderView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/13.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBMyHeaderView : UIView

@property (nonatomic, strong) UILabel *label_totalMoney;
@property (nonatomic, strong) UILabel *label_allIncome;
@property (nonatomic, strong) UILabel *label_yestodayIncome;

+ (instancetype)myHeaderViewWithFrame:(CGRect)frame;

@end
