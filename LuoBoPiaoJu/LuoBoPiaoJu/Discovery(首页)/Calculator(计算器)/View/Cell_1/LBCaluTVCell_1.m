//
//  LBCaluTVCell_1.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCaluTVCell_1.h"

@interface LBCaluTVCell_1 ()

@end

@implementation LBCaluTVCell_1



- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.backgroundColor = kBackgroundColor;
    UILabel *label = [[UILabel alloc] init];
    CGFloat fontSize = 15;
    if (kIPHONE_5s) {
        fontSize = 13;
    }
    [label setText:@"票面金额(万元)" textColor:kDeepColor font:[UIFont systemFontOfSize:fontSize weight:UIFontWeightLight]];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView).offset(div_2(30) / 2);
        make.left.mas_equalTo(self.contentView).offset(15);
    }];
    _label = label;
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view];
    [view becomeCircleWithR:4];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(div_2(68));
        make.width.mas_equalTo(kAutoW(div_2(464)));
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.centerY.mas_equalTo(self.contentView).offset(div_2(30) / 2);
    }];
    _whiteView = view;
    
    UITextField *textF = [[UITextField alloc] init];
    textF.borderStyle = UITextBorderStyleNone;
    textF.placeholder = @"输入金额";
    textF.textColor = kDeepColor;
    [view addSubview:textF];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_equalTo(view);
        make.left.mas_equalTo(view).offset(15);
    }];
    _textField = textF;
    textF.keyboardType = UIKeyboardTypeDecimalPad;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
