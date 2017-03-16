//
//  LBAnQuanCircleView.h
//  圆形进度条
//
//  Created by 庞仕山 on 16/6/12.
//  Copyright © 2016年 andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBAnQuanCircleView : UIView

// progress 0-1
- (instancetype)initWithFrame:(CGRect)frame
                    backWidth:(CGFloat)backWidth
                   frontWidth:(CGFloat)frontWith
                     progress:(CGFloat)progress
                    fromColor:(UIColor *)fromColor
                      toColor:(UIColor *)toColor;


- (void)animationStartWithTime:(CGFloat)time;


@end
