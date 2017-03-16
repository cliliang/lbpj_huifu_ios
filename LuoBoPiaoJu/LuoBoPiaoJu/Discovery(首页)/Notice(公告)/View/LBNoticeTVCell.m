//
//  LBNoticeTVCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBNoticeTVCell.h"

@implementation LBNoticeTVCell

- (void)setModel:(LBGongGaoModel *)model
{
    _model = model;
    self.label_title.text = model.newsTitle;
    self.label_content.text = model.newsContent;
    self.label_time.text = model.createTime;
    
}

- (void)awakeFromNib {
    // Initialization code
    self.label_title.textColor = kDeepColor;
    self.label_content.textColor = kLightColor;
    self.label_time.textColor = kLightColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end



