//
//  LBNumberTimer.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBNumberTimer.h"

@interface LBNumberTimer ()

@property (nonatomic, assign) NSInteger second;
@property (nonatomic, strong) NSTimer *timer;

// second
@property (nonatomic, assign) CGFloat totalNum;
@property (nonatomic, assign) CGFloat itemNum;
@property (nonatomic, assign) CGFloat totalTime;
@property (nonatomic, assign) CGFloat itemTime;

@property (nonatomic, assign) CGFloat recordTime;
@property (nonatomic, assign) CGFloat recordNum;

@end

@implementation LBNumberTimer


- (void)fireWithStartNum:(CGFloat)startNum floatNum:(CGFloat)floatNum time:(CGFloat)time count:(int)count
{
    CGFloat itemTime = time * 1.0 / count;
    CGFloat itemNum = (floatNum - startNum) * 1.0 / count;
    
    self.totalNum = floatNum;
    self.itemNum = itemNum;
    self.totalTime = time;
    self.itemTime = itemTime;
    
    self.recordNum = startNum;
    self.recordTime = 0;
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:itemTime target:self selector:@selector(timerActionSecond:) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [self.timer fire];
}

- (void)timerActionSecond:(NSTimer *)timer
{
    if (self.numberBlock) {
        if (self.recordNum >= self.totalNum) {
            self.numberBlock(self.totalNum);
            [timer invalidate];
        } else {
            self.numberBlock(self.recordNum);
            self.recordTime += self.itemTime;
            self.recordNum += self.itemNum;
        }
    }
}

@end
