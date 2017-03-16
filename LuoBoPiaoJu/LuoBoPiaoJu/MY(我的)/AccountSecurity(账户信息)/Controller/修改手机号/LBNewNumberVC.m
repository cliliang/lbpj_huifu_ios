//
//  LBNewNumberVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBNewNumberVC.h"
#import "LBShuRuView.h"
#import "LBYanZhengMaView.h"

@interface LBNewNumberVC () <UITextFieldDelegate>

@property (nonatomic, strong) LBYanZhengMaView *view1;
@property (nonatomic, strong) LBShuRuView *view2;
@property (weak, nonatomic) IBOutlet UIButton *button_next;
@property (nonatomic, strong) LBUserModel *userModel;
@property (nonatomic, strong) NSArray *tfArray;

@end

@implementation LBNewNumberVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userModel = [LBUserModel getInPhone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navcTitle = @"修改手机号";
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    backView.backgroundColor = kBackgroundColor;
    [self.view addSubview:backView];
    [self.view sendSubviewToBack:backView];
    self.button_next.backgroundColor = kNavBarColor;
    
    LBYanZhengMaView *view1 = [[LBYanZhengMaView alloc] initWithFrame:CGRectMake(0, 79 - kJian64, kScreenWidth, 50) title:@"新手机号" placeH:@"请输入新手机号"];
    [self.view addSubview:view1];
    self.view1 = view1;
    __weak typeof(self) weakSelf = self;
    [view1 setButtonBlock:^{
        // 发送验证码
        NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_yanZhengMa];
        NSMutableString *secrteString = [[NSMutableString alloc] init];
        [secrteString appendString:weakSelf.view1.textField.text];
        [secrteString appendString:kSendSecurtyType(SendSecurtyTypeChangeMobile)];
        [secrteString appendString:kDeviceType];
        [secrteString appendString:kMd5SecretCode];
        kLog(@"%@", secrteString);
        NSString *md5String = [secrteString MD5Hash];
        NSDictionary *param = @{@"mobile":weakSelf.view1.textField.text,
                                @"type":kSendSecurtyType(SendSecurtyTypeChangeMobile),
                                @"deviceType":kDeviceType,
                                @"encryptKey":md5String};
        [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
            
        } failure:nil];
    }];
    
    LBShuRuView *view2 = [[LBShuRuView alloc] initWithFrame:CGRectMake(0, 79 + 50 - kJian64, kScreenWidth, 50) title:@"验证码" placeH:@"请输入验证码"];
    [self.view addSubview:view2];
    self.view2 = view2;
    self.button_next.layer.cornerRadius = 5;
    view2.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self changeBtnBackgroundColor:NO];
    UITextField *tf1 = view1.textField;
    UITextField *tf2 = view2.textField;
    tf1.delegate = self;
    tf2.delegate = self;

    self.tfArray = @[tf1, tf2];
}
- (void)changeBtnBackgroundColor:(BOOL)animate
{
    self.button_next.userInteractionEnabled = animate;
    self.button_next.backgroundColor = animate ? kNavBarColor : [UIColor lightGrayColor];
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

- (IBAction)clickButton:(id)sender {
    if (!self.view2.textField.text) {
        [[PSSToast shareToast] showMessage:@"密码不为空, 请重新输入"];
        return;
    }
    if (!self.userModel) {
        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"您还没登录" message:@"请先登录"];
        [alert show];
        [alert setYesBlock:^{
            [LBLoginViewController login];
        }];
        return;
    }
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@", URL_HOST, url_changePhoneNumber];
    NSDictionary *param = @{
                            @"mobile":self.view1.textField.text,
                            @"userId":@(self.userModel.userId),
                            @"validCode":self.view2.textField.text,
                            @"token":self.userModel.token,
                            };
    [HTTPTools POSTWithUrl:stringUrl parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if ([dict[@"success"] boolValue]) {
            
            [[PSSToast shareToast] showMessage:@"恭喜你, 修改成功!"];
            if (self.newNumberBlock) {
                self.newNumberBlock();
            }
            UIViewController *secondVC = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:secondVC animated:YES];
            
        } else {
            [[PSSToast shareToast] showMessage:dict[@"message"]];
        }
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
