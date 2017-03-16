//
//  PSSCircleProgressView.m
//  CAShapeLayerLearning
//
//  Created by 庞仕山 on 16/4/27.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSCircleProgressView.h"

@interface PSSCircleProgressView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) UIColor *finishedColor;
@property (nonatomic, strong) UIColor *unfinishedColor;

@end

@implementation PSSCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame
                    lineWidth:(CGFloat)lineWidth
              unfinishedColor:(UIColor *)unfinishedColor
                finishedColor:(UIColor *)finishedColor
{
    if (self = [super initWithFrame:frame]) {
        _finishedColor = finishedColor;
        _unfinishedColor = unfinishedColor;
        [self drawBackgroundLineWithColor:unfinishedColor  width:lineWidth frame:self.bounds];
        [self drawFinishedLineWithFrame:self.bounds finishedColor:finishedColor width:lineWidth];
    }
    return self;
}

- (void)drawBackgroundLineWithColor:(UIColor *)unfinishedColor width:(CGFloat)width frame:(CGRect)frame
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = frame; // 设置尺寸和位置
    shapeLayer.position = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
    shapeLayer.fillColor = [UIColor clearColor].CGColor; // 填充颜色，必须给
    
    // 设置线条的宽度和颜色
    shapeLayer.lineWidth = width;
    shapeLayer.strokeColor = unfinishedColor.CGColor; // 画笔颜色
    
    // 创建出圆形贝塞尔曲线
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    // 让贝塞尔曲线和CAShapeLayer产生联系
    shapeLayer.path = circlePath.CGPath;
    
    // 显示并添加
    [self.layer addSublayer:shapeLayer];
    
    // 设置stroke起始点，1是一圈，0.5是半圈
    // 开始位置：右侧
    // 绘画顺序：顺时针
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    // 旋转视图
    self.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
}

- (void)drawFinishedLineWithFrame:(CGRect)frame finishedColor:(UIColor *)finishedColor width:(CGFloat)width
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = frame;
    self.shapeLayer.lineWidth = width;
    self.shapeLayer.strokeColor = finishedColor.CGColor;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    self.shapeLayer.path = bezierPath.CGPath;
    self.shapeLayer.strokeStart = self.strokeStart;
    self.shapeLayer.strokeEnd = self.strokeEnd;
    [self.layer addSublayer:self.shapeLayer];
}

- (void)setStrokeStart:(CGFloat)strokeStart
{
    _strokeStart = strokeStart;
    _shapeLayer.strokeStart = strokeStart;
}

- (void)setStrokeEnd:(CGFloat)strokeEnd
{
    _strokeEnd = strokeEnd;
    _shapeLayer.strokeEnd = strokeEnd;
}

- (void)animationWithTime:(CGFloat)time
{
    if (_strokeEnd == 1.0) {
        self.shapeLayer.strokeColor = _unfinishedColor.CGColor;
    } else {
        self.shapeLayer.strokeColor = _finishedColor.CGColor;
    }
    CABasicAnimation *baseAni = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    baseAni.duration = time;
    baseAni.fromValue = [NSNumber numberWithFloat:_strokeStart];
    baseAni.toValue = [NSNumber numberWithFloat:_strokeEnd];
    [self.shapeLayer addAnimation:baseAni forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
