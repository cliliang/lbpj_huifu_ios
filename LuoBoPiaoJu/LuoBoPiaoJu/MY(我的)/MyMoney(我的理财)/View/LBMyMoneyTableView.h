//
//  LBMyMoneyTableView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBMyMoneyTableView : UIView

@property (nonatomic, strong) LBViewController *VC;

@property (nonatomic, assign) int buyflg; // 3-投资中, 2-还款中, 1-已还款

- (void)startHeaderRefresh;

@end




