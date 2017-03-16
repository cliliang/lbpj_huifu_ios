//
//  LBMoneyBillVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  银票苗

#import "LBViewController.h"

@interface LBMoneyBillVC : LBViewController

@property (nonatomic, assign) int gcId; // 银票苗:5, 新手11, 定期10, 活期0或13
@property (nonatomic, strong) UIImage *bannerImage;

@end
