//
//  LBMoneyBillHeaderView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  银票苗详情页的头

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LBHeaderHuoQiStyleNO,
    LBHeaderHuoQiStyleYES,
} LBHeaderHuoQiStyle;

@interface LBMoneyBillHeaderView : UIView

@property (nonatomic, strong) UILabel *label_licaiqixian; // 理财期限(数据)
@property (nonatomic, strong) UILabel *label_licaiqixianTitle; // 理财期限标题
@property (nonatomic, strong) UILabel *label_nianHuaShouYe; // 年化收益(数据)
@property (nonatomic, strong) UILabel *label_nianHuaShouYeTitle; // 年华收益title
@property (nonatomic, strong) UILabel *label_ketoujine; // 可投金额
@property (nonatomic, strong) UILabel *label_ketoujineTitle; // 可投金额title
@property (nonatomic, strong) UIView *view_yuan; // 老进度条的圆圈, 不要了
@property (nonatomic, strong) UILabel *label_xiaoShouJinDu; // 销售进度百分比
@property (nonatomic, strong) UILabel *label_bank; // 银行名称
@property (nonatomic, strong) UILabel *label_qiTouJinE; // -起投金额

@property (nonatomic, assign) LBHeaderHuoQiStyle huoqiStyle;

+ (instancetype)instanceWithFrame:(CGRect)frame;

// 通过百分比画圆
- (void)drawCircleWithPercent:(CGFloat)percent;

@end
