//
//  LBMyMoneyCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyMoneyCell.h"

@implementation LBMyMoneyCell

- (void)awakeFromNib {
    // Initialization code
    self.view_Color.layer.cornerRadius = 15 / 2;
    if (kIPHONE_5s) {
        self.left_centerNum.constant = 160;
        self.left_imageV.constant = 40;
        self.right_money.constant = 40;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
