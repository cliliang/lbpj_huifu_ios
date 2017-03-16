//
//  LBFaXianShangChengVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/30.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFaXianShangChengVC.h"
#import <WebKit/WebKit.h>
#import "LBLoginViewController.h"
#import "LBFenXiangPageView.h"

@interface LBFaXianShangChengVC () <WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate> // WKNavigationDelegate

@property (nonatomic, strong) LBUserModel *userModel;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WKWebView *webView;
@property (assign, nonatomic) BOOL isReload;

@end

@implementation LBFaXianShangChengVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    [self loadUrlWithString:self.urlString];
    
}

- (void)baseReturn
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        NSString *title = self.webView.title;
        if ([title isEqualToString:@"兑换详情"] || [title isEqualToString:@"积分商城"] || [title isEqualToString:@"转盘抽奖"]) {
            [self.webView reloadFromOrigin];
        }
        NSArray *retTitArr = @[@"兑换成功", @"立即兑换"];
        __block BOOL isGo = NO;
        [retTitArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:title]) {
                isGo = YES;
                *stop = NO;
            }
        }];
        if (isGo) {
            [self loadUrlWithString:self.urlString];
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
/**
 *  加载url
 *
 *  @param urlString 加载的url
 */
- (void)loadUrlWithString:(NSString *)urlString
{
    if (_webView != nil) {
        [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [_webView setNavigationDelegate:nil];
        [_webView setUIDelegate:nil];
        [_webView removeFromSuperview];
        _webView = nil;
    }
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) configuration:config];
    
    [self.view addSubview:_webView];
    
    if (kUserModel != nil) {
        urlString = [NSString stringWithFormat:@"%@?userId=%ld", urlString, (long)kUserModel.userId];
    }
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, CGRectGetWidth(self.view.frame),2)];
//    _progressView.trackTintColor = kNavBarColor;
    [self.view addSubview:_progressView];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
}
/**
 *  接货alert
 *
 *  @param webView           当前webView
 *  @param message           alert里的内容
 *  @param frame             frame
 *  @param completionHandler 回调
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void(^)(void))completionHandler {
    if ([message containsString:@"login"]) {
        completionHandler();
        return;
    }
    if ([message isEqualToString:@"shareios"]) {
        [LBFenXiangPageView shareUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, @"website/turnplate.html"] title:@"幸运转盘 免费拿现金！" content:@"萝卜票据理财 银行兑换 天生安全"];
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
    kLog(@"%@", urlStr);
    if ([urlStr containsString:@"login.html"]) {
        LBLoginViewController *loginVC = [LBLoginViewController login];
        [loginVC setLoginSuccessBlock:^{
            [self loadUrlWithString:self.urlString];
        }];
        
        decisionHandler(WKNavigationResponsePolicyCancel);
    }
    // 允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    self.navcTitle = webView.title;
}


// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    kLog(@"%s,%@", __FUNCTION__, message);
}
/**
 *  监听
 *
 *  @param keyPath 监听的keyPath
 *  @param object  监听的是谁
 *  @param change  改变之后的属性
 *  @param context context
 */
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
    } else if ([keyPath isEqualToString:@"cookies"]) {
        NSLog(@"------- cookies ------");
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
}



@end
