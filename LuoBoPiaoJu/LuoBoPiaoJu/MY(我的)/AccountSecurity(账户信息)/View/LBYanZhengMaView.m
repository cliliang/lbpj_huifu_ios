//
//  LBYanZhengMaView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBYanZhengMaView.h"
#import "LBYanZhengMaTimer.h"

@implementation LBYanZhengMaView

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
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 17.5, kScreenWidth - 90 - 15 - 80, 15)];
        textField.placeholder = placeH;
        textField.textColor = [UIColor lightGrayColor];
        textField.font = [UIFont systemFontOfSize:15];
        [self addSubview:textField];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField = textField;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        view.backgroundColor = kLineColor;
        UIView *view_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 50, kScreenWidth, 1)];
        view_1.backgroundColor = kLineColor;
        [self addSubview:view_1];
        
        // button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"发送验证码" forState:UIControlStateNormal];
        button.frame = CGRectMake(kScreenWidth - 95, 17.5, 80, 15);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _button = button;
        
        
    }
    return self;
}

- (void)clickButton:(UIButton *)sender
{
    if (self.textField.text.length != 11) {
        [[PSSToast shareToast] showMessage:@"手机号格式不正确"];
        return;
    }
    self.button.userInteractionEnabled = NO;
    LBYanZhengMaTimer *timer = [[LBYanZhengMaTimer alloc] init];
    [timer setTimeBlock:^(NSInteger second) {
        if (second == 0) {
            self.button.titleLabel.text = @"获取验证码"; // 位置决定是否闪烁
            [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
            [sender setTitle:@"获取验证码" forState:UIControlStateHighlighted];
            [sender setTitle:@"获取验证码" forState:UIControlStateSelected];
            self.button.userInteractionEnabled = YES;
        } else {
            self.button.titleLabel.text = [NSString stringWithFormat:@"%ld秒", second];
            [sender setTitle:[NSString stringWithFormat:@"%ld秒", second] forState:UIControlStateHighlighted];
            [sender setTitle:[NSString stringWithFormat:@"%ld秒", second] forState:UIControlStateNormal];
            [sender setTitle:[NSString stringWithFormat:@"%ld秒", second] forState:UIControlStateSelected];
        }
    }];
    [timer timeFire];
    if (self.buttonBlock) {
        self.buttonBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
