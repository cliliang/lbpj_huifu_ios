//
//  LBChangeLoginPasswordVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBChangeLoginPasswordVC.h"
#import "LBYanZhengMaView.h"
#import "LBShuRuView.h"

@interface LBChangeLoginPasswordVC () <UITextFieldDelegate>

@property (nonatomic, strong) LBYanZhengMaView *view_1;
@property (nonatomic, strong) LBShuRuView *view_2;
@property (nonatomic, strong) LBShuRuView *view_3;
@property (nonatomic, strong) LBShuRuView *view_4;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic, strong) LBUserModel *userModel;

@property (nonatomic, strong) NSArray *tfArray;

@end

@implementation LBChangeLoginPasswordVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userModel = [LBUserModel getInPhone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"修改登录密码";
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = kBackgroundColor;
    [self.view addSubview:backView];
    [self.view sendSubviewToBack:backView];
    self.nextButton.layer.cornerRadius = 5;
    self.nextButton.backgroundColor = kNavBarColor;
    self.navigationItem.title = self.navigationItem.title.length ? self.navigationItem.title : @"修改密码";
    
    // 1
    LBYanZhengMaView *view1 = [[LBYanZhengMaView alloc] initWithFrame:CGRectMake(0, 79 - kJian64, kScreenWidth, 50) title:@"手机号" placeH:@"请输入手机号"];
    [self.view addSubview:view1];
    self.view_1 = view1;
    __weak typeof(self) weakSelf = self;
    [view1 setButtonBlock:^{
        if (view1.textField.text.length != 11) {
            [[PSSToast shareToast] showMessage:@"请输入正确的手机号"];
        } else {
            // 发送验证码
            [[PSSToast shareToast] showMessage:@"验证码发送成功"];
            NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_yanZhengMa];
            NSDictionary *param = @{@"mobile":weakSelf.view_1.textField.text};
            [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
                
            } failure:nil];
        }
    }];
    
    // 2
    LBShuRuView *view2 = [[LBShuRuView alloc] initWithFrame:CGRectMake(0, 79 - kJian64 + 50 * 1, kScreenWidth, 50) title:@"验证码" placeH:@"请输入验证码"];
    [self.view addSubview:view2];
    self.view_2 = view2;
    view2.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    // 3
    LBShuRuView *view3 = [[LBShuRuView alloc] initWithFrame:CGRectMake(0, 79 - kJian64 + 50 * 2, kScreenWidth, 50) title:@"新密码" placeH:@"请输入新密码"];
    [self.view addSubview:view3];
    self.view_3 = view3;
    view3.textField.secureTextEntry = YES;
    
    // 4
    LBShuRuView *view4 = [[LBShuRuView alloc] initWithFrame:CGRectMake(0, 79 - kJian64 + 50 * 3, kScreenWidth, 50) title:@"确认密码" placeH:@"请确认密码"];
    [self.view addSubview:view4];
    self.view_4 = view4;
    view4.textField.secureTextEntry = YES;
    
    [self changeBtnBackgroundColor:NO];
    UITextField *tf1 = view1.textField;
    UITextField *tf2 = view2.textField;
    UITextField *tf3 = view3.textField;
    UITextField *tf4 = view4.textField;
    tf1.delegate = self;
    tf2.delegate = self;
    tf3.delegate = self;
    tf4.delegate = self;
    self.tfArray = @[tf1, tf2, tf3, tf4];
}
- (void)changeBtnBackgroundColor:(BOOL)animate
{
    self.nextButton.userInteractionEnabled = animate;
    self.nextButton.backgroundColor = animate ? kNavBarColor : [UIColor lightGrayColor];
}
// 键盘输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = textField.text;
    if (string == nil || string.length == 0) {
        if (str.length <= 1) {
            [self changeBtnBackgroundColor:NO];
        }
    } else {
        if ([self boolWithTF:textField]) {
            [self changeBtnBackgroundColor:YES];
        }
    }
    if (textField.secureTextEntry == YES && string.length == 0 && textField.text.length > 0) {
        textField.text = [str substringToIndex:str.length - 1];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self changeBtnBackgroundColor:NO];
    return YES;
}
// -其他textField是否全有值
- (BOOL)boolWithTF:(UITextField *)textF
{
    for (UITextField *tf in self.tfArray) {
        if (tf != textF) {
            if (tf.text == nil || tf.text.length == 0) {
                return NO;
            }
        }
    }
    return YES;
}


- (IBAction)clickNextButton:(id)sender {
    if (!self.view_1.textField.text || self.view_1.textField.text.length == 0) {
        [[PSSToast shareToast] showMessage:@"手机号不能为空"];
    } else if (!self.view_2.textField.text || self.view_2.textField.text.length == 0) {
        [[PSSToast shareToast] showMessage:@"验证码不能为空"];
    } else if (self.view_3.textField.text.length < 6) {
        [[PSSToast shareToast] showMessage:@"密码长度不能小于6位"];
    } else if (self.view_4.textField.text.length < 6) {
        [[PSSToast shareToast] showMessage:@"密码不能少于6位"];
    } else if (![self.view_3.textField.text isEqualToString:self.view_4.textField.text]) {
        [[PSSToast shareToast] showMessage:@"密码与确认密码不一致，请重新输入"];
    } else {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *stringUrl = [NSString stringWithFormat:@"%@%@", URL_HOST, url_changePassword];
        NSDictionary *param = @{
                                @"newPassword":[self.view_3.textField.text MD5Hash],
                                @"mobile":self.view_1.textField.text,
                                @"validCode":self.view_2.textField.text,
//                                @"token":self.userModel.token
                                };
        
        [HTTPTools POSTWithUrl:stringUrl parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([dict[@"success"] boolValue]) {
                [[PSSToast shareToast] showMessage:@"修改密码成功"];
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                [[PSSToast shareToast] showMessage:@"修改密码失败"];
            }
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }
    
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:title message:message];
    [alert show];
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
