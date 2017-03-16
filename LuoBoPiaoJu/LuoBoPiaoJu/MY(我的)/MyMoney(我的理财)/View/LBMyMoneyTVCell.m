//
//  LBMyMoneyTVCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyMoneyTVCell.h"

@interface LBMyMoneyTVCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_1;

@property (nonatomic, strong) UILabel *label_1; // -本金红包
@property (nonatomic, strong) UILabel *label_num1; // -本金红包num
@property (nonatomic, strong) UILabel *label_2; // -现金
@property (nonatomic, strong) UILabel *label_num2; // -现金num

@property (nonatomic, strong) UILabel *label_add;
@property (nonatomic, strong) UILabel *label_HBShouYi;

@property (nonatomic, strong) UILabel *label_hongBao;
@property (nonatomic, strong) UILabel *label_hongBaoNum;

@end

@implementation LBMyMoneyTVCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
//    self.view_bg.layer.cornerRadius = 4;
//    self.view_color.layer.cornerRadius = 4;
    self.contentView.backgroundColor = kBackgroundColor;
    [self.label_title setTextColor:kDeepColor];
    if (kIPHONE_5s) {
        _left_1.constant = _left_1.constant - 45;
    }
    
    // 1.添加本金
    _label_benJin = [UILabel new];
    [_label_benJin setText:@"本金(元)" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    [self.contentView addSubview:_label_benJin];
    
    _label_benJinMoney = [UILabel new];
    [_label_benJinMoney setText:@"10000" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    [self.contentView addSubview:_label_benJinMoney];
    
    _label_daiShouBenXi = [UILabel new];
    [_label_daiShouBenXi setText:@"待收本息(元)" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    [self.contentView addSubview:_label_daiShouBenXi];
    
    // 红包
    _label_hongBao = [UILabel new];
    [_label_hongBao setText:@"红包使用(元)" textColor:kNavBarColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    [self.contentView addSubview:_label_hongBao];
    _label_hongBaoNum = [UILabel new];
    [_label_hongBaoNum setText:@"1000" textColor:kNavBarColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    [self.contentView addSubview:_label_hongBaoNum];
    
    [_label_hongBaoNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view_bg).offset(-KAutoWDiv2(30));
        make.centerY.mas_equalTo(self.label_title);
        make.height.mas_equalTo(13);
    }];
    [_label_hongBao mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(_label_hongBaoNum.mas_left).offset(-KAutoWDiv2(16));
        make.right.mas_equalTo(self.view_bg).offset(-55);
        make.centerY.mas_equalTo(self.label_title);
        make.height.mas_equalTo(13);
    }];
    
    
    [_label_benJin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(13);
        make.left.mas_equalTo(self.view_bg).offset(KAutoWDiv2(48));
        make.bottom.mas_equalTo(self.view_bg).offset(kDiv2(-29));
    }];
    [_label_benJinMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(13);
        make.top.mas_equalTo(self.view_color.mas_bottom).offset(kDiv2(35));
        make.centerX.mas_equalTo(_label_benJin);
    }];
    
    [_label_daiShouBenXi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(13);
        make.right.mas_equalTo(self.view_bg).offset(-KAutoWDiv2(80));
        make.bottom.mas_equalTo(_label_benJin);
    }];
    
    // ** + **
    // 1.view
    UIView *addView = [[UIView alloc] init];
    [self.contentView addSubview:addView];
    
    _label_add = [UILabel new];
    [_label_add setText:@"+" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    [addView addSubview:_label_add];
    
    _label_HBShouYi = [UILabel new];
    [_label_HBShouYi setText:@"2.00" textColor:kNavBarColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    [addView addSubview:_label_HBShouYi];
    
    _label_daiShouBenJinMoney = [UILabel new];
    [_label_daiShouBenJinMoney setText:@"10000.00" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
    [addView addSubview:_label_daiShouBenJinMoney];
    
    [_label_daiShouBenJinMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(addView);
        make.height.mas_equalTo(13);
    }];
    [_label_add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_label_daiShouBenJinMoney.mas_right);
        make.right.mas_equalTo(_label_HBShouYi.mas_left);
        make.height.mas_equalTo(13);
        make.centerY.mas_equalTo(_label_daiShouBenJinMoney);
    }];
    [_label_HBShouYi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_label_add);
        make.height.mas_equalTo(13);
        make.right.mas_equalTo(addView);
    }];
    [addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_label_benJinMoney);
        make.centerX.mas_equalTo(_label_daiShouBenXi);
    }];
    
    
    /*
     UILabel *label1 = [UILabel new];
     [label1 setText:@"本金红包(元)" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight]];
     [self.contentView addSubview:label1];
     
     UILabel *label_num1 = [UILabel new];
     [label_num1 setText:@"1000.00" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight]];
     [self.contentView addSubview:label_num1];
     
     UILabel *label2 = [UILabel new];
     [label2 setText:@"现金红包(元)" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight]];
     [self.contentView addSubview:label2];
     
     UILabel *label_num2 = [UILabel new];
     [label_num2 setText:@"1000.00" textColor:kDeepColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightUltraLight]];
     [self.contentView addSubview:label_num2];
     
     
     [_label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.mas_equalTo(self.contentView).offset(30);
     make.height.mas_equalTo(13);
     make.top.mas_equalTo(self.label_benJin.mas_bottom).offset(kLabelTop);
     }];
     [_label_num1 mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.mas_equalTo(_label_1.mas_right).offset(10);
     make.height.mas_equalTo(13);
     make.top.mas_equalTo(_label_1);
     }];
     [_label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.mas_equalTo(_label_1);
     make.top.mas_equalTo(_label_1.mas_bottom).offset(kLabelTop);
     make.height.mas_equalTo(13);
     }];
     [_label_num2 mas_makeConstraints:^(MASConstraintMaker *make) {
     make.left.mas_equalTo(_label_2.mas_right).offset(10);
     make.height.mas_equalTo(13);
     make.top.mas_equalTo(_label_2);
     }];
     
     _label_1 = label1;
     _label_num1 = label_num1;
     _label_2 = label2;
     _label_num2 = label_num2;
     */
}

- (void)setModel:(LBOrderModel *)model
{
    _model = model;
    
    NSArray *sArr = [model.createTime componentsSeparatedByString:@" "];
    NSString *str1 = sArr[0];
    NSString *str2 = model.endTime;
    NSInteger dayCount = [NSDate compareDate1:str1 date2:str2];
    if (model.gcId == 13) {
        dayCount = 30;
    }
    self.label_title.text = model.goodName;
    self.label_benJinMoney.text = [NSString stringWithFormat:@"%d", (int)model.countMoney];
    self.label_daiShouBenJinMoney.text = [NSString stringWithFormat:@"%.2lf", model.countMoney * (1 + dayCount * [model.proceeds doubleValue] / 36500)];
    
    
    double allHongbao = model.cashMoney + model.principalMoney;
    if (model.gcId == 0) { // 体验金
        self.label_daiShouBenXi.text = @"待收利息";
        self.label_daiShouBenJinMoney.text = [NSString stringWithFormat:@"%.2lf", model.preProceeds];
    } else if (model.gcId == 13) { // 活期
        CGFloat moneys = model.countMoney;
        self.label_daiShouBenXi.text = @"预计30天本息";
        CGFloat resMoney = moneys * 1.0 * pow((1 + [model.proceeds doubleValue] / 36500), 30);
        self.label_daiShouBenJinMoney.text = [NSString stringWithFormat:@"%.2lf", resMoney];
    }
    
    
    if (allHongbao) {
        [_label_daiShouBenJinMoney.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_label_HBShouYi);
        }];
        _label_add.hidden = NO;
        _label_HBShouYi.hidden = NO;
        _label_hongBao.hidden = NO;
        _label_hongBaoNum.hidden = NO;
        self.label_hongBaoNum.text = [self stringWithFloat:allHongbao];
        double hbShouYi = allHongbao * [model.proceeds doubleValue] / 36500 * dayCount + model.cashMoney;
        self.label_HBShouYi.text = [NSString stringWithFormat:@"%.2lf", hbShouYi];
    } else {
        [_label_daiShouBenJinMoney.superview mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_label_daiShouBenJinMoney);
        }];
        _label_add.hidden = YES;
        _label_HBShouYi.hidden = YES;
        _label_hongBao.hidden = YES;
        _label_hongBaoNum.hidden = YES;
    }
}

/*
- (void)setModel:(LBOrderModel *)model
{
    _model = model;
    self.label_title.text = model.goodName;
    self.label_benJinMoney.text = [NSString stringWithFormat:@"%d", (int)model.countMoney];
    self.label_daiShouBenJinMoney.text = [NSString stringWithFormat:@"%.2lf", model.countMoney + model.preProceeds];
    if (model.gcId == 0) { // 体验金
        self.label_daiShouBenXi.text = @"待收利息";
        self.label_daiShouBenJinMoney.text = [NSString stringWithFormat:@"%.2lf", model.preProceeds];
    } else if (model.gcId == 13) { // 活期
        CGFloat moneys = model.principalMoney + model.countMoney;
        self.label_daiShouBenXi.text = @"预计30天本息";
        CGFloat resMoney = moneys * 1.0 * pow((1 + [model.proceeds floatValue] / 36500), 30) - model.principalMoney;
        self.label_daiShouBenJinMoney.text = [NSString stringWithFormat:@"%.2lf", resMoney];
    }
    
    _label_num1.text = [self stringWithFloat:model.principalMoney];
    _label_num2.text = [self stringWithFloat:model.cashMoney];
    _label_1.hidden = YES;
    _label_num1.hidden = YES;
    _label_2.hidden = YES;
    _label_num2.hidden = YES;
    NSMutableArray *labelArr = [NSMutableArray new];
    NSMutableArray *labelNumArr = [NSMutableArray new];
    BOOL b1 = model.principalMoney;
    BOOL b2 = model.cashMoney;
    if (b1) {
        [labelArr addObject:_label_1];
        [labelNumArr addObject:_label_num1];
    }
    if (b2) {
        [labelArr addObject:_label_2];
        [labelNumArr addObject:_label_num2];
    }
    if (labelArr.count) {
        UILabel *label_1 = labelArr[0];
        UILabel *label_num1 = labelNumArr[0];
        [label_1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(30);
            make.height.mas_equalTo(13);
            make.top.mas_equalTo(self.label_benJin.mas_bottom).offset(kLabelTop);
        }];
        [label_num1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(label_1.mas_right).offset(10);
            make.height.mas_equalTo(13);
            make.top.mas_equalTo(label_1);
        }];
        label_1.hidden = NO;
        label_num1.hidden = NO;
        if (labelArr.count > 1) {
            for (int i = 0; i < labelArr.count; i++) {
                if (i == 0) {
                    continue;
                }
                UILabel *label_0 = labelArr[i - 1];
                UILabel *label_1 = labelArr[i];
                UILabel *label_num1 = labelNumArr[i];
                label_1.hidden = NO;
                label_num1.hidden = NO;
                [label_1 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(13);
                    make.top.mas_equalTo(label_0.mas_bottom).offset(kLabelTop * i);
                    make.left.mas_equalTo(self.contentView).offset(30);
                }];
                [label_num1 mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(label_1);
                    make.height.mas_equalTo(13);
                    make.left.mas_equalTo(label_1.mas_right).offset(10);
                }];
            }
        }
    }
    
}


 */

- (NSString *)stringWithFloat:(CGFloat)num
{
    int intN = (int)num;
    if (num - intN > 0.009999) {
        return [NSString stringWithFormat:@"%.2f", num];
    } else {
        return [NSString stringWithFormat:@"%d", intN];
    }
}

@end
