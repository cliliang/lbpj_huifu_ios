//
//  PSSLockVC.h
//  PSSGestureLock
//
//  Created by 庞仕山 on 16/7/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSSLockView.h"

typedef enum : NSUInteger {
    PSSLockVCLeftBtnStyleImage,
    PSSLockVCLeftBtnStyleNone,
} PSSLockVCLeftBtnStyle;

typedef enum : NSUInteger {
    LBNavigationExistingStyleYes,
    LBNavigationExistingStyleNO,
} LBNavigationExistingStyle;

typedef void(^PSSSuccessBlock)(void);

@interface PSSLockVC : LBViewController

@property (nonatomic, assign) PSSLockStyle lockStyle;
@property (nonatomic, assign) PSSLockVCLeftBtnStyle leftBtnStyle;
@property (nonatomic, assign) LBNavigationExistingStyle navExistingStyle;

@property (nonatomic, copy) PSSSuccessBlock successBlock;
- (void)setSuccessBlock:(PSSSuccessBlock)successBlock;

- (void)presentViewControllerWithVC:(UIViewController *)VC;

- (void)removeGesture;

- (void)verifySuccess; // 验证成功 - 外部使用

- (void)zhiWenJieSuo;

@end



