//
//  LBJiaoYiJiLuCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBJiaoYiJiLuCell.h"
#import <CoreText/CoreText.h>

@interface LBJiaoYiJiLuCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *letf_yinHangKaHao; // 15
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_shiJian; // 15


@end

@implementation LBJiaoYiJiLuCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    if (kIPHONE_6s) {
        _letf_yinHangKaHao.constant = 27;
        _right_shiJian.constant = 20;
    }
    
    if (kIPHONE_6P) {
        _letf_yinHangKaHao.constant = 33;
        _right_shiJian.constant = 25;
    }
//    self.label_xiadanTime.font = [UIFont fontWithName:@"AppleSDGothicNeo-Thin" size:11];
}

- (void)setModel:(LBOrderModel *)model
{
    _model = model;
    NSString *orderNo = model.buyOrderNo;
    
    self.label_dingdanbianhaoNum.text = [NSString stringWithFormat:@"%@****%@", [orderNo substringToIndex:3], [orderNo substringFromIndex:orderNo.length - 4]];
    self.label_money.text = [NSString stringWithFormat:@"%d", (int)model.countMoney];
    self.label_xiadanTime.text = model.createTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
