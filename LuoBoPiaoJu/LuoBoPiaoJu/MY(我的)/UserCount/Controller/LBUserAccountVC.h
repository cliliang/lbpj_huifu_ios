//
//  LBUserAccountVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  账户信息

#import "LBViewController.h"

@interface LBUserAccountVC : LBViewController

@property (nonatomic, strong) NSString *phoneNumber; // 电话号码
@property (nonatomic, assign) BOOL trueName; // 实名认证
@property (nonatomic, strong) NSString *binding; // 绑定

@end
