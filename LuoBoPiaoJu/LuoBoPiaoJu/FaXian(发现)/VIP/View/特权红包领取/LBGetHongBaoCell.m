//
//  LBGetHongBaoCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBGetHongBaoCell.h"

@interface LBGetHongBaoCell ()

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *signImageV;
@property (nonatomic, strong) UILabel *label_money;
@property (nonatomic, strong) UILabel *label_hongBao;
@property (nonatomic, strong) UILabel *label_btn;
@property (nonatomic, strong) UILabel *label_lignqu;

@property (nonatomic, strong) NSDictionary *levelDict;

@property (nonatomic, strong) UIView *lingquBGV;

@end

@implementation LBGetHongBaoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSomeView];
    }
    return self;
}

- (void)addSomeView
{
    // 背景图
    UIImageView *imageV = [[UIImageView alloc] init];
    [self.contentView addSubview:imageV];
    _imageV = imageV;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(kDiv2(15));
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(KAutoWDiv2(195));
        make.height.mas_equalTo(kDiv2(108));
    }];
    _imageV.image = [UIImage imageNamed:@"icon_tequanhongbao_sele"];
    
    UILabel *label_money = [[UILabel alloc] init];
    _label_money = label_money;
    [imageV addSubview:label_money];
    [label_money setText:@"8888元" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:15]];
    [label_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV).offset(kDiv2(27));
        make.centerX.mas_equalTo(imageV);
        make.height.mas_equalTo(15);
    }];
    UILabel *label_hongbao = [UILabel new];
    [label_hongbao setText:@"红包" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:11]];
    _label_hongBao = label_hongbao;
    [imageV addSubview:label_hongbao];
    [label_hongbao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(imageV);
        make.top.mas_equalTo(label_money.mas_bottom).offset(kDiv2(10));
        make.height.mas_equalTo(11);
    }];
    // 是否已领取图
    UIImageView *signImgV = [[UIImageView alloc] init];
    _signImageV = signImgV;
    [imageV addSubview:signImgV];
    [signImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(imageV);
        make.width.height.mas_equalTo(kDiv2(80));
    }];
    signImgV.image = [UIImage imageNamed:@"icon_tequanhongbao_getten"];
    signImgV.hidden = YES;
    
    
    
    // 点击领取
    UILabel *label_lingqu = [[UILabel alloc] init];
    [label_lingqu setText:@"点击领取" textColor:kNavBarColor font:[UIFont systemFontOfSize:11 weight:UIFontWeightLight]];
    label_lingqu.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label_lingqu];
    [label_lingqu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).offset(kDiv2(27));
        make.centerX.mas_equalTo(imageV);
        make.height.mas_equalTo(kDiv2(40));
    }];
//    label_lingqu.layer.borderWidth = 0.5;
//    label_lingqu.layer.borderColor = kNavBarColor.CGColor;
//    [label_lingqu becomeCircleWithR:4];
    _label_lignqu = label_lingqu;
    
    UIView *lingquBG = [UIView new];
    [self.contentView addSubview:lingquBG];
    _lingquBGV = lingquBG;
    [lingquBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_label_lignqu);
        make.left.mas_equalTo(label_lingqu).offset(-5);
        make.right.mas_equalTo(label_lingqu).offset(5);
    }];
    lingquBG.layer.borderWidth = 0.5;
    lingquBG.layer.borderColor = kNavBarColor.CGColor;
    [lingquBG becomeCircleWithR:4];
}

- (void)setModel:(LBHongBaoModel *)model
{
    _model = model;
    self.label_money.text = [NSString stringWithFormat:@"%ld", (long)model.vmoney];
    NSDictionary *typeDic = @{@"0":@"现金红包", @"1":@"本金红包", @"2":@"体验金券"};
    self.label_hongBao.text = typeDic[[NSString stringWithFormat:@"%ld", (long)model.vtype]];
    self.signImageV.hidden = model.gtype != 1;
    switch (model.gtype) {
        case 0: { // 未领取
            self.imageV.image = [UIImage imageNamed:@"icon_tequanhongbao_sele"];
            [self liangquColor:YES];
            self.label_lignqu.text = @"点击领取";
            break;
        }
        case 1: { // 已领取
            self.imageV.image = [UIImage imageNamed:@"icon_tequanhongbao_nor"];
            [self liangquColor:NO];
            self.label_lignqu.text = @"已领取";
            break;
        }
        case 2: { // 等级不够
            self.imageV.image = [UIImage imageNamed:@"icon_tequanhongbao_nor"];
            [self liangquColor:NO];
            self.label_lignqu.text = self.levelDict[[NSString stringWithFormat:@"%ld", (long)model.vlevel]];
            break;
        }
            
        default:
            break;
    }
}

- (void)liangquColor:(BOOL)b
{
    if (b) {
        self.label_lignqu.textColor = kNavBarColor;
        self.lingquBGV.layer.borderColor = kNavBarColor.CGColor;
    } else {
        self.label_lignqu.textColor = kLightColor;
        self.lingquBGV.layer.borderColor = kLightColor.CGColor;
    }
}
- (NSDictionary *)levelDict
{
    if (_levelDict == nil) {
        _levelDict = @{
                       @"0":@"普通会员可领取",
                       @"1":@"铜牌会员可领取",
                       @"2":@"银牌会员可领取",
                       @"3":@"金牌会员可领取",
                       @"4":@"钻石会员可领取",
                       @"5":@"金钻会员可领取"
                       };
    }
    return _levelDict;
}



@end











