//
//  LBMainBenefitCenterVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMainBenefitCenterVC.h"
#import "LBBenefitBaseView.h"
#import "LBBenefitRecordVC.h"

NSString *h5Str = @"website/redRules.html";

@interface LBMainBenefitCenterVC ()

@property (nonatomic, strong) LBBenefitBaseView *baseView;

@end

@implementation LBMainBenefitCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (![[PSSUserDefaultsTool getValueWithKey:@"isAppCheckingKey"] boolValue]) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"使用规则" titleColor:[UIColor whiteColor] highColor:[UIColor whiteColor] target:self action:NSSelectorFromString(@"clickRightNavBtn") forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.navigationItem.title = @"福利中心";
    
    LBBenefitBaseView *baseView = [[LBBenefitBaseView alloc] initWithTitleArray:@[@"现金红包", @"本金红包", @"体验金券"]];
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64 - kJian64);
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
    }];
    baseView.url = url_searchBenefitBill;
    baseView.typeArray = @[@0, @1, @2];
    [baseView setDatas];
    _baseView = baseView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        
    }];
}
- (void)clickRightNavBtn
{
    LBWebViewController *webC = [[LBWebViewController alloc] init];
    NSString *urlS = kStringFormat(@"%@%@", URL_HOST, h5Str);
    webC.navcTitle = @"红包使用规则";
    webC.urlString = urlS;
    [self.navigationController pushViewController:webC animated:YES];
}






@end







