//
//  LBMoneyBillDetailVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"

@interface LBMoneyBillDetailVC : LBViewController

@property (nonatomic, assign) int goodId; //
@property (nonatomic, assign) BOOL isNewHand; // 是否是新手产品, 默认不是
@property (nonatomic, assign) int gcId; // 产品类型

@end
