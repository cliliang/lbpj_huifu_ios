//
//  PSSChartView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/30.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSSChartView : UIView

@property (nonatomic, strong) NSArray *dateArray;

/**
 *  根据数据,绘制表格
 *
 *  @param totalMoney y轴最大值
 *  @param dataArr    钱数数组
 */
- (void)drawChartWithTotalMonty:(CGFloat)totalMoney dataArr:(NSArray *)dataArr;

- (void)startAnimationWithTime:(CGFloat)time;

@end









