//
//  LBConnectUsCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBConnectUsCell.h"

@interface LBConnectUsCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation LBConnectUsCell

- (void)awakeFromNib {
    // Initialization code
    self.lineView.backgroundColor = [UIColor colorWithRGBString:@"e7e7e7"];
    self.label_title.textColor = kDeepColor;
    self.label_content.textColor = kDeepColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
