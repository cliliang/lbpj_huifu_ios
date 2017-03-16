//
//  PSSSimpleCircleView.h
//  CAShapeLayerLearning
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PSSFinishedAnimation)(void);

@interface PSSSimpleCircleView : UIView

@property (nonatomic, copy) PSSFinishedAnimation finishedBlock;
- (void)setFinishedBlock:(PSSFinishedAnimation)finishedBlock;

- (instancetype)initWithFrame:(CGRect)frame
                    lineWidth:(CGFloat)lineWidth
                finishedColor:(UIColor *)finishedColor
                        start:(CGFloat)start
                          end:(CGFloat)end;

// time为0.05整数倍
- (void)startAnimationWithTime:(CGFloat)time;

@end
