//
//  LBMoneyBillCircleView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMoneyBillCircleView.h"

@implementation LBMoneyBillCircleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, 25, 25, 25, self.startJiao, self.endJiao, 0);
    [[UIColor colorWithRed:0.992 green:0.655 blue:0.424 alpha:1.000] setFill];
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
