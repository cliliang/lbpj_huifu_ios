//
//  LBUsableHongBaoCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/29.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBUsableHongBaoCell.h"

#define kPingFangFont(a) [UIFont fontWithName:@"PingFangSC-Light" size:(a)]

@interface LBUsableHongBaoCell ()

@property (nonatomic, strong) UILabel *label_money;
@property (nonatomic, strong) UILabel *label_hongBao;

@end

@implementation LBUsableHongBaoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // imageV
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:@"image_usableHongBao_sele"];
        [self.contentView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.centerX.mas_equalTo(self.contentView);
//            make.width.mas_equalTo(KAutoWDiv2(196));
//            make.height.mas_equalTo(kDiv2(110));
        }];
        _imageV = imageV;
        
        // 1000元
        UILabel *label1 = [UILabel new];
        [self.contentView addSubview:label1];
        [label1 setText:@"10000元" textColor:[UIColor whiteColor] font:kPingFangFont(15)];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(imageV.mas_top).offset(kDiv2(28));
            make.height.mas_equalTo(15);
        }];
        _label_money = label1;
        
        // 红包
        UILabel *label2 = [UILabel new];
        [label2 setText:@"红包" textColor:[UIColor whiteColor] font:kPingFangFont(10)];
        [self.contentView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label1.mas_bottom).offset(kDiv2(10));
            make.centerX.mas_equalTo(imageV);
        }];
        _label_hongBao = label2;
        
        imageV.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void)setModel:(LBUsableHBModel *)model
{
    _model = model;
    _imageV.image = !model.usingBool ? [UIImage imageNamed:@"image_usableHongBao_nor"] : [UIImage imageNamed:@"image_usableHongBao_sele"];
    _label_money.text = [NSString stringWithFormat:@"%@元", model.couponMoney];
    _label_hongBao.text = model.couponType ? @"本金红包" : @"现金红包";
}

@end









