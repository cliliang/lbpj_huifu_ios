//
//  mainHeader.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  

#ifndef mainHeader_h
#define mainHeader_h

#ifdef DEBUG
#import "debugHeader.h"
# define kLineLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
# define kLog(fmt, ...)     NSLog((fmt), ##__VA_ARGS__);
#else
#import "releaseHeader.h"
# define kLineLog(...)
# define kLog(...)

#endif /* DEBUG */

# define kStringFormat(fmt, ...) [NSString stringWithFormat:(fmt), ##__VA_ARGS__]
# define kFloatString_2(a) [NSString stringWithFormat:@"%.2f", (a)]
# define kIntString(a) [NSString stringWithFormat:@"%ld", (a)]

#define kVersionKey @"currentVerson" // 本地储存的当前版本key

#import "NSObject+PSSObjc.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "LBNavigationController.h"
#import "LBTabbar.h"
#import "LBViewController.h"
#import "LBTabbarController.h"
#import "AppDelegate.h"
#import "UIBarButtonItem+Item.h"
#import "LBYesOrNoAlert.h"
#import "LBMessageModel.h"
#import <MJRefresh.h>
#import "LBLoginViewController.h"
#import "LBWebViewController.h"
#import <MJExtension.h>
#import "LBTBankCar.h"
#import "UIView+WLFrame.h"
#import "UINavigationBar+Awesome.h"
#import <Masonry.h>
#import "LBGoodsModel.h"
#import "LBCycleModel.h"
#import "LBOrderModel.h"
#import "UIButton+PSButton.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "LBURLMethodString.h"
#import "LBVCManager.h"
#import "UIColor+RGBValue.h"
#import "NSString+Hashing.h"
#import "HTTPTools.h"
#import <MJExtension.h>
#import "LBUserModel.h"
#import "LBLoginAlert.h"
#import "LBYanZhengMaTimer.h"
#import "PSSCircleProgressView.h"
#import "PSSSimpleCircleView.h"
#import "LBMoneyBillDetailVC.h"
#import "PSSTool.h"
#import "LBHttpStateView.h"
#import "NSString+PSS.h"
#import "MJGifHeader.h"
#import "LBFunctionRemindView.h"
#import "PSSUserDefaultsTool.h"
#import "LBHTTPObject.h"
#import "UILabel+PSSLabel.h"
#import "NSDate+PSSDate.h"
#import "PSSToast.h"
#import "UIFont+PSSFont.h"
#import "UIImage+PSSImage.h"
#import "PSSFingerLock.h"
#import <ReactiveCocoa.h>
#import "LBTimeHeart.h"

#define div_2(a) ((a) / 2.0) // a除以2
#define div_3(a) ((a) / 3.0) // a除以3
#define kDiv2(a) ((a) / 2.0) // 

#define kUserModel [LBUserModel getInPhone]
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize   [UIScreen mainScreen].bounds.size
#define kWindows [[UIApplication sharedApplication].delegate window]

#define kAutoH(a) ((a)* 1.0 / 667.0 * kScreenHeight)
#define kAutoW(a) ((a)* 1.0 / 375.0 * kScreenWidth)

#define KAutoWDiv2(a) kAutoW(div_2((a)))
#define KAutoHDiv2(a) kAutoH(div_2((a)))

#define kIPHONE_4s (kScreenHeight == 480)
#define kIPHONE_5s (kScreenHeight == 568)
#define kIPHONE_6s (kScreenHeight == 667)
#define kIPHONE_6P (kScreenHeight == 736)

//#define kNavBarColor [UIColor colorWithRed:0.992 green:0.345 blue:0.252 alpha:1.000]
#define kNavBarColor [UIColor colorWithRGBString:@"ff6e54"]
#define kBackgroundColor [UIColor colorWithRGBString:@"f3f3f3"]
#define kLineColor [UIColor colorWithRGBString:@"e7e7e7"]
#define kDeepColor [UIColor colorWithRGBString:@"404040"]
#define kLightColor [UIColor colorWithRGBString:@"929292"]
#define kTabbarColor [UIColor colorWithRGBString:@"f6f6f6"]
#define kColor_707070 [UIColor colorWithRGBString:@"707070"]

// 颜色转换
#define UIColorFromHexString(hexString,alphaValue) [UIColor colorWithRed:((float)((strtoul([[hexString hasPrefix:@"0x"]?[hexString substringFromIndex:2]:hexString UTF8String],0,16) & 0xFF0000) >> 16))/255.0  green:((float)((strtoul([[hexString hasPrefix:@"0x"]?[hexString substringFromIndex:2]:hexString UTF8String],0,16) & 0x00FF00) >> 8))/255.0  blue:((float)(strtoul([[hexString hasPrefix:@"0x"]?[hexString substringFromIndex:2]:hexString UTF8String],0,16) & 0x0000FF))/255.0  alpha:(alphaValue)]

#define kDeviceTokenPath @"deviceTokenPath"
#define kPasswordMD5Key @"kPasswordMD5KeyPath" // -保存MD5加密之后的密码

#define kPingFangFont(a) [UIFont fontWithName:@"PingFangSC-Light" size:(a)]

#define kJian64 64

#define kDeviceType @"1"   //deviceType 0android 1ios 2weixin 3pc
#define kMd5SecretCode @"luobopj2017!@#$%^&*1382593671"  //发送验证码的安全码

typedef enum {
    SendSecurtyTypeLogin = 0,
    SendSecurtyTypeRegister,
    SendSecurtyTypeChangeMobile,
    SendSecurtyTypeChangePsd
} SendSecurtyType;

#define kSendSecurtyType(enum) [@[@"0",@"1",@"2",@"3"] objectAtIndex:enum]

#endif /* mainHeader_h */


typedef void(^LBSuccessVoidBlock)(void);
typedef void(^LBSuccessOtherBlock)(id);













