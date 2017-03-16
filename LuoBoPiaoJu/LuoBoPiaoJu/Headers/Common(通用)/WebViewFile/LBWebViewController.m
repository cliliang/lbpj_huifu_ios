//
//  LBWebViewController.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBWebViewController.h"
#import <WebKit/WebKit.h>
#import "LBGuaGuaLeView.h"
#import "LBExperMoneyVC.h"
#import "LBFenXiangPageView.h"


#import "LBMoneyBillVC.h"
#import "LBInvitationVC.h"
#import "LBCalculatorVC.h"
#import "LBFaXianShangChengVC.h"
#import "LBMainVIPVC.h"
#import "LBMainBenefitCenterVC.h"

@interface LBWebViewController () <WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate> // WKNavigationDelegate

@property (nonatomic, strong) LBUserModel *userModel;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WKWebView *webView;
@property (assign, nonatomic) BOOL isReload;

@end

@implementation LBWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)updateUserModel
{
    self.userModel = [LBUserModel getInPhone];
    if (self.userModel == nil) {
        [[LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:@"您的账号已经在其他设备登录"] show];
        return;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.webViewStyle) {
        case LBWebViewControllerStyleTiXian: { // 提现
            [self updateUserModel];
            [self updateTixian];
            self.navigationItem.title = @"提现";
            break;
        }
        case LBWebViewControllerStyleChongZhi: { // 充值
            [self updateUserModel];
            [self updateChongzhi];
            self.navigationItem.title = @"充值";
            break;
        }
        case LBWebViewControllerStyleRenZheng: { // 开户
            [self updateUserModel];
            [self updateKaihu];
            self.navigationItem.title = @"开户";
            break;
        }
        case LBWebViewControllerStyleZhifu: { // 支付
            [self updateUserModel];
            [self updateZhifu];
            self.navigationItem.title = @"支付";
            break;
        }
        case LBWebViewControllerStyleBindingCard: { // 绑定银行卡
            [self updateUserModel];
            [self updateBangding];
            self.navigationItem.title = @"绑定银行卡";
            break;
        }
        case LBWebViewControllerStyleJieBang: { // 解绑
            [self updateUserModel];
            [self updateBangding];
            self.navigationItem.title = @"解绑银行卡";
            break;
        }
        case LBWebViewControllerStyleDefault: { // 单纯加载网页
            [self loadUrlWithString:self.urlString];
            break;
        }
            
        default:
            break;
    }
    // Do any additional setup after loading the view from its nib.
}
- (void)baseReturn
{
//    if (self.view.subviews.count != 1) {
//        WKWebView *view = [self.view.subviews lastObject];
//        [view removeFromSuperview];
//        return;
//    }
    if (self.webViewStyle == LBWebViewControllerStyleZhifu) {
        [self zhifuLeftItem];
        return;
    }
    if (self.webViewStyle == LBWebViewControllerStyleDefault) {
        if (self.webView.canGoBack) {
            [self.webView goBack];
            NSString *title = self.webView.title;
            if ([title isEqualToString:@"兑换详情"] || [title isEqualToString:@"积分商城"] || [title isEqualToString:@"转盘抽奖"]) {
                [self.webView reloadFromOrigin];
            }
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)zhifuLeftItem
{
    
    NSArray *controllerArr = self.navigationController.viewControllers;
    if (controllerArr.count < 3) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIViewController *viewC = controllerArr[controllerArr.count - 3];
        [self.navigationController popToViewController:viewC animated:YES];
    }
}

- (void)updateChongzhi // 充值
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_huifuCongzhi];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"money":@(self.money),
                            @"token":self.userModel.token,
//                            @"deviceType":@"1"
                            };
    [self loadWebViewWithUrl:string param:param];
}
- (void)updateTixian // 提现
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_huifuTixian];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"money":@(self.money),
                            @"token":self.userModel.token,
//                            @"deviceType":@"1"
                            };
    [self loadWebViewWithUrl:string param:param];
}
- (void)updateKaihu // 开户
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_KaiHu];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"token":self.userModel.token,
//                            @"deviceType":@"1"
                            };
    [self loadWebViewWithUrl:string param:param];
}
- (void)updateZhifu // 支付
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_huifuZhifu];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"buyOrderId":self.buyOrderId,
                            @"token":self.userModel.token,
//                            @"deviceType":@"1"
                            };
    [self loadWebViewWithUrl:string param:param];
}
- (void)updateBangding // 绑定银行卡
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_bindingBankCard];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"token":self.userModel.token,
//                            @"deviceType":@"1"
                            };
    [self loadWebViewWithUrl:string param:param];
}
- (void)updateJieBang // 绑定银行卡
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_bindingBankCard];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"token":self.userModel.token,
//                            @"deviceType":@"1"
                            };
    [self loadWebViewWithUrl:string param:param];
}
- (void)loadWebViewWithUrl:(NSString *)urlString param:(NSDictionary *)param
{
//    NSString *urlString = [NSString stringWithFormat:@"%@?userId=%@&money=%@&token=%@", string, param[@"userId"], param[@"money"], param[@"token"]];
    int i = 0;
    for (NSString *key in param) {
        if (i == 0) {
            urlString = [NSString stringWithFormat:@"%@?%@=%@", urlString, key, param[key]];
        } else {
            urlString = [NSString stringWithFormat:@"%@&%@=%@", urlString, key, param[key]];
        }
        i = 1;
    }
    [self loadUrlWithString:urlString];
}

- (void)loadUrlWithString:(NSString *)urlString
{
    [self removeWebCacheAction];
    if (_webView != nil) {
        [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [_webView setNavigationDelegate:nil];
        [_webView setUIDelegate:nil];
        [_webView removeFromSuperview];
        _webView = nil;
    }
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) configuration:config];
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    _webView = webView;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, CGRectGetWidth(self.view.frame),2)];
    [self.view addSubview:_progressView];
//    if (self.webViewStyle == LBWebViewControllerStyleZhifu) {
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
//    }
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void(^)(void))completionHandler {
    kLog(@"%@", message);
    if ([self pushVCWithHtmlString:message]) {
        completionHandler();
        return;
    }
    if ([message isEqualToString:@"ios_tiyanjin"]) { // 跳转到体验金
        LBExperMoneyVC *experVC = [LBExperMoneyVC new];
        [self.navigationController pushViewController:experVC animated:YES];
        experVC.navcTitle = @"体验金";
        completionHandler();
        return;
    }
    if ([message isEqualToString:@"shareios"]) {
        [LBFenXiangPageView shareUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, @"website/turnplate.html"] title:@"幸运转盘 免费拿现金！" content:@"萝卜票据理财 银行兑换 天生安全"];
        completionHandler();
        return;
    }
    completionHandler();
    
}
/**
 *  在收到响应后，决定是否跳转
 *
 *  @param webView            实现该代理的webview
 *  @param navigationResponse 当前navigation
 *  @param decisionHandler    是否跳转block
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSString *urlStr = navigationResponse.response.URL.absoluteString;
    if ([urlStr containsString:@"prizeId"]) {
        if (_isGuaGuaLe) { // 萝卜快赚，不要刮刮乐
            // 允许跳转
            decisionHandler(WKNavigationResponsePolicyAllow);
            return;
        }
        kLog(@"%@", urlStr);
        NSString *prizeName = [self URLDecodedString:[self stringWithResStr:urlStr itemStr:@"prizeName"]];
        NSString *prizeId = [self stringWithResStr:urlStr itemStr:@"prizeId"];
        NSString *prizeM = [self stringWithResStr:urlStr itemStr:@"prizeMoney"];
        kLog(@"%@ -- %@ -- %@", prizeName, prizeId, prizeM);
        LBGuaGuaLeView *guagualeView = [LBGuaGuaLeView showWithtitle:prizeName content:prizeM];
        guagualeView.guagualeV.completion = ^(id userInfo){
            [LBHTTPObject POST_LingQuGuaGuaLePrizeId:prizeId Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
                kLog(@"%@", dict);
            } failure:^(NSError * _Nonnull error) {
                
            }];
        };
    }
    if (self.webViewStyle == LBWebViewControllerStyleDefault) {
        if ([urlStr containsString:@"login.html"]) {
            LBLoginViewController *loginVC = [LBLoginViewController login];
            [loginVC setLoginSuccessBlock:^{
                // 下面是跳转盘
                //                NSString *url = [NSString stringWithFormat:@"%@?userId=%ld", urlStr, (long)kUserModel.userId];
                //                [self loadUrlWithString:url];
                [webView reloadFromOrigin];
            }];
            decisionHandler(WKNavigationResponsePolicyCancel);
            return;
        }
        if (![urlStr containsString:@"userId"] && kUserModel && [urlStr containsString:@"activity"]) {
            decisionHandler(WKNavigationResponsePolicyCancel); // 不跳转
            NSString *theUrlStr = [NSString stringWithFormat:@"%@?userId=%ld", urlStr, (long)kUserModel.userId];
            [self loadUrlWithString:theUrlStr];
            return;
        }
    }
    
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    kLog(@"%s,%@", __FUNCTION__, message);
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    NSLog(@" %s,change = %@",__FUNCTION__,change);
    if ([keyPath isEqual: @"estimatedProgress"] && object == _webView) {
        [self.progressView setAlpha:1.0f];
        [self.progressView setProgress:_webView.estimatedProgress animated:YES];
        if(_webView.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    WKWebView *theWebView = [[WKWebView alloc] initWithFrame:self.webView.frame configuration:configuration];
    [self.view addSubview:theWebView];
    return theWebView;
}

- (NSString *)stringWithResStr:(NSString *)resStr itemStr:(NSString *)itemStr
{
    NSArray *arr1 = [resStr componentsSeparatedByString:@"&"];
    for (NSString *str in arr1) {
        if ([str containsString:itemStr]) {
            NSArray *arr = [str componentsSeparatedByString:@"="];
            return arr[1];
        }
    }
    return @"";
}

- (NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

- (BOOL)pushVCWithHtmlString:(NSString *)urlStr
{
    if ([urlStr containsString:@"mobile1601"]) {
        LBTabbarController *tabbarVC = [LBVCManager shareVCManager].tabbarVC;
        if ([urlStr containsString:@"theme"]) { // 首页
            [(LBNavigationController *)tabbarVC.viewControllers.firstObject popToRootViewControllerAnimated:YES];
            tabbarVC.selectedIndex = 0;
        } else if ([urlStr containsString:@"dingtou"]) { // 定投列表
            LBMoneyBillVC *viewC = [LBMoneyBillVC new];
            viewC.navigationItem.title = @"萝卜定投";
            viewC.gcId = 10;
            tabbarVC.selectedIndex = 0;
            [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"yinpiaomiao"]) { // 银票苗
            tabbarVC.selectedIndex = 0;
            LBMoneyBillVC *viewC = [LBMoneyBillVC new];
            viewC.gcId = 5;
            viewC.navigationItem.title = @"银票苗";
            [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"fulizhongxin"]) { // 福利中心
            LBMainBenefitCenterVC *viewC = [LBMainBenefitCenterVC new];
            viewC.navigationItem.title = @"福利中心";
            [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"yaoqingyouli"]) { // 邀请有礼
            if (kUserModel == nil) {
                [LBLoginViewController login];
                
            } else {
                tabbarVC.selectedIndex = 0;
                LBInvitationVC *viewC = [[LBInvitationVC alloc] init];
                [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
                viewC.title = @"邀请有礼";
            }
        } else if ([urlStr containsString:@"kuaizhuan"]) { // 快赚
            tabbarVC.selectedIndex = 0;
            LBMoneyBillDetailVC *viewC = [LBMoneyBillDetailVC new];
            viewC.goodId = 0;
            viewC.gcId = 0;
            viewC.navigationItem.title = @"萝卜快赚";
            [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"tiyanjin"]) { // 体验金
            tabbarVC.selectedIndex = 0;
            LBExperMoneyVC *experVC = [LBExperMoneyVC new];
            [tabbarVC.viewControllers.firstObject pushViewController:experVC animated:YES];
            experVC.navcTitle = @"体验金";
        } else if ([urlStr containsString:@"jisuanqi"]) { // 计算器
            tabbarVC.selectedIndex = 0;
            LBCalculatorVC *clauVC = [[LBCalculatorVC alloc] init];
            clauVC.navcTitle = @"计算器";
            [tabbarVC.viewControllers.firstObject pushViewController:clauVC animated:YES];
        } else if ([urlStr containsString:@"faxian"]) { // 发现
            tabbarVC.selectedIndex = 1;
        } else if ([urlStr containsString:@"jifenshangcheng"]) { // 积分商城
            NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, @"website/mall.html"]; // @"http://baluobo-zxtc.imwork.net:59617/website/mall.html"
            if (kUserModel != nil) {
                url = [NSString stringWithFormat:@"%@?userId=%ld", url, (long)kUserModel.userId];
            }
            [self pushWebVCWithUrl:url title:@"积分商城"];
        } else if ([urlStr containsString:@"huiyuantequan"]) { // 会员特权
            LBMainVIPVC *vipVC = [[LBMainVIPVC alloc] init];
            [tabbarVC.viewControllers.firstObject pushViewController:vipVC animated:YES];
        } else if ([urlStr containsString:@"bangzhuzhongxin"]) { // 帮助中心
            NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, @"wenti.html"];
            [self pushWebVCWithUrl:url title:@"帮助中心"];
        } else if ([urlStr containsString:@"wode"]) { // 我的
            tabbarVC.selectedIndex = 2;
        } else if ([urlStr containsString:@"shareios"]) {
            NSString *urls = nil;
            if (kUserModel.inviteCode) {
                urls = [NSString stringWithFormat:@"%@%@%@", URL_HOST, @"website/toInvite.html?inviteCode=", kUserModel.inviteCode];
            } else {
                urls = [NSString stringWithFormat:@"%@%@", URL_HOST, @"website/toInvite.html"];
            }
            [LBFenXiangPageView shareUrl:urls title:@"20元现金红包，和好友一起来理财！" content:@"萝卜票据 银行兑付 天生安全 邀请好友一起来理财各得20元现金红包。"];
        } else {
            return NO; // 不是跳转
        }
        return YES; // 是跳转
    }
    
    return NO; // 不是跳转
    
}
// 跳转固定网页, 携带url 和 标题
- (void)pushWebVCWithUrl:(NSString *)url title:(NSString *)title
{
    LBFaXianShangChengVC *webV = [LBFaXianShangChengVC new];
    webV.urlString = url;
    [self.navigationController pushViewController:webV animated:YES];
    webV.navigationItem.title = title;
    webV.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"关闭" titleColor:[UIColor whiteColor] highColor:[UIColor whiteColor] target:webV.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    // if you have set either WKWebView delegate also set these to nil here
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
    
    _webView = nil;
}

- (void)removeWebCacheAction
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        // iOS9 清空缓存的方法
        // 某种类型的缓存
        //        NSSet *websiteDataTypes = [NSSet setWithArray:@[
        //                                                        //WKWebsiteDataTypeDiskCache,
        //                                                        //WKWebsiteDataTypeOfflineWebApplicationCache,
        //                                                        //WKWebsiteDataTypeMemoryCache,
        //                                                        //WKWebsiteDataTypeLocalStorage,
        //                                                        //WKWebsiteDataTypeCookies,
        //                                                        //WKWebsiteDataTypeSessionStorage,
        //                                                        //WKWebsiteDataTypeIndexedDBDatabases,
        //                                                        //WKWebsiteDataTypeWebSQLDatabases
        //                                ]];
        // 所有类型的缓存
        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        // 从哪个时间开始清空(下面是计算机元年开始)
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        // 清空啦
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // 清空完啦
        }];
    } else {
        // 据说是iOS7 iOS8 清空的方法
        NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString
                                          stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        NSString *webKitFolderInCachesfs = [NSString
                                            stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
        NSError *error;
        /* iOS8.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        /* iOS7.0 WebView Cache的存放路径 */
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
