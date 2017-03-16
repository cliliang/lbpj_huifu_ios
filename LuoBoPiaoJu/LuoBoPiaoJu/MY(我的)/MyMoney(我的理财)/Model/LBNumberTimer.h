//
//  LBNumberTimer.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NumberBlock)(CGFloat itemNum);

@interface LBNumberTimer : NSObject

// second
@property (nonatomic, copy) NumberBlock numberBlock;
- (void)setNumberBlock:(NumberBlock)numberBlock;

- (void)fireWithStartNum:(CGFloat)startNum floatNum:(CGFloat)floatNum time:(CGFloat)time count:(int)count;


@end
