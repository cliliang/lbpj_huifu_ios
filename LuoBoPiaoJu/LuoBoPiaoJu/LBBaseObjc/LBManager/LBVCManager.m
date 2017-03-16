//
//  LBVCManager.m
//  BaLuoBoLiCai
//
//  Created by 庞仕山 on 16/5/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBVCManager.h"
#import "LBTabbarController.h"
#import "LBNavigationController.h"
#import "AppDelegate.h"
#import "LBDiscoveryVC.h"
#import "LBMyViewController.h"
#import "LBFaXianMainVC.h"

@interface LBVCManager () <UITabBarControllerDelegate>

@property (nonatomic, strong) UIView *redMessageView;

@end

@implementation LBVCManager

+ (instancetype)shareVCManager
{
    static LBVCManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [LBVCManager new];
        }
    });
    return manager;
}

- (void)instanceMainRoot
{
    LBTabbarController *tabbarVC = [[LBTabbarController alloc] init];
    tabbarVC.delegate = self;
    self.tabbarVC = tabbarVC;
    [tabbarVC addTabbarItemNavWithClass:[LBDiscoveryVC class] title:@"首页" normalImageName:@"icon_1_normal" selectedImageName:@"icon_1_selected" adjuestX:0];
    
    [tabbarVC addTabbarItemNavWithClass:[LBFaXianMainVC class] title:@"发现" normalImageName:@"icon_1.5_normal" selectedImageName:@"icon_1.5_selected" adjuestX:0];
    
    [tabbarVC addTabbarItemNavWithClass:[LBMyViewController class] title:@"我的" normalImageName:@"icon_2_normal" selectedImageName:@"icon_2_selected" adjuestX:0];
    [UIApplication sharedApplication].delegate.window.rootViewController = tabbarVC;
    
    [self resetRedMessageView];
    [LBHTTPObject POST_isHaveNotReadingMess:^(NSDictionary *dict) {
        if (!dict) {
            return ;
        }
        if ([dict[@"success"] boolValue]) {
            [LBVCManager showMessageView];
        } else {
            [LBVCManager hideMessageView];
        }
    }];
}

+ (void)showMessageView // 显示消息小红点
{
    [LBVCManager shareVCManager].redMessageView.hidden = NO;
}
+ (void)hideMessageView // 隐藏消息小红点
{
    [LBVCManager shareVCManager].redMessageView.hidden = YES;
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)resetRedMessageView
{
    UIView *view = [[UIView alloc] init];
    _redMessageView = view;
    _redMessageView.backgroundColor = kNavBarColor;
    UIViewController *VC = self.tabbarVC.viewControllers[1];
    UITabBar *tabbar = VC.tabBarController.tabBar;
    CGFloat w = kAutoW(8);
    view.layer.cornerRadius = w / 2;
    CGFloat dx = kAutoW(55); // 原点距离右侧
    CGFloat dy = 5; // 原点距离上边
    CGFloat x = kScreenWidth - dx;
    CGFloat y = dy;
    view.frame = CGRectMake(x, y, w, w);
    [tabbar addSubview:view];
    view.hidden = YES;
}



@end
