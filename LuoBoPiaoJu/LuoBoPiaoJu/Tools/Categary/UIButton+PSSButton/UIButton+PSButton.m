//
//  UIButton+PSButton.m
//  WebView
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 PSS. All rights reserved.
//

#import "UIButton+PSButton.h"

@implementation UIButton (PSButton)

+ (UIButton *)buttonWithType:(UIButtonType)buttonType
                 normalColor:(UIColor *)normalColor
                   highColor:(UIColor *)highColor
                      target:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents
                       title:(NSString *)title
{
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highColor forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

+ (UIButton *)buttonWithType:(UIButtonType)buttonType
                 normalColor:(UIColor *)normalColor
                   highColor:(UIColor *)highColor
                    fontSize:(CGFloat)fontSize
                      target:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents
                       title:(NSString *)title
{
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highColor forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    return button;
}

/**
 文字button - RAC
 */
+ (UIButton *)buttonWithNormalColor:(UIColor *)normalColor
                          highColor:(UIColor *)highColor
                    backgroundColor:(UIColor *)backgroundColor
                           fontSize:(UIFont *)fontSize
                              title:(NSString *)title
{
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highColor forState:UIControlStateHighlighted];
    button.titleLabel.font = fontSize;
    button.titleLabel.font = fontSize;
    button.backgroundColor = backgroundColor;
    return button;
}

- (void)customClickStyle
{
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"buttonbutton"] forState:UIControlStateNormal];
}

@end
