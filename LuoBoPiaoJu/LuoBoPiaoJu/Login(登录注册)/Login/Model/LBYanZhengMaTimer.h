//
//  LBYanZhengMaTimer.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/13.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimeBlock)(NSInteger second);

@interface LBYanZhengMaTimer : NSObject

@property (nonatomic, copy) TimeBlock timeBlock;
- (void)setTimeBlock:(TimeBlock)timeBlock;

- (void)timeFire;



@end
