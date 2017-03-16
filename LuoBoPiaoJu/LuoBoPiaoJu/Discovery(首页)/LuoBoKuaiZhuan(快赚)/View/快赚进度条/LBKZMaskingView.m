//
//  LBKZMaskingView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/12/22.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBKZMaskingView.h"

@implementation LBKZMaskingView


- (void)drawRect:(CGRect)rect {
    
    if (_progress == 1) {
        return;
    }
    double r = rect.size.height / 2;
    double width = rect.size.width;
    double height = rect.size.height;
    
    double x = r + _progress * (width - 2 * r);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRGBString:@"ededed"].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRGBString:@"ededed"].CGColor);
    CGContextMoveToPoint(context, x, 0);
    CGContextAddLineToPoint(context, width - 2 * r, 0);
    CGContextAddArc(context, width - r, r, r, -M_PI_2, M_PI_2, 0);
    CGContextAddLineToPoint(context, x, height);
    
    
    if (_progress == 0) {
        CGContextAddArc(context, x, r, r, M_PI_2, M_PI_2 * 3, 0);
        CGContextFillPath(context);
    } else {
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
}

- (void)setProgress:(double)progress
{
    if (progress <= 0) {
        _progress = 0;
    } else if (progress >= 1) {
        _progress = 1;
    } else {
        _progress = progress;
    }
    [self setNeedsDisplay];
}

@end
