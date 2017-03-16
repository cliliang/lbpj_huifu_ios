//
//  LBYanZhengMaTimer.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/13.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBYanZhengMaTimer.h"

@interface LBYanZhengMaTimer ()

@property (nonatomic, assign) NSInteger second;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LBYanZhengMaTimer

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        _second = 60;
        _timer = timer;
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    return self;
}
- (void)timerAction:(NSTimer *)timer
{
    if (_second <= 0) {
        if (_timeBlock) {
            _timeBlock(0);
            _second = 60;
        }
        
        [timer invalidate];
    } else {
        if (_timeBlock) {
            _timeBlock(_second);
        }
    }
    _second--;
}
- (void)timeFire
{
    [_timer fire];
}





@end













