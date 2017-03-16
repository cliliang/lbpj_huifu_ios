//
//  LBAboutUsVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBAboutUsVC.h"
#import <WebKit/WebKit.h>

@interface LBAboutUsVC () <WKUIDelegate, WKScriptMessageHandler, WKNavigationDelegate>

@property (nonatomic, strong) LBUserModel *userModel;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation LBAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"关于我们";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"aboutUs" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) configuration:config];
    [self.view addSubview:webView];
    [webView loadRequest:request];
    _webView = webView;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, CGRectGetWidth(self.view.frame),2)];
    [self.view addSubview:_progressView];
    //    if (self.webViewStyle == LBWebViewControllerStyleZhifu) {
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
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

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    // if you have set either WKWebView delegate also set these to nil here
    [_webView setNavigationDelegate:nil];
    [_webView setUIDelegate:nil];
    _webView = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
