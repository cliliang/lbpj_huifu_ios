//
//  LBVCManager.h
//  BaLuoBoLiCai
//
//  Created by 庞仕山 on 16/5/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  跟控制器管理者

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LBVCManager : NSObject

@property (nonatomic, strong) LBTabbarController *tabbarVC;

+ (instancetype)shareVCManager;
// 设置为根控制器
- (void)instanceMainRoot;

+ (void)showMessageView; // 显示消息小红点
+ (void)hideMessageView; // 隐藏消息小红点

@end
