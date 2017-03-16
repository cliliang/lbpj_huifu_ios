//
//  UIButton+PSButton.h
//  WebView
//
//  Created by lanou3g on 15/10/16.
//  Copyright (c) 2015年 PSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (PSButton)

/**
 不带font, 文字类button
 */
+ (UIButton *)buttonWithType:(UIButtonType)buttonType
                 normalColor:(UIColor *)normalColor
                   highColor:(UIColor *)highColor
                      target:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents
                       title:(NSString *)title;

/**
 *  带font的button
 */
+ (UIButton *)buttonWithType:(UIButtonType)buttonType
                 normalColor:(UIColor *)normalColor
                   highColor:(UIColor *)highColor
                    fontSize:(CGFloat)fontSize
                      target:(id)target
                      action:(SEL)action
            forControlEvents:(UIControlEvents)controlEvents
                       title:(NSString *)title;


/**
 文字button - RAC
 */
+ (UIButton *)buttonWithNormalColor:(UIColor *)normalColor
                          highColor:(UIColor *)highColor
                    backgroundColor:(UIColor *)backgroundColor
                           fontSize:(UIFont *)fontSize
                              title:(NSString *)title;

// 白字, 红底色
- (void)customClickStyle;

@end
