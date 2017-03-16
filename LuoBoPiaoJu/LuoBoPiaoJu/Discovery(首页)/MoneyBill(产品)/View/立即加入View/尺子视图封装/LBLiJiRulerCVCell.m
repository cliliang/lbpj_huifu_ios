//
//  LBLiJiRulerCVCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/28.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBLiJiRulerCVCell.h"

@implementation LBLiJiRulerCVCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.font = [UIFont systemFontOfSize:13];
        _label_num1 = label1;
        label1.text = @"0";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = [UIColor blackColor];
        [self.contentView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_left).offset(40);
            make.top.mas_equalTo(self.contentView.top).offset(35);
        }];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.font = [UIFont systemFontOfSize:13];
        _label_num2 = label2;
        label2.text = @"100";
        label2.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_left).offset(140);
            make.top.mas_equalTo(self.contentView.top).offset(35);
        }];
        
        [self addLine];
    }
    return self;
}

- (void)addLine
{
    for (int i = 0; i < 10; i++) {
        CGFloat x = i * 20;
        CGFloat y = 0;
        CGFloat width = 1;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 15)];
        view.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];
        [self.contentView addSubview:view];
        if (i == 2 || i == 7) {
            view.height = 20;
        }
    }
}


- (void)awakeFromNib {
    // Initialization code
}

@end
