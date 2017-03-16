//
//  LBUserServerProtocolVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBUserServerProtocolVC.h"

@interface LBUserServerProtocolVC ()

@end

@implementation LBUserServerProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"用户服务协议";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userServerProtocol" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight)];
    [self.view addSubview:webView];
    [webView loadRequest:request];
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
