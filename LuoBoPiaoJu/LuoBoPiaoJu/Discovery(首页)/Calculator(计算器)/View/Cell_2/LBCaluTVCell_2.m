
//
//  LBCaluTVCell_2.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCaluTVCell_2.h"

@implementation LBCaluTVCell_2

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = kBackgroundColor;
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor whiteColor] highColor:[UIColor whiteColor] fontSize:15 target:self action:@selector(clickCleanBtn) forControlEvents:UIControlEventTouchUpInside title:@"清除"];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor whiteColor] highColor:[UIColor whiteColor] fontSize:15 target:self action:@selector(clickCalcBtn) forControlEvents:UIControlEventTouchUpInside title:@"计算"];
    [self.contentView addSubview:btn0];
    [self.contentView addSubview:btn1];
    
    [btn0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(btn1.mas_left).offset(-15);
        make.width.mas_equalTo(btn1);
        make.top.mas_equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(40);
    }];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.top.mas_equalTo(btn0);
        make.height.mas_equalTo(40);
    }];
    
    [self setBackImageBtn:btn0];
    [self setBackImageBtn:btn1];
    
    btn0.backgroundColor = [UIColor whiteColor];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn0 becomeCircleWithR:4];
    [btn1 becomeCircleWithR:4];
}

- (void)setBackImageBtn:(UIButton *)btn
{
    [btn setBackgroundImage:[UIImage imageNamed:@"bg_calc_nor"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"bg_calc_sele"] forState:UIControlStateHighlighted];
}

- (void)clickCleanBtn
{
    if (self.btnBlock) {
        self.btnBlock(0);
    }
}
- (void)clickCalcBtn
{
    if (self.btnBlock) {
        self.btnBlock(1);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
