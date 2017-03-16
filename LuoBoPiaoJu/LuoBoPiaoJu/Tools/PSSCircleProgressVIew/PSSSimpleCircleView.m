//
//  PSSSimpleCircleView.m
//  CAShapeLayerLearning
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSSimpleCircleView.h"
#import <UIKit/UIKit.h>

@interface PSSSimpleCircleView ()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGFloat start;
@property (nonatomic, assign) CGFloat end;
@property (nonatomic, assign) CGFloat time;
@property (nonatomic, assign) CGFloat addTime;
@property (nonatomic, assign) CGFloat eachEnd;

@end

@implementation PSSSimpleCircleView

- (instancetype)initWithFrame:(CGRect)frame
                    lineWidth:(CGFloat)lineWidth
                finishedColor:(UIColor *)finishedColor
                        start:(CGFloat)start
                          end:(CGFloat)end
{
    self = [super initWithFrame:frame];
    if (self) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.lineWidth = lineWidth;
        _shapeLayer.strokeColor = finishedColor.CGColor;
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        _shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:self.shapeLayer];
        _shapeLayer.strokeStart = start;
        _shapeLayer.strokeEnd = start;
        _start = start;
        _end = end;
        // 旋转视图
        self.transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
    }
    return self;
}



// time为0.1整数倍
- (void)startAnimationWithTime:(CGFloat)time
{
    self.time = time;
    self.addTime = 0; // 累计time
    self.eachEnd = (self.end - self.start) / (time / 0.1); // 每次加这么多
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [timer fire];
}
- (void)timerAction:(NSTimer *)timer
{
    self.addTime += 0.1;
    [self setStartAndEndStart:self.start end:self.shapeLayer.strokeEnd + self.eachEnd];
    if (self.addTime >= self.time + 0.1) {
        [self setStartAndEndStart:_start end:_end];
        [timer invalidate];
        if (self.finishedBlock) {
            self.finishedBlock();
        }
        return;
    }
}

- (void)setStartAndEndStart:(CGFloat)start end:(CGFloat)end
{
    self.shapeLayer.strokeStart = start;
    self.shapeLayer.strokeEnd = end;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
