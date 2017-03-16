//
//  MJGifHeader.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "MJGifHeader.h"

@implementation MJGifHeader

- (void)prepare
{
    [super prepare];
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i < 11; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"header_%d", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i < 25; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"header_%d", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
