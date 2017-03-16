//
//  LBCirclePathView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBCirclePathView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                      number1:(CGFloat)number1
                       color1:(UIColor *)color1
                      number2:(CGFloat)number2
                       color2:(UIColor *)color2
                      number3:(CGFloat)number3
                       color3:(UIColor *)color3
                      number4:(CGFloat)number4
                       color4:(UIColor *)color4
                      number5:(CGFloat)number5
                       color5:(UIColor *)color5
                        width:(CGFloat)width
                         time:(CGFloat)time
                    lineWidth:(CGFloat)lineWidth;

- (instancetype)initWithFrame:(CGRect)frame
                   colorArray:(NSArray *)colorArr
                    numberArr:(NSArray *)numArr
                        width:(CGFloat)width
                         time:(CGFloat)time
                    lineWidth:(CGFloat)lineWidth;

@end
