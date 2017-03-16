//
//  LBMainMoreCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/3.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMainMoreCell.h"

@implementation LBMainMoreCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.bottomView.backgroundColor = kLineColor;
    self.label_title.textColor = kDeepColor;
    self.label_banbenInfo.textColor = kLightColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
