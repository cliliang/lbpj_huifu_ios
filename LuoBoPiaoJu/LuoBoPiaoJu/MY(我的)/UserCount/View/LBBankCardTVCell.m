//
//  LBBankCardTVCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBBankCardTVCell.h"

@implementation LBBankCardTVCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(LBBankCardInfoModel *)model
{
    _model = model;
    self.label_danBiXianE.text = model.danBiXianE;
    self.label_dangRiXianE.text = model.dangRiXianE;
    self.label_bankCardName.text = model.bankCardCode;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
