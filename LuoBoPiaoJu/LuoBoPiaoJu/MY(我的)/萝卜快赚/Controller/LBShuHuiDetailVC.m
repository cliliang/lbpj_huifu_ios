//
//  LBShuHuiDetailVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBShuHuiDetailVC.h"

@interface LBShuHuiDetailVC ()

@property (nonatomic, strong) LBUserModel *userModel;

@end

@implementation LBShuHuiDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"赎回";
    self.userModel = [LBUserModel getInPhone];
    self.btn_fanhui.layer.cornerRadius = 4;
    self.btn_fanhui.backgroundColor = kNavBarColor;
    self.btn_Jixu.layer.masksToBounds = YES;
    self.btn_Jixu.layer.borderWidth = 1;
    self.btn_Jixu.layer.cornerRadius = 4;
    self.btn_Jixu.layer.borderColor = kNavBarColor.CGColor;
    
    self.label_shuhuijinENum.text = [NSString stringWithFormat:@"%@", @(self.orderModel.speedMoney)];
    

    NSDate *date = [NSDate date];
    NSTimeInterval timeInt = [date timeIntervalSince1970];
    timeInt = timeInt + 24 * 60 * 60 * 2;
    NSDate *theDate = [NSDate dateWithTimeIntervalSince1970:timeInt];
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    [dateF setDateFormat:@"YYYY-MM-dd"];
    NSString *timeString = [dateF stringFromDate:theDate];
    self.label_daozhangTime.text = timeString;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        
    }];
}

- (IBAction)clickReturnBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickJiXuBtn:(id)sender {
    [self setUpData];
}

- (void)setUpData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_ShuHui];
    NSDictionary *param = @{
                            @"ordId":self.orderModel.buyOrderNo,
                            @"userId":@(self.userModel.userId),
                            @"token":self.userModel.token,
                            @"deviceType":@"1"
                            };
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (![NSObject nullOrNilWithObjc:dict]) {
            if ([dict[@"success"] boolValue]) {
                LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示信息" message:@"赎回成功"];
                [alert show];
                __weak typeof(self) weakSelf = self;
                [alert setYesBlock:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }
        } else {
            LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示信息" message:@"赎回失败"];
            [alert show];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示信息" message:@"赎回失败"];
        [alert show];
    }];
    
    
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
