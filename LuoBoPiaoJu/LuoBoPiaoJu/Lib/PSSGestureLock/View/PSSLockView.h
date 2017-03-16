//
//  PSSLockView.h
//  PSSGestureLock
//
//  Created by 庞仕山 on 16/7/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PSSLockStyleSet,
    PSSLockStyleVerify,
    PSSLockStyleReset,
    PSSLockStyleRemove,
} PSSLockStyle;

typedef void(^PSSSetSuccessBlock)(NSString *password); // 设置密码成功
typedef void(^PSSSetFailureBlock)(void); // 设置密码失败
typedef void(^PSSFirstSettingBlock)(NSString *password); // 设置密码的首次输入

typedef void(^PSSVerifyFailureBlock)(void); // 确认密码失败
typedef void(^PSSVerifySuccessBlock)(void); // 确认密码成功

typedef void(^PSSAllowResetSuccessBlock)(void); // 确认密码成功, 允许重置密码
typedef void(^PSSAllowResetFailureBlock)(void); // 确认密码失败, 不允许重置密码

typedef void(^PSSRemoveSuccessBlock)(void); // 关闭密码成功

typedef void(^PSSLessThanFourBlock)(void); // 少于最少个数

@interface PSSLockView : UIView

@property (nonatomic, copy) PSSFirstSettingBlock firstSettingBlock;
- (void)setFirstSettingBlock:(PSSFirstSettingBlock)firstSettingBlock;

@property (nonatomic, copy) PSSSetSuccessBlock successSetBlock;
- (void)setSuccessSetBlock:(PSSSetSuccessBlock)successSetBlock;

@property (nonatomic, copy) PSSSetFailureBlock failureSetBlock;
- (void)setFailureSetBlock:(PSSSetFailureBlock)failureSetBlock;

@property (nonatomic, copy) PSSLessThanFourBlock lessThanFourBlock;
- (void)setLessThanFourBlock:(PSSLessThanFourBlock)lessThanFourBlock;

@property (nonatomic, copy) PSSVerifySuccessBlock successVerifyBlock;
- (void)setSuccessVerifyBlock:(PSSVerifySuccessBlock)successVerifyBlock;

@property (nonatomic, copy) PSSVerifyFailureBlock failureVerifyBlock;
- (void)setFailureVerifyBlock:(PSSVerifyFailureBlock)failureVerifyBlock;

@property (nonatomic, copy) PSSAllowResetSuccessBlock successAllowBlock;
- (void)setSuccessAllowBlock:(PSSAllowResetSuccessBlock)successAllowBlock;

@property (nonatomic, copy) PSSAllowResetFailureBlock failureAllowBlock;
- (void)setFailureAllowBlock:(PSSAllowResetFailureBlock)failureAllowBlock;

@property (nonatomic, copy) PSSRemoveSuccessBlock successRemoveBlock;
- (void)setSuccessRemoveBlock:(PSSRemoveSuccessBlock)successRemoveBlock;

@property (nonatomic, assign) PSSLockStyle lockStyle;

@property (nonatomic, strong) NSString *firstPassword;
@property (nonatomic, strong) NSString *secondPassword; // 没有用到

@end






