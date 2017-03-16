//
//  LBBenefitRecordVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBBenefitRecordVC.h"
#import "LBBenefitBaseView.h"

@interface LBBenefitRecordVC ()

@end

@implementation LBBenefitRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"使用记录";
    LBBenefitBaseView *baseView = [[LBBenefitBaseView alloc] initWithTitleArray:@[@"已使用", @"已过期"]];
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64 - kJian64);
        make.left.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
    }];
    baseView.url = url_searchBenefitBillRecord;
    baseView.typeArray = @[@0, @1];
    [baseView setDatas];
    [baseView refreshThisView];
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
