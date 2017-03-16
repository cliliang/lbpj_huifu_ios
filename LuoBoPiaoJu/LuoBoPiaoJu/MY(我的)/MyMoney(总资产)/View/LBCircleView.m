//
//  LBCircleView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCircleView.h"

@interface LBCircleView ()

@property (nonatomic, strong) PSSSimpleCircleView *view1;
@property (nonatomic, strong) PSSSimpleCircleView *view2;
@property (nonatomic, strong) PSSSimpleCircleView *view3;
@property (nonatomic, strong) PSSSimpleCircleView *view4;
@property (nonatomic, strong) PSSSimpleCircleView *view5;

@end

@implementation LBCircleView

- (instancetype)initWithFrame:(CGRect)frame
                    numberOne:(CGFloat)numberOne
                     colorOne:(UIColor *)colorOne
                    numberTwo:(CGFloat)numberTwo
                     colorTwo:(UIColor *)colorTwo
                  numberThree:(CGFloat)numberThree
                   colorThree:(UIColor *)colorThree
                   numberFour:(CGFloat)numberFour
                    colorFour:(UIColor *)colorFour
                   numberFive:(CGFloat)numberFive
                    colorFive:(UIColor *)colorFive
                        width:(CGFloat)width
                         time:(CGFloat)time
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat total = numberOne + numberTwo + numberThree + numberFour + numberFive;
        CGFloat pro1 = numberOne / total;
        CGFloat pro2 = numberTwo / total;
        CGFloat pro3 = numberThree / total;
        CGFloat pro4 = numberFour / total;
        CGFloat pro5 = numberFive / total;
        
        CGFloat end1 = 0 + pro1;
        CGFloat end2 = end1 + pro2;
        CGFloat end3 = end2 + pro3;
        CGFloat end4 = end3 + pro4;
        CGFloat end5 = 1.0;
        
        CGFloat start1 = 0;
        CGFloat start2 = start1 + pro1;
        CGFloat start3 = start2 + pro2;
        CGFloat start4 = start3 + pro3;
        CGFloat start5 = start4 + pro4;
        
        CGFloat time1 = time * pro1;
        CGFloat time2 = time * pro2;
        CGFloat time3 = time * pro3;
        CGFloat time4 = time * pro4;
        CGFloat time5 = time * pro5;
        
        PSSSimpleCircleView *view1 = [[PSSSimpleCircleView alloc] initWithFrame:self.bounds lineWidth:width finishedColor:colorOne start:start1 end:end1];
        [self addSubview:view1];
        PSSSimpleCircleView *view2 = [[PSSSimpleCircleView alloc] initWithFrame:self.bounds lineWidth:width finishedColor:colorTwo start:start2 end:end2];
        [self addSubview:view2];
        PSSSimpleCircleView *view3 = [[PSSSimpleCircleView alloc] initWithFrame:self.bounds lineWidth:width finishedColor:colorThree start:start3 end:end3];
        [self addSubview:view3];
        PSSSimpleCircleView *view4 = [[PSSSimpleCircleView alloc] initWithFrame:self.bounds lineWidth:width finishedColor:colorFour start:start4 end:end4];
        [self addSubview:view4];
        PSSSimpleCircleView *view5 = [[PSSSimpleCircleView alloc] initWithFrame:self.bounds lineWidth:width finishedColor:colorFive start:start5 end:end5];
        [self addSubview:view5];
        
        [view1 startAnimationWithTime:time1];
        [view1 setFinishedBlock:^{
            [view2 startAnimationWithTime:time2];
            [view2 setFinishedBlock:^{
                [view3 startAnimationWithTime:time3];
                [view3 setFinishedBlock:^{
                    [view4 startAnimationWithTime:time4];
                    [view4 setFinishedBlock:^{
                        [view5 startAnimationWithTime:time5];
                        [view5 setFinishedBlock:^{
                            kLog(@"动画完成");
                        }];
                    }];
                }];
            }];
        }];
        
//        [view1 startAnimationWithTime:time];
//        [view2 startAnimationWithTime:time];
//        [view3 startAnimationWithTime:time];
//        [view4 startAnimationWithTime:time];
//        [view5 startAnimationWithTime:time];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
