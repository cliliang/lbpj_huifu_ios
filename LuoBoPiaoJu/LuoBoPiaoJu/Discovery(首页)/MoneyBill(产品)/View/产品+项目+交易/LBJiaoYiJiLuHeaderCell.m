//
//  LBJiaoYiJiLuHeaderCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBJiaoYiJiLuHeaderCell.h"
#import <CoreText/CoreText.h>

@interface LBJiaoYiJiLuHeaderCell ()

// 原本27, 5s不变, 其他调整
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *letf_dingDanBianHao;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_xiaDanShiJian; // 29


@end

@implementation LBJiaoYiJiLuHeaderCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    if (kIPHONE_6s) {
        self.letf_dingDanBianHao.constant = 35;
        self.right_xiaDanShiJian.constant = 37;
    }
    
    if (kIPHONE_6P) {
        self.letf_dingDanBianHao.constant = 41;
        self.right_xiaDanShiJian.constant = 43;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
