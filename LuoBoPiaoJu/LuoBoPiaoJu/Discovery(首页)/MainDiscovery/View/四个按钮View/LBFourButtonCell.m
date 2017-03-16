//
//  LBFourButtonCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFourButtonCell.h"

@interface LBFourButtonCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_biaoti; // 标题距离图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_miaoshu; // 描述距离上边


@end

@implementation LBFourButtonCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.label_miaoShu.textColor = kLightColor;
    self.label_title.textColor = [UIColor colorWithRGBString:@"3d3d3d"];
    
    if (kIPHONE_6P) {
        _top_image.constant = 13;
        _top_biaoti.constant = 10;
        _top_miaoshu.constant = 8;
    }
//    self.layer.cornerRadius = 4;
}

@end
