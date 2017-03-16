//
//  LBCaluTVCell_3.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCaluTVCell_3.h"

@implementation LBCaluTVCell_3

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = kBackgroundColor;
    
    UILabel *label = [UILabel new];
    [label setText:@"计息天数" textColor:kDeepColor font:[UIFont systemFontOfSize:15]];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView).offset(div_2(30) / 2);
    }];
    _label = label;
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor whiteColor] highColor:[UIColor whiteColor] fontSize:15 target:self action:@selector(clickCalcBtn) forControlEvents:UIControlEventTouchUpInside title:@"再计算"];
    btn.backgroundColor = [UIColor whiteColor];
    [btn becomeCircleWithR:4];
    [self.contentView addSubview:btn];
    _btn = btn;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(label);
        make.width.mas_equalTo(kAutoH(div_2(160)));
        make.height.mas_equalTo(div_2(68));
    }];
    
    // textField
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [view becomeCircleWithR:4];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(btn.mas_left).offset(-15);
        make.centerY.mas_equalTo(btn);
        make.width.mas_equalTo(kAutoH(div_2(273)));
        make.height.mas_equalTo(div_2(68));
    }];
    
    UITextField *textF = [[UITextField alloc] init];
    textF.placeholder = @"0.00元";
    textF.textColor = kDeepColor;
    [view addSubview:textF];
    _textField = textF;
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(view);
        make.left.mas_equalTo(view).offset(15);
    }];
    
    
    // 添加长按
    UILongPressGestureRecognizer *longPre = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyResultNum:)];
    longPre.minimumPressDuration = 0.5;
    [view addGestureRecognizer:longPre];
    
    
    [self setBackImageBtn:btn];
}
- (void)setBackImageBtn:(UIButton *)btn
{
    [btn setBackgroundImage:[UIImage imageNamed:@"bg_calc2_nor"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"bg_calc2_sele"] forState:UIControlStateHighlighted];
}

- (void)clickCalcBtn
{
    if (self.clickBtn) {
        self.clickBtn();
    }
}
- (void)copyResultNum:(UILongPressGestureRecognizer *)longPre
{
    if (longPre.state == 1) {
        if (self.longPreBlock) {
            self.longPreBlock(_textField.text);
        }
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end





