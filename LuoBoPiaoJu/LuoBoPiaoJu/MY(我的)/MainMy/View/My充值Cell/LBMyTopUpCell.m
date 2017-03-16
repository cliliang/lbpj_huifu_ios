//
//  LBMyTopUpCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyTopUpCell.h"

@interface LBMyTopUpCell ()

@property (weak, nonatomic) IBOutlet UILabel *label_money;
/**
 *  button背景图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *btnBackImageView;
/**
 *  充值按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_topUp;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation LBMyTopUpCell


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label_money.text = self.moneyString;
}

- (void)awakeFromNib {
    // Initialization code
    self.btn_topUp.backgroundColor = kNavBarColor;
    self.btn_topUp.layer.cornerRadius = 4;
    self.bottomLineView.backgroundColor = kLineColor;
//    [self.btn_topUp customClickStyle];
    [self.btn_topUp setBackgroundImage:[UIImage imageNamed:@"button_small_normal"] forState:UIControlStateNormal];
    [self.btn_topUp setBackgroundImage:[UIImage imageNamed:@"button_small_select"] forState:UIControlStateHighlighted];
}

- (IBAction)clickTopUpButton:(id)sender {
    if (self.topUpBlock) {
        self.topUpBlock();
    }
}

- (void)setMoneyString:(NSString *)moneyString
{
    _moneyString = moneyString;
    _label_money.text = moneyString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
