//
//  LBChangeLoginPasswordVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"

typedef void(^LBSuccessChangedBlock)(void);

@interface LBChangeLoginPasswordVC : LBViewController

@property (nonatomic, copy) LBSuccessChangedBlock successBlock;
- (void)setSuccessBlock:(LBSuccessChangedBlock)successBlock;

//@property (nonatomic, assign) BOOL isRegist; // 是否是注册页面

@end
