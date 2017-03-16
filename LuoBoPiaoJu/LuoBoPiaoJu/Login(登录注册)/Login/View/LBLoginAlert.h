//
//  LBLoginAlert.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBReturnBlock)(void);

@interface LBLoginAlert : UIView

@property (nonatomic, copy) LBReturnBlock yesBlock;

+ (LBLoginAlert *)instanceLoginAlertWithTitle:(NSString *)title
                                      message:(NSString *)message;
- (void)show;

- (void)setYesBlock:(LBReturnBlock)yesBlock;


+ (void)showErrorWithString1:(NSString *)str1 str2:(NSString *)str2 VC:(UIViewController *)vc;

@end






