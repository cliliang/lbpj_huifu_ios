//
//  LBCirclePathView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCirclePathView.h"

@interface LBCirclePathView () 

@property (nonatomic, strong) CAShapeLayer *shapeLayer_1;
@property (nonatomic, strong) CAShapeLayer *shapeLayer_2;
@property (nonatomic, strong) CAShapeLayer *shapeLayer_3;
@property (nonatomic, strong) CAShapeLayer *shapeLayer_4;
@property (nonatomic, strong) CAShapeLayer *shapeLayer_5;

@property (nonatomic, assign) CGFloat time1;
@property (nonatomic, assign) CGFloat time2;
@property (nonatomic, assign) CGFloat time3;
@property (nonatomic, assign) CGFloat time4;
@property (nonatomic, assign) CGFloat time5;
@property (nonatomic, assign) CGFloat time;

@property (nonatomic, assign) CGFloat start1;
@property (nonatomic, assign) CGFloat start2;
@property (nonatomic, assign) CGFloat start3;
@property (nonatomic, assign) CGFloat start4;
@property (nonatomic, assign) CGFloat start5;

@property (nonatomic, assign) CGFloat end1;
@property (nonatomic, assign) CGFloat end2;
@property (nonatomic, assign) CGFloat end3;
@property (nonatomic, assign) CGFloat end4;
@property (nonatomic, assign) CGFloat end5;

@property (nonatomic, assign) CGFloat eachTime;
@property (nonatomic, assign) CGFloat allTime;
@property (nonatomic, assign) CGFloat eachPro;
@property (nonatomic, assign) CGFloat allPro;

@end

@implementation LBCirclePathView

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
                    lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat total = number1 + number2 + number3 + number4 + number5;
        CGFloat pro1 = number1 / total;
        CGFloat pro2 = number2 / total;
        CGFloat pro3 = number3 / total;
        CGFloat pro4 = number4 / total;
        CGFloat pro5 = number5 / total;
        if (total == 0) {
            pro1 = 0;
            pro2 = 0;
            pro3 = 0;
            pro4 = 0;
            pro5 = 1;
        }
        
        _end1 = 0 + pro1;
        _end2 = _end1 + pro2;
        _end3 = _end2 + pro3;
        _end4 = _end3 + pro4;
        _end5 = 1.0;
        
        _start1 = 0;
        _start2 = _start1 + pro1;
        _start3 = _start2 + pro2;
        _start4 = _start3 + pro3;
        _start5 = _start4 + pro4;
        
        _time = time;
        _time1 = time * pro1;
        _time2 = time * pro2;
        _time3 = time * pro3;
        _time4 = time * pro4;
        _time5 = time * pro5;
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        
        _shapeLayer_1 = [CAShapeLayer layer];
        _shapeLayer_1.frame = self.bounds;
        _shapeLayer_1.lineWidth = lineWidth;
        _shapeLayer_1.strokeColor = color1.CGColor;
        _shapeLayer_1.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer_1.path = bezierPath.CGPath;
        _shapeLayer_1.strokeStart = _start1;
        _shapeLayer_1.strokeEnd = _end1;
        [self.layer addSublayer:_shapeLayer_1];
        
        CABasicAnimation *pathAnimation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation1.duration = _time1;
        pathAnimation1.fromValue = [NSNumber numberWithFloat:_start1];
        pathAnimation1.toValue = [NSNumber numberWithFloat:_end1];
        [_shapeLayer_1 addAnimation:pathAnimation1 forKey:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_end1 * time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _shapeLayer_2 = [CAShapeLayer layer];
            _shapeLayer_2.frame = self.bounds;
            _shapeLayer_2.lineWidth = lineWidth;
            _shapeLayer_2.strokeColor = color2.CGColor;
            _shapeLayer_2.fillColor = [UIColor clearColor].CGColor;
            _shapeLayer_2.path = bezierPath.CGPath;
            _shapeLayer_2.strokeStart = _start2;
            _shapeLayer_2.strokeEnd = _end2;
            [self.layer addSublayer:_shapeLayer_2];
            CABasicAnimation *pathAnimation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation2.duration = _time2;
            pathAnimation2.fromValue = [NSNumber numberWithFloat:_start2];
            pathAnimation2.toValue = [NSNumber numberWithFloat:_end2];
            [_shapeLayer_2 addAnimation:pathAnimation2 forKey:nil];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_end2 * time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _shapeLayer_3 = [CAShapeLayer layer];
            _shapeLayer_3.frame = self.bounds;
            _shapeLayer_3.lineWidth = lineWidth;
            _shapeLayer_3.strokeColor = color3.CGColor;
            _shapeLayer_3.fillColor = [UIColor clearColor].CGColor;
            _shapeLayer_3.path = bezierPath.CGPath;
            _shapeLayer_3.strokeStart = _start3;
            _shapeLayer_3.strokeEnd = _end3;
            [self.layer addSublayer:_shapeLayer_3];
            CABasicAnimation *pathAnimation3 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation3.duration = _time3;
            pathAnimation3.fromValue = [NSNumber numberWithFloat:_start3];
            pathAnimation3.toValue = [NSNumber numberWithFloat:_end3];
            [_shapeLayer_3 addAnimation:pathAnimation3 forKey:nil];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_end3 * time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _shapeLayer_4 = [CAShapeLayer layer];
            _shapeLayer_4.frame = self.bounds;
            _shapeLayer_4.lineWidth = lineWidth;
            _shapeLayer_4.strokeColor = color4.CGColor;
            _shapeLayer_4.fillColor = [UIColor clearColor].CGColor;
            _shapeLayer_4.path = bezierPath.CGPath;
            _shapeLayer_4.strokeStart = _start4;
            _shapeLayer_4.strokeEnd = _end4;
            [self.layer addSublayer:_shapeLayer_4];
            CABasicAnimation *pathAnimation4 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation4.duration = _time4;
            pathAnimation4.fromValue = [NSNumber numberWithFloat:_start4];
            pathAnimation4.toValue = [NSNumber numberWithFloat:_end4];
            [_shapeLayer_4 addAnimation:pathAnimation4 forKey:nil];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_end4 * time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _shapeLayer_5 = [CAShapeLayer layer];
            _shapeLayer_5.frame = self.bounds;
            _shapeLayer_5.lineWidth = lineWidth;
            _shapeLayer_5.strokeColor = color5.CGColor;
            _shapeLayer_5.fillColor = [UIColor clearColor].CGColor;
            _shapeLayer_5.path = bezierPath.CGPath;
            _shapeLayer_5.strokeStart = _start5;
            _shapeLayer_5.strokeEnd = _end5;
            [self.layer addSublayer:_shapeLayer_5];
            CABasicAnimation *pathAnimation5 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
            pathAnimation5.duration = _time5;
            pathAnimation5.fromValue = [NSNumber numberWithFloat:_start5];
            pathAnimation5.toValue = [NSNumber numberWithFloat:_end5];
            [_shapeLayer_5 addAnimation:pathAnimation5 forKey:nil];
        });
        // 旋转视图
        self.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
                   colorArray:(NSArray *)colorArr
                    numberArr:(NSArray *)numArr
                        width:(CGFloat)width
                         time:(CGFloat)time
                    lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        // 旋转视图
        self.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
        CGFloat total = 0;
        for (NSNumber *num in numArr) {
            total += [num floatValue];
        }
        CGFloat proArr[numArr.count];
        for (int i = 0; i < numArr.count; i++) {
            proArr[i] = total == 0 ? 0 : [numArr[i] floatValue] / total;
        }
        if (total == 0) {
            proArr[numArr.count - 1] = 1.0;
        }
        
        CGFloat endArr[numArr.count];
        for (int i = 0; i < numArr.count; i++) {
            if (i == 0) {
                endArr[0] = proArr[0];
            } else {
                endArr[i] = endArr[i - 1] + proArr[i];
            }
        }
        endArr[numArr.count - 1] = 1.0;
        
        CGFloat startArr[numArr.count];
        for (int i = 0; i < numArr.count; i++) {
            if (i == 0) {
                startArr[0] = 0.0;
            } else {
                startArr[i] = startArr[i - 1] + proArr[i - 1];
            }
        }
        
        _time = time;
        CGFloat timeArr[numArr.count];
        for (int i = 0; i < numArr.count; i++) {
            timeArr[i] = time * proArr[i];
        }
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        
        for (int i = 0; i < numArr.count; i++) {
            CGFloat endN;
            CGFloat startN = startArr[i];
            CGFloat endNow = endArr[i];
            CGFloat timeI = timeArr[i];
            if (i == 0) {
                endN = 0;
                CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                shapeLayer.frame = self.bounds;
                shapeLayer.lineWidth = lineWidth;
                shapeLayer.strokeColor = [colorArr[i] CGColor];
                shapeLayer.fillColor = [UIColor clearColor].CGColor;
                shapeLayer.path = bezierPath.CGPath;
                shapeLayer.strokeStart = startN;
                shapeLayer.strokeEnd = endNow;
                [self.layer addSublayer:shapeLayer];
                CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                pathAnimation.duration = timeI;
                pathAnimation.fromValue = [NSNumber numberWithFloat:startN];
                pathAnimation.toValue = [NSNumber numberWithFloat:endNow];
                [shapeLayer addAnimation:pathAnimation forKey:nil];
            } else {
                endN = endArr[i - 1];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(endN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                    shapeLayer.frame = self.bounds;
                    shapeLayer.lineWidth = lineWidth;
                    shapeLayer.strokeColor = [colorArr[i] CGColor];
                    shapeLayer.fillColor = [UIColor clearColor].CGColor;
                    shapeLayer.path = bezierPath.CGPath;
                    shapeLayer.strokeStart = startN;
                    shapeLayer.strokeEnd = endNow;
                    [self.layer addSublayer:shapeLayer];
                    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                    pathAnimation.duration = timeI;
                    pathAnimation.fromValue = [NSNumber numberWithFloat:startN];
                    pathAnimation.toValue = [NSNumber numberWithFloat:endNow];
                    [shapeLayer addAnimation:pathAnimation forKey:nil];
                });
            }
            
            
        }
        
    }
    return self;
}


@end











