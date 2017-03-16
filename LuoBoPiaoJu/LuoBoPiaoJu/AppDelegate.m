//
//  AppDelegate.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "AppDelegate.h"
#import "LBVCManager.h"
#import "PSSUserDefaultsTool.h"
#import "LBLaunchViewController.h"
#import "LuanchScreenViewController.h"
#import <UMMobClick/MobClick.h>
#import "UMessage.h"
#import "LBMoneyBillDetailVC.h"
#import "LBMessageCenterVC.h"
#import "CWStatusBarNotification.h"
#import "CoreLockConst.h"
#import "PSSLockVC.h"
#import "LBImportantHolidayView.h"
#import "LBCheckForUpdateView.h"

#import <UMSocial.h>
#import <UMSocialSinaSSOHandler.h>
#import <UMSocialQQHandler.h>
#import <UMSocialWechatHandler.h>
#import <UserNotifications/UserNotifications.h>

#define kUMAppKey @"5705fd1ee0f55ae1310003cf"

#define kClosePushPath @"ClosePushPath"

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    LBLaunchViewController *startController = [LBLaunchViewController new];
    [UIApplication sharedApplication].delegate.window.rootViewController = startController;
    
    
    UMConfigInstance.appKey = kUMAppKey;
    UMConfigInstance.channelId = @"";
    [MobClick startWithConfigure:UMConfigInstance];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [UMessage startWithAppkey:kUMAppKey launchOptions:launchOptions];
    [UMessage registerForRemoteNotifications];
    // iOS10
    
    [UMessage setLogEnabled:YES];
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    NSDictionary *subDic = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 关闭友盟自带弹出框
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:subDic];
        [self pushNotification:subDic];
        
        [self programmingGesturePW];
    });
    
    // 友盟分享
    [self addUMengSocial];
    
    // 打印是测试环境还是正式环境
    NSLog(@"%@", kConfiguration);
    
    // 心跳
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeartApp) userInfo:nil repeats:YES];
    [timer fire];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    return YES;
}
- (void)timeHeartApp
{
    [LBTimeHeart shareTime].timeRun = ![LBTimeHeart shareTime].timeRun;
}
- (void)addUMengSocial
{
    [UMSocialData setAppKey:kUMAppKey];
    
    NSString *urlStr = @"http://www.luobopj.com";
    // 分享
    [UMSocialData defaultData].extConfig.title = @"萝卜票据萝卜票据萝卜票据萝卜票据萝卜票据";
    //设置
    [UMSocialWechatHandler setWXAppId:@"wx2645bf2111c29719" appSecret:@"bc27b586caa70abaea5f9c3b686495b9" url:urlStr];
    //设置
    [UMSocialQQHandler setQQWithAppId:@"1104866018" appKey:@"k8tBbYHfkCCnu6Ht" url:@"http://www.luobopj.com"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:urlStr];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //1.2.7版本开始不需要用户再手动注册devicetoken，SDK会自动注册
    //[UMessage registerDeviceToken:deviceToken];
    //用户可以在这个方法里面获取devicetoken
    NSString *deviceTokenStr = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                              stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
    deviceTokenStr = [NSString stringWithFormat:@"%@%@", @"ios,", deviceTokenStr];
    [PSSUserDefaultsTool saveValue:deviceTokenStr WithKey:kDeviceTokenPath];
    kLog(@"%@", deviceTokenStr);
    [LBHTTPObject uploadDeviceTokenIfNeed];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    kLog(@"%@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // 关闭友盟自带弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];

    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        
        NSString *message = [userInfo[@"aps"] objectForKey:@"alert"];
        CWStatusBarNotification *notification = [CWStatusBarNotification new];
//        notification.notificationStyle = CWNotificationStyleNavigationBarNotification;
//        notification.notificationLabelBackgroundColor = [UIColor whiteColor];
        [notification displayNotificationWithMessage:message forDuration:8];
        __weak typeof(CWStatusBarNotification) *weakNoti = notification;
        notification.notificationTappedBlock = ^{
            [self pushNotification:userInfo];
            [UMessage sendClickReportForRemoteNotification:userInfo]; // 统计点击次数
            [weakNoti dismissNotification];
        };
    } else {
        [self pushNotification:userInfo];
    }
}

- (void)pushNotification:(NSDictionary *)userInfo
{
    NSString *key1Str = [NSString stringWithFormat:@"%@", userInfo[@"key1"]];
    if (key1Str == nil || [key1Str isKindOfClass:[NSNull class]]) {
        return;
    }

    int value2 = [userInfo[@"key2"] intValue];
    if ([key1Str isEqualToString:@"1"]) { // 公告
        LBWebViewController *webVC = [[LBWebViewController alloc] init];
        webVC.webViewStyle = LBWebViewControllerStyleDefault;
        NSString *urlString = [NSString stringWithFormat:@"%@notice/%d.html",URL_HOST, value2];
        webVC.urlString = urlString;
        [self pushVC:webVC];
    } else if ([key1Str isEqualToString:@"2"]) { // 活动
        LBWebViewController *webVC = [[LBWebViewController alloc] init];
        webVC.urlString = userInfo[@"key3"];
        webVC.navigationItem.title = @"活动详情";
        webVC.webViewStyle = LBWebViewControllerStyleDefault;
        [self pushVC:webVC];
    } else if ([key1Str isEqualToString:@"3"]) { // 产品到期
        LBMessageCenterVC *vc = [[LBMessageCenterVC alloc] init];
        [self pushVC:vc];
    } else if ([key1Str isEqualToString:@"4"]) { // 节日推送
        // @"http://img3.duitang.com/uploads/item/201307/22/20130722113606_3WcT5.jpeg"
        [LBImportantHolidayView showWithImgUrl:userInfo[@"key2"] success:^{
            LBWebViewController *webVC = [LBWebViewController new];
            webVC.navcTitle = @"节日推送";
            webVC.webViewStyle = LBWebViewControllerStyleDefault;
            webVC.urlString = userInfo[@"key3"]; // @"http://www.baidu.com";
            [self pushVC:webVC];
        }];
    } else {
        
    }
}

- (void)pushVC:(UIViewController *)VC
{
    LBTabbarController *tabbarVC = [LBVCManager shareVCManager].tabbarVC;
    UINavigationController *naVC = tabbarVC.viewControllers[tabbarVC.selectedIndex];
    [naVC pushViewController:VC animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIApplication*   app = [UIApplication sharedApplication];
    __block  UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid) {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self programmingGesturePW];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface
    [LBHTTPObject POST_SignInNew];
    [LBCheckForUpdateView checkForUpdate];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)programmingGesturePW
{
    // -是否支持指纹
    [PSSFingerLock isSupportingFingerLock];
    NSString *str = [PSSUserDefaultsTool getValueWithKey:kGesturePasswordKey];
    if (!([str isEqualToString:@""] || str == nil || [str isKindOfClass:[NSNull class]])) {
        PSSLockVC *lockVC = [[PSSLockVC alloc] init];
        lockVC.navigationItem.title = @"验证手势密码";
        lockVC.lockStyle = PSSLockStyleVerify;
        lockVC.leftBtnStyle = PSSLockVCLeftBtnStyleNone;
        lockVC.navExistingStyle = LBNavigationExistingStyleNO;
        [lockVC presentViewControllerWithVC:[LBVCManager shareVCManager].tabbarVC];
        [lockVC zhiWenJieSuo];
    }
}

@end
