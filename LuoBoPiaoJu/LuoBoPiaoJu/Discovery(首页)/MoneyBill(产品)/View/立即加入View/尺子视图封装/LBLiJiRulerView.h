//
//  LBLiJiRulerView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kRulerHeight 90
#define kItemWidth 200 // itemWidth分为10个刻度, 每个刻度100元

typedef void(^LBScrollingBlock)(int money);

@interface LBLiJiRulerView : UIView

@property (nonatomic, assign) NSInteger totalMoney;

@property (nonatomic, assign) BOOL isScrolling; // 非拖动滑动

@property (nonatomic, copy) LBScrollingBlock scrollingBlock;
- (void)setScrollingBlock:(LBScrollingBlock)scrollingBlock;

- (void)scrollToNumber:(NSInteger)number;

@end
