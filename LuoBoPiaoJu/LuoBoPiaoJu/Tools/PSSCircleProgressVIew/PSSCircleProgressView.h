//
//  PSSCircleProgressView.h
//  CAShapeLayerLearning
//
//  Created by 庞仕山 on 16/4/27.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

/*
 1、CAShapeLayer继承自CALayer，可使用CALayer的所有属性
 2、CAShapeLayer需要和贝塞尔曲线配合使用才有意义。
 Shape：形状
 贝塞尔曲线可以为其提供形状，而单独使用CAShapeLayer是没有任何意义的。
 3、使用CAShapeLayer与贝塞尔曲线可以实现不在view的DrawRect方法中画出一些想要的图形
 
 关于CAShapeLayer和DrawRect的比较
 DrawRect：DrawRect属于CoreGraphic框架，占用CPU，消耗性能大
 CAShapeLayer：CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU，不消耗内存
 */

#import <UIKit/UIKit.h>

@interface PSSCircleProgressView : UIView

@property (nonatomic, assign) CGFloat strokeStart;
@property (nonatomic, assign) CGFloat strokeEnd;

- (instancetype)initWithFrame:(CGRect)frame
                    lineWidth:(CGFloat)lineWidth
              unfinishedColor:(UIColor *)unfinishedColor
                finishedColor:(UIColor *)finishedColor;

- (void)animationWithTime:(CGFloat)time;



@end





