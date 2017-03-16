//
//  LBAnQuanCircleView.m
//  圆形进度条
//
//  Created by 庞仕山 on 16/6/12.
//  Copyright © 2016年 andy. All rights reserved.
//

#import "LBAnQuanCircleView.h"
#import <Masonry.h>
@interface LBAnQuanCircleView ()

@property (nonatomic, assign) CGFloat totalPro;
@property (nonatomic, strong) CAShapeLayer *frontLayer;
@property (nonatomic, strong) UIColor *fromColor;
@property (nonatomic, strong) UIColor *toColor;

@end

@implementation LBAnQuanCircleView

- (instancetype)initWithFrame:(CGRect)frame
                    backWidth:(CGFloat)backWidth
                   frontWidth:(CGFloat)frontWith
                     progress:(CGFloat)progress
                    fromColor:(UIColor *)fromColor
                      toColor:(UIColor *)toColor
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _fromColor = fromColor;
        _toColor = toColor;
        
        CGFloat jiaoDu = 130;
        
        _totalPro = (360 - jiaoDu) * 1.0 / 360;
        CGFloat xuanZhuan = M_PI * 2.0 * (180 - (180 - jiaoDu) * 0.5) / 360;
        self.transform = CGAffineTransformMakeRotation(xuanZhuan);
        // 添加backLine
        UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        CAShapeLayer *backLayer = [CAShapeLayer layer];
        backLayer.frame = self.bounds;
        backLayer.path = circlePath.CGPath;
        backLayer.lineWidth = backWidth;
        backLayer.strokeColor = [UIColor colorWithRGBString:@"d3d3d3"].CGColor;
        backLayer.lineCap = kCALineCapRound;
        backLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:backLayer];
        backLayer.strokeStart = 0;
        backLayer.strokeEnd = _totalPro;
        
        _frontLayer = [CAShapeLayer layer];
        _frontLayer.frame = self.bounds;
        _frontLayer.path = circlePath.CGPath;
        _frontLayer.lineWidth = frontWith;
        _frontLayer.strokeColor = _toColor.CGColor;
        _frontLayer.lineCap = kCALineCapRound;
        _frontLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_frontLayer];
        _frontLayer.strokeStart = 0;
        _frontLayer.strokeEnd = _totalPro * progress;
        
    }
    return self;
}

// progress 0-1
- (void)animationStartWithTime:(CGFloat)time
{
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = time;
    pathAnima.fromValue = [NSNumber numberWithFloat:0];
    pathAnima.toValue = [NSNumber numberWithFloat:_frontLayer.strokeEnd];
    [_frontLayer addAnimation:pathAnima forKey:nil];
    
    CABasicAnimation *colorAnima = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
    colorAnima.duration = time;
    colorAnima.fromValue = (__bridge id _Nullable)(_fromColor.CGColor);
    colorAnima.toValue = (__bridge id _Nullable)(_toColor.CGColor);
    [_frontLayer addAnimation:colorAnima forKey:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
