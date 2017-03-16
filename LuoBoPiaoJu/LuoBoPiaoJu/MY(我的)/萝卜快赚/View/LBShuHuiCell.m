//
//  LBShuHuiCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBShuHuiCell.h"

@implementation LBShuHuiCell

- (void)awakeFromNib {
    // Initialization code
    self.btn_shuhui.layer.cornerRadius = 4;
    self.btn_shuhui.userInteractionEnabled = NO;
    self.btn_shuhui.backgroundColor = kNavBarColor;
}

- (void)setModel:(LBOrderModel *)model
{
    _model = model;
    self.label_title.text = model.goodName;
    self.label_leijishouyiNum.text = [NSString stringWithFormat:@"%.2lf", model.sumEarn];
    self.label_chicangbenjin.text = [NSString stringWithFormat:@"%.2lf", model.speedMoney];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
