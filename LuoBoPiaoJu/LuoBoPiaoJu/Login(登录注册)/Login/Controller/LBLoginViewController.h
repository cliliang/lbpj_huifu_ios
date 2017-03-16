//
//  LBLoginViewController.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LBViewController.h"

typedef void(^LBLoginSuccessBlock)(void);

@interface LBLoginViewController : LBViewController

@property (nonatomic, strong) NSString *userString;

@property (weak, nonatomic) IBOutlet UIButton *btn_yanZhengMa;
@property (weak, nonatomic) IBOutlet UIButton *btn_yanZhengLogin;
@property (nonatomic, strong) NSString *numberStr;

@property (nonatomic, copy) LBLoginSuccessBlock loginSuccessBlock;
- (void)setLoginSuccessBlock:(LBLoginSuccessBlock)loginSuccessBlock;

@property (nonatomic, assign) BOOL isWebLogin;

+ (instancetype)login;
+ (void)alertLogin;

@end
