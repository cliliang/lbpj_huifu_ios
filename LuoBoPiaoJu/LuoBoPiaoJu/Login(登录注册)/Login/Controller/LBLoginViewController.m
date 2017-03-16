//
//  LBLoginViewController.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBLoginViewController.h"
#import "LBRegistViewController.h"
#import "LBFindBackViewController.h"
#import "LBLoginAlert.h"
#import "LBChangeLoginPasswordVC.h"
#import "PSSUserDefaultsTool.h"
#import "CoreLockConst.h"
#import "LBFastLoginVC.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize   [UIScreen mainScreen].bounds.size


@interface LBLoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *passWord;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgetButton;
@property (weak, nonatomic) IBOutlet UIButton *regestButton;
@property (weak, nonatomic) IBOutlet UIView *view_oneLine;
@property (weak, nonatomic) IBOutlet UIView *view_twoLine;

@property (nonatomic, strong) NSArray *tfArray;

@end

@implementation LBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"button_big_normal"] forState:UIControlStateNormal];
//    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"button_big_select"] forState:UIControlStateHighlighted];
    self.view_oneLine.backgroundColor = kLineColor;
    self.view_twoLine.backgroundColor = kLineColor;
    self.navigationItem.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return"] style:UIBarButtonItemStylePlain target:self action:@selector(returnButton)];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5;
    
    self.phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing; // 清空按钮
    self.phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumber.text = self.userString ? self.userString : @"";
//    self.phoneNumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWord.secureTextEntry = YES;
    self.loginButton.backgroundColor = kNavBarColor;

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    self.loginButton.backgroundColor = [UIColor lightGrayColor];
    self.loginButton.userInteractionEnabled = NO;
    self.passWord.delegate = self;
    self.phoneNumber.delegate = self;
    self.tfArray = @[self.passWord, self.phoneNumber];
    
    self.btn_yanZhengMa.hidden = YES;
    
    LBFastLoginVC *fastLoginVC = [[NSClassFromString(@"LBFastLoginVC") alloc] init];
    fastLoginVC.userString = self.userString;
    fastLoginVC.loginSuccessBlock = self.loginSuccessBlock;
    fastLoginVC.isWebLogin = self.isWebLogin;
    [self.navigationController pushViewController:fastLoginVC animated:NO];
}
- (IBAction)clickYanZhengMaBtn:(id)sender {
    
}
// -验证码登录
- (IBAction)clickYanZhengLoginPWBtn:(id)sender {
    LBFastLoginVC *fastLoginVC = [[NSClassFromString(@"LBFastLoginVC") alloc] init];
    fastLoginVC.userString = self.userString;
    fastLoginVC.loginSuccessBlock = self.loginSuccessBlock;
    fastLoginVC.isWebLogin = self.isWebLogin;
    fastLoginVC.numberStr = self.phoneNumber.text;
    [self.navigationController pushViewController:fastLoginVC animated:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *str = textField.text;
    if (string == nil || string.length == 0) {
        if (str.length <= 1) {
            self.loginButton.backgroundColor = [UIColor lightGrayColor];
            self.loginButton.userInteractionEnabled = NO;
        }
    } else {
        if ([self boolWithTF:textField]) {
            self.loginButton.backgroundColor = kNavBarColor;
            self.loginButton.userInteractionEnabled = YES;
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
    self.loginButton.backgroundColor = [UIColor lightGrayColor];
    self.loginButton.userInteractionEnabled = NO;
    return YES;
}
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

- (void)keyboardWillAppear:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyboardFrame.size.height == 0) {
        return;
    }
    CGFloat keyHeight = keyboardFrame.size.height;
    CGFloat animaH = keyHeight - (kScreenHeight - self.loginButton.bottom) + 44;
    [UIView animateWithDuration:duration animations:^{
        self.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2 - animaH);
    }];
}
- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64);
    }];
}
- (void)returnButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickLoginButton:(id)sender {
    if (self.phoneNumber.text.length == 0) {
        [[PSSToast shareToast] showMessage:@"请输入手机号"];
    } else if (self.phoneNumber.text.length != 11) {
        [[PSSToast shareToast] showMessage:@"手机号格式不正确"];
    } else if (self.passWord.text.length == 0) {
        [[PSSToast shareToast] showMessage:@"密码不能为空"];
    } else {
        // -登录请求, 点进去看
        [self loginUpdate];
    }
    
}
- (IBAction)clickForgetButton:(id)sender {
    LBChangeLoginPasswordVC *changePw = [[LBChangeLoginPasswordVC alloc] init];
    changePw.navcTitle = @"找回密码";
    [self.navigationController pushViewController:changePw animated:YES];
}
- (IBAction)clickRegestButton:(id)sender {
    LBRegistViewController *registVC = [[LBRegistViewController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

- (void)loginUpdate
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, url_login];
    NSDictionary *param = @{
                            @"mobile":self.phoneNumber.text,
                            @"passWord":[self.passWord.text MD5Hash]
                            };
    kLog(@"%@", [self.passWord.text MD5Hash]);
    [HTTPTools POSTWithUrl:url parameter:param progress:nil success:^(NSDictionary *dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *message = dict[@"message"];
        if (![dict[@"success"] boolValue]) {
            [[PSSToast shareToast] showMessage:message];
        } else {
            LBUserModel *userModel = [LBUserModel mj_objectWithKeyValues:dict[@"rows"]];
            [PSSUserDefaultsTool saveValue:userModel.handPassword WithKey:kGesturePasswordKey];
            userModel.token = dict[@"token"];
            [userModel saveInPhone];
            [LBHTTPObject uploadDeviceTokenIfNeed];
            [LBHTTPObject POST_SignInNew];
            [PSSUserDefaultsTool saveValue:[self.passWord.text MD5Hash] WithKey:kPasswordMD5Key];
            if (self.loginSuccessBlock) {
                self.loginSuccessBlock();
            }
            
            // 判断是否是web登录
            if (!_isWebLogin) {
                [self returnButton];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        // -请求失败在请求一次试试
        [self loginUpdate];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:title message:message];
    [[UIApplication sharedApplication].delegate.window addSubview:alert];
}
+ (instancetype)login
{
    LBLoginViewController *loginVC = [LBLoginViewController new];
    LBNavigationController *naVC = [[LBNavigationController alloc] initWithRootViewController:loginVC];
    [[LBVCManager shareVCManager].tabbarVC presentViewController:naVC animated:YES completion:nil];
    return loginVC;
}

+ (void)alertLogin
{
    LBYesOrNoAlert *alert = [LBYesOrNoAlert alertWithMessage:@"您还未登录, 请登录" sureBlock:^{
        [LBLoginViewController login];
    }];
    [alert show];
}

- (void)setUserString:(NSString *)userString
{
    _userString = userString;
    self.phoneNumber.text = userString;
}
- (void)setNumberStr:(NSString *)numberStr
{
    _numberStr = numberStr;
    self.phoneNumber.text = numberStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
