//
//  LBResetPasswordVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  没用到

#import "LBResetPasswordVC.h"

@interface LBResetPasswordVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *tf_password;
@property (weak, nonatomic) IBOutlet UITextField *tf_passwordAgain;
@property (weak, nonatomic) IBOutlet UIButton *btn_hideAndShow;
@property (weak, nonatomic) IBOutlet UIButton *btn_nextButton;

@property (nonatomic, assign) BOOL shouPassword;


@end

@implementation LBResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tf_password.secureTextEntry = YES;
    self.tf_passwordAgain.secureTextEntry = YES;
}

- (IBAction)clickHiddenAndShow:(id)sender {
    _shouPassword = !_shouPassword;
    self.tf_password.secureTextEntry = !_shouPassword;
}
// 点击下一步
- (IBAction)clickNextButton:(id)sender {
    if (!self.tf_password.text.length || !self.tf_passwordAgain.text.length) {
        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"密码不能为空" message:@"请重新输入"];
        [alert show];
    } else if (![self.tf_password.text isEqualToString:self.tf_passwordAgain.text]) {
        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"两次输入的密码不一样" message:@"请重新输入"];
        [alert show];
    } else {
        NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_changePassword];
        NSDictionary *param = @{
                                @"mobile":self.phoneNumber,
                                @"newPassword":[self.tf_password.text MD5Hash],
                                @"validCode":self.yanZhengMa
                                };
        [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary *dict, BOOL successOrNot) {
            if ([dict[@"success"] boolValue]) {
                LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"修改密码成功" message:@"返回登录?"];
                [alert show];
                __weak typeof(self) weakSelf = self;
                [alert setYesBlock:^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }];
            } else {
                LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"修改密码失败" message:dict[@"message"]];
                [alert show];
            }
        } failure:nil];
    }
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.tf_passwordAgain) {
        kLog(@"蒙眼睛");
    }
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.tf_passwordAgain) {
        kLog(@"别蒙眼睛了");
    }
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
