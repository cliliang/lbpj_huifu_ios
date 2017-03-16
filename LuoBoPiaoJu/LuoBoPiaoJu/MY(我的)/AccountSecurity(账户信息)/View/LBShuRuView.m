//
//  LBShuRuView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBShuRuView.h"

@implementation LBShuRuView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeH:(NSString *)placeH
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 17.5, 70, 15)];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        [self addSubview:label];
        label.text = title;
        _label = label;
        
        // textField
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 17.5, kScreenWidth - 90 - 15, 15)];
        textField.placeholder = placeH;
        textField.textColor = [UIColor lightGrayColor];
        textField.font = [UIFont systemFontOfSize:15];
        [self addSubview:textField];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField = textField;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
        UIView *view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 1)];
        view_1.backgroundColor = kLineColor;
        [self addSubview:view_1];
        
    }
    return self;
}
















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
