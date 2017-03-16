//
//  LBMoneyBillHeaderView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMoneyBillHeaderView.h"
#import "LBMoneyBillCircleView.h"
#import "LBYinPiaoProgressView.h"

@interface LBMoneyBillHeaderView ()

@property (nonatomic, strong) LBMoneyBillCircleView *circleView;
@property (nonatomic, strong) LBYinPiaoProgressView *progressView;

@end

@implementation LBMoneyBillHeaderView

+ (instancetype)instanceWithFrame:(CGRect)frame
{
    LBMoneyBillHeaderView *view = [[LBMoneyBillHeaderView alloc] init];
    view.backgroundColor = kNavBarColor;
    
    // 1. 银行
    UILabel *label_1 = [UILabel new];
    [label_1 setText:@"" textColor:UIColorFromHexString(@"ffdbd7", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(24) weight:UIFontWeightLight]];
    [view addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(24));
        make.top.mas_equalTo(view).offset(KAutoHDiv2(36));
        make.centerX.mas_equalTo(view);
    }];
    view.label_bank = label_1;
    
    // 2. 6.18
    UILabel *label_2 = [UILabel new];
    [label_2 setText:@"**" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(88) weight:UIFontWeightLight]];
    [view addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(88));
        make.top.mas_equalTo(label_1.mas_bottom).offset(KAutoHDiv2(40));
        make.centerX.mas_equalTo(view).offset(KAutoHDiv2(-22));
    }];
    UILabel *label_baifenhao = [UILabel new];
    [label_baifenhao setText:@"%" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(36) weight:UIFontWeightLight]];
    [view addSubview:label_baifenhao];
    [label_baifenhao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(36));
        make.left.mas_equalTo(label_2.mas_right).offset(0);
        make.bottom.mas_equalTo(label_2).offset(-KAutoHDiv2(8));
    }];
    view.label_nianHuaShouYe = label_2;
    
    //  3. 年华收益
    UILabel *label_3 = [UILabel new];
    [label_3 setText:@"年化收益" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(28) weight:UIFontWeightLight]];
    [view addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(28));
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(label_2.mas_bottom).offset(KAutoHDiv2(10));
    }];
    
    // 4. 起头金额
    UILabel *label_4 = [UILabel new];
    [label_4 setText:@"起投金额" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [view addSubview:label_4];
    [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(22));
        make.bottom.mas_equalTo(view).offset(-KAutoHDiv2(32));
        make.centerX.mas_equalTo(view).offset(-KAutoHDiv2(252));
    }];
    //
    UILabel *label_4_num = [UILabel new];
    [label_4_num setText:@"1" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(38) weight:UIFontWeightLight]];
    [view addSubview:label_4_num];
    [label_4_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(38));
        make.bottom.mas_equalTo(label_4.mas_top).offset(-KAutoHDiv2(12));
        make.centerX.mas_equalTo(label_4).offset(-KAutoHDiv2(10));
    }];
    UILabel *label_4_yuan = [UILabel new];
    [label_4_yuan setText:@"元" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(24) weight:UIFontWeightLight]];
    [view addSubview:label_4_yuan];
    [label_4_yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(24));
        make.bottom.mas_equalTo(label_4_num).offset(-KAutoHDiv2(3));
        make.left.mas_equalTo(label_4_num.mas_right);
    }];
    view.label_qiTouJinE = label_4_num;
    // 5. 理财期限
    UILabel *label_5 = [UILabel new];
    [label_5 setText:@"理财期限" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [view addSubview:label_5];
    [label_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(22));
        make.bottom.mas_equalTo(view).offset(-KAutoHDiv2(32));
        make.centerX.mas_equalTo(view);
    }];
    //
    UILabel *label_5_num = [UILabel new];
    [label_5_num setText:@"0" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(38) weight:UIFontWeightLight]];
    [view addSubview:label_5_num];
    [label_5_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(38));
        make.bottom.mas_equalTo(label_5.mas_top).offset(-KAutoHDiv2(12));
        make.centerX.mas_equalTo(label_5).offset(-KAutoHDiv2(10));
    }];
    UILabel *label_5_tian = [UILabel new];
    [label_5_tian setText:@"天" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(24) weight:UIFontWeightLight]];
    [view addSubview:label_5_tian];
    [label_5_tian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(24));
        make.bottom.mas_equalTo(label_5_num).offset(-KAutoHDiv2(3));
        make.left.mas_equalTo(label_5_num.mas_right);
    }];
    view.label_licaiqixian = label_5_num;
    // 6. 剩余金额
    UILabel *label_6 = [UILabel new];
    [label_6 setText:@"剩余金额" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [view addSubview:label_6];
    [label_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(22));
        make.bottom.mas_equalTo(view).offset(-KAutoHDiv2(32));
        make.centerX.mas_equalTo(view).offset(KAutoHDiv2(252));
    }];
    //
    UILabel *label_6_num = [UILabel new];
    [label_6_num setText:@"0" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(38) weight:UIFontWeightLight]];
    [view addSubview:label_6_num];
    [label_6_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(38));
        make.bottom.mas_equalTo(label_6.mas_top).offset(-KAutoHDiv2(12));
        make.centerX.mas_equalTo(label_6).offset(-KAutoHDiv2(10));
    }];
    UILabel *label_6_yuan = [UILabel new];
    [label_6_yuan setText:@"元" textColor:UIColorFromHexString(@"ffffff", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(24) weight:UIFontWeightLight]];
    [view addSubview:label_6_yuan];
    [label_6_yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(24));
        make.bottom.mas_equalTo(label_6_num).offset(-KAutoHDiv2(3));
        make.left.mas_equalTo(label_6_num.mas_right);
    }];
    view.label_ketoujine = label_6_num;
    // 7. progressView
    LBYinPiaoProgressView *progressView = [[LBYinPiaoProgressView alloc] init];
    [view addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(label_6_num.mas_top).offset(-KAutoHDiv2(28));
        make.centerX.mas_equalTo(view);
        make.width.mas_equalTo(kYinPiaoProgressWid);
        make.height.mas_equalTo(kYinPiaoProgressHei);
    }];
    view.progressView = progressView;
    
    return view;
}

- (void)drawCircleWithPercent:(CGFloat)percent
{
    self.progressView.progress = percent;
//    [self.circleView removeFromSuperview];
//    self.circleView = [LBMoneyBillCircleView new];
//    CGFloat r = 50.0 / 2; // 半径
//    CGFloat height = percent * r * 2;
//    CGFloat startJiao = asin((r - height) / r);
//    CGFloat endJiao = M_PI - startJiao;
//    [self.view_yuan addSubview:self.circleView];
//    self.circleView.startJiao = startJiao;
//    self.circleView.endJiao = endJiao;
//    [self.circleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.and.height.mas_equalTo(self.view_yuan);
//        make.left.and.bottom.mas_equalTo(self.view_yuan);
//    }];
//    [self.view_yuan insertSubview:self.circleView belowSubview:self.label_xiaoShouJinDu];
//    
//    NSString *string_1 = [NSString stringWithFormat:@"%.2lf", percent * 100];
//    NSString *string_2 = [string_1 substringToIndex:string_1.length - 3];
//    self.label_xiaoShouJinDu.text = [NSString stringWithFormat:@"%@%%",string_2];
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
//    CGFloat constant = 47;
//    if (kScreenWidth == 320) { // 5s
//        constant = 20;
//        self.distance_yuanBottom.constant = 20;
//        self.left_licaiqixian.constant = constant;
//        self.right_ketoujinE.constant = constant;
//    }
}

- (void)setHuoqiStyle:(LBHeaderHuoQiStyle)huoqiStyle
{
//    _huoqiStyle = huoqiStyle;
//    CGFloat constant = 47;
//    if (kScreenWidth == 320) { // 5s
//        constant = 20;
//    }
//    if (_huoqiStyle == LBHeaderHuoQiStyleYES) {
//        self.label_licaiqixian.hidden = YES;
//        self.label_licaiqixianTitle.hidden = YES;
//        
//        UILabel *label = [UILabel new];
//        [label setText:@"随存随取" textColor:[UIColor whiteColor] font:[UIFont pingfangWithFloat:18 weight:UIFontWeightLight]];
//        [self addSubview:label];
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self).offset(constant);
//            make.centerY.mas_equalTo(self.label_nianHuaShouYeTitle).offset(-15);
//        }];
//    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
