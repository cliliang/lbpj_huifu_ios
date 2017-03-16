//
//  LBMyHeaderView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/13.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyHeaderView.h"
#import "VWWWaterView.h"

@interface LBMyHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *tatalMoney;
@property (nonatomic, strong) VWWWaterView *waterView;

@end

@implementation LBMyHeaderView

+ (instancetype)myHeaderViewWithFrame:(CGRect)frame
{
    LBMyHeaderView *myHeaderView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBMyHeaderView class]) owner:nil options:nil] firstObject];
    myHeaderView.frame = frame;
    myHeaderView.label_totalMoney = myHeaderView.tatalMoney;
//    myHeaderView.backgroundColor = kNavBarColor;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [myHeaderView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(myHeaderView);
    }];
    imageView.image = [UIImage imageNamed:@"bg_MyHeader"];
    
    
//    VWWWaterView *waterView = [[VWWWaterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 154)];
//    [myHeaderView addSubview:waterView];
//    myHeaderView.waterView = waterView;
//    [myHeaderView initWaveValue];
//    
//    [myHeaderView sendSubviewToBack:waterView];
    [myHeaderView sendSubviewToBack:imageView];
    
    
    // -添加昨日收益, 累计收益
    CGFloat topBottom = 10;
    CGFloat centerHeight = 10;
    UIColor *textColor = [UIColor whiteColor];
    CGFloat fontSize = 11;
    
    UIView *redView = [UIView new];
    [imageView addSubview:redView];
    redView.backgroundColor = [UIColor colorWithRGBString:@"ff6e58"];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(imageView);
        make.right.left.mas_equalTo(imageView);
        make.height.mas_equalTo(kDiv2(109));
    }];
    
    // -昨日label
    UILabel *label1 = [UILabel new];
    [label1 setText:@"昨日收益(元)" textColor:textColor font:[UIFont pingfangWithFloat:fontSize weight:UIFontWeightLight]];
    [redView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(myHeaderView).multipliedBy(0.5);
        make.bottom.mas_equalTo(myHeaderView).offset(-topBottom);
        make.height.mas_equalTo(fontSize);
    }];
    // -昨日num
    UILabel *labelnum1 = [UILabel new];
    [labelnum1 setText:@"0.00" textColor:textColor font:[UIFont pingfangWithFloat:15 weight:UIFontWeightLight]];
    [redView addSubview:labelnum1];
    [labelnum1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(label1);
        make.height.mas_equalTo(fontSize);
        make.bottom.mas_equalTo(label1.mas_top).offset(-centerHeight);
    }];
    myHeaderView.label_yestodayIncome = labelnum1;
    
    // -累计num
    UILabel *label2 = [UILabel new];
    [label2 setText:@"累计收益(元)" textColor:textColor font:[UIFont pingfangWithFloat:fontSize weight:UIFontWeightLight]];
    [redView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(myHeaderView).multipliedBy(1.5);
        make.height.mas_equalTo(fontSize);
        make.bottom.mas_equalTo(myHeaderView).offset(-topBottom);
    }];
    
    // -累计label
    UILabel *labelNum2 = [UILabel new];
    [labelNum2 setText:@"0.00" textColor:textColor font:[UIFont pingfangWithFloat:15 weight:UIFontWeightLight]];
    [redView addSubview:labelNum2];
    [labelNum2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(label2);
        make.bottom.mas_equalTo(label2.mas_top).offset(-centerHeight);
        make.height.mas_equalTo(fontSize);
    }];
    myHeaderView.label_allIncome = labelNum2;
    
    
//    // 横线
//    UIView *hengLine = [UIView new];
//    [myHeaderView addSubview:hengLine];
//    hengLine.backgroundColor = textColor;
//    [hengLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(myHeaderView).offset(35);
//        make.right.mas_equalTo(myHeaderView).offset(-35);
//        make.bottom.mas_equalTo(labelnum1.mas_top).offset(-topBottom);
//        make.height.mas_equalTo(0.5);
//    }];
    // 竖线
    UIView *shuLine = [UIView new];
    [redView addSubview:shuLine];
    shuLine.backgroundColor = [UIColor colorWithRGBString:@"ff988a"];
    [shuLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(redView);
        make.centerX.mas_equalTo(redView);
        make.width.mas_equalTo(0.5);
    }];
    
    return myHeaderView;
}

#pragma mark 初始化波浪参数
- (void)initWaveValue
{
    //起始Y值
    _waterView.waveHeight = 115;
    
    //公式中用到(起始幅度)
    _waterView.wave = 1.5;
    //判断加减
    _waterView.jia = NO;
    //幅度增长速度
    _waterView.waveIncrease = 0.01;
    //减阈值 a
//    _waterView.waveMin = 2.24;
    _waterView.waveMin = 1.6;
    //增阈值 a
    _waterView.waveMax = 3.97;
    //b的增幅（速度控制）
    _waterView.waveSpeed = 0.08;
    //起始频率
    _waterView.w = 180;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
