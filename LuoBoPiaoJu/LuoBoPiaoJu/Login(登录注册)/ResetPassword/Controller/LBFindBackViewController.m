//
//  LBFindBackViewController.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  没用到

#import "LBFindBackViewController.h"
#import "LBResetPasswordVC.h"

@interface LBFindBackViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tf_YanZhengMa;
@property (weak, nonatomic) IBOutlet UIButton *btn_YanZhengMa;
@property (weak, nonatomic) IBOutlet UIButton *btn_nextButton;


@end

@implementation LBFindBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"找回密码";
    self.btn_nextButton.layer.cornerRadius = 5;
    self.tf_phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf_phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.tf_YanZhengMa.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf_YanZhengMa.keyboardType = UIKeyboardTypeNumberPad;
}

- (IBAction)clickYanZhengMaBtn:(id)sender {
    if (self.tf_phoneNumber.text.length != 11) {
        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"手机号格式不正确" message:@"请重新输入"];
        [alert show];
        return;
    }
    LBYanZhengMaTimer *timer = [[LBYanZhengMaTimer alloc] init];
    [timer setTimeBlock:^(NSInteger second) {
        self.btn_YanZhengMa.titleLabel.text = [NSString stringWithFormat:@"%ld", second];
        [self.btn_YanZhengMa setTitle:[NSString stringWithFormat:@"%ld", (long)second] forState:UIControlStateNormal];
        if (second == 0) {
            self.btn_YanZhengMa.titleLabel.text = @"获取验证码";
            [self.btn_YanZhengMa setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
    }];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_yanZhengMa];
    [HTTPTools POSTWithUrl:urlString parameter:@{@"mobile":self.tf_phoneNumber.text} progress:nil success:^(NSDictionary *dict, BOOL successOrNot) {
    } failure:nil];
}
- (IBAction)clickNextButton:(id)sender {
    
    if (self.tf_phoneNumber.text.length != 11) {
        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"手机号不正确" message:@"请重新输入"];
        [alert show];
        return;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_yanzhengmaSure];
    
    [HTTPTools POSTWithUrl:urlString parameter:@{@"mobile":self.tf_phoneNumber.text, @"validCode":self.tf_YanZhengMa.text} progress:nil success:^(NSDictionary *dict, BOOL successOrNot) {
        if (![dict[@"success"] boolValue]) {
            LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:dict[@"message"] message:@"请重新输入"];
            [alert show];
            return;
        }
        LBResetPasswordVC *resetPassword = [LBResetPasswordVC new];
        resetPassword.yanZhengMa = self.tf_YanZhengMa.text;
        resetPassword.phoneNumber = self.tf_phoneNumber.text;
        [self.navigationController pushViewController:resetPassword animated:YES];
    } failure:nil];
    
    
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
