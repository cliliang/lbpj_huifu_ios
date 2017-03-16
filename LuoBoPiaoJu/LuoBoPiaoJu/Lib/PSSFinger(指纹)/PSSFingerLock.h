//
//  PSSFingerLock.h
//  ZhiWenShiBie
//
//  Created by 庞仕山 on 16/9/22.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  指纹解锁

#import <Foundation/Foundation.h>

#define kFingerLockBool @"fingerLockBoolPath"

#define kSupportingFingerLock @"SupportingFingerLock"

@interface PSSFingerLock : NSObject

+ (void)unlockFingerSuccess:(void(^)(void))successBlock;

+ (BOOL)isSupportingFingerLock;

@end
