//
//  PSSFingerLock.m
//  ZhiWenShiBie
//
//  Created by 庞仕山 on 16/9/22.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSFingerLock.h"
#import <LocalAuthentication/LAContext.h>


@implementation PSSFingerLock

+ (void)unlockFingerSuccess:(void(^)(void))successBlock
{
    
    if (![[PSSUserDefaultsTool getValueWithKey:kFingerLockBool] boolValue]) {
        return;
    }
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    NSString *myLocalizedReasonString = @"请输入指纹";
    
    // 判断设备是否支持指纹识别
    if ([myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError]) {
        __block NSString *returnCode = nil;
        // 指纹识别只判断当前用户是否机主
        [myContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                  localizedReason:myLocalizedReasonString
                            reply:^(BOOL success, NSError *error) {
                                if (success) {
                                    // User authenticated successfully, take appropriate action
                                    kLog(@"success -- 指纹认证成功");
                                    returnCode = @"1";
                                    if (successBlock) {
                                        successBlock();
                                    }
                                } else {
                                    // User did not authenticate successfully, look at error and take appropriate action
                                    kLog(@"failure -- 指纹认证失败，%@",error.description);
                                    // 错误码 error.code
                                    // -1: 连续三次指纹识别错误
                                    // -2: 在TouchID对话框中点击了取消按钮
                                    // -3: 在TouchID对话框中点击了输入密码按钮
                                    // -4: TouchID对话框被系统取消，例如按下Home或者电源键
                                    // -8: 连续五次指纹识别错误，TouchID功能被锁定，下一次需要输入系统密码
                                    
                                    returnCode = [@(error.code) stringValue];
                                }
                            }];
        
    } else {
        // Could not evaluate policy; look at authError and present an appropriate message to user
        kLog(@"TouchID设备不可用");
        // TouchID没有设置指纹
        // 关闭密码（系统如果没有设置密码TouchID无法启用）
    }
}

+ (BOOL)isSupportingFingerLock
{
    LAContext *myContext = [[LAContext alloc] init];
    NSError *authError = nil;
    BOOL resBool = [myContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&authError];
    [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:resBool] WithKey:kSupportingFingerLock];
    return resBool;
}

@end
