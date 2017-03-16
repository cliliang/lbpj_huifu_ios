//
//  LBWebViewController.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"

typedef enum : NSUInteger {
    LBWebViewControllerStyleDefault, // 只加载网页
    LBWebViewControllerStyleChongZhi, // 充值
    LBWebViewControllerStyleTiXian, // 提现
    LBWebViewControllerStyleRenZheng, // 开户/认证
    LBWebViewControllerStyleZhifu, // 支付
    LBWebViewControllerStyleBindingCard, // 绑定银行卡
    LBWebViewControllerStyleJieBang, // 解绑定银行卡
} LBWebViewControllerStyle;

@interface LBWebViewController : LBViewController

@property (nonatomic, assign) LBWebViewControllerStyle webViewStyle;
@property (nonatomic, assign) double money;
@property (nonatomic, strong) NSString *buyOrderId;
@property (nonatomic, strong) NSString *urlString;

@property (nonatomic, assign) BOOL isGuaGuaLe; // 快赚为Yes，无刮刮乐


@end
















