//
//  LBXiuGaiShouJiHaoVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBXiuGaiShouJiHaoVC.h"
#import "LBShuRuView.h"
#import "LBYanZhengMaView.h"
#import "LBNewNumberVC.h"


@interface LBXiuGaiShouJiHaoVC () <UITextFieldDelegate>

@property (nonatomic, strong) LBShuRuView *view1;
@property (nonatomic, strong) LBYanZhengMaView *view2;
@property (nonatomic, strong) LBShuRuView *view3;
@property (weak, nonatomic) IBOutlet UIButton *button_next;
@property (nonatomic, strong) LBUserModel *userModel;

@property (nonatomic, strong) NSArray *tfArray;

@end

@implementation LBXiuGaiShouJiHaoVC

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
    
    LBShuRuView *view1 = [[LBShuRuView alloc] initWithFrame:CGRectMake(0, 79 + 100 - kJian64, kScreenWidth, 50) title:@"登录密码" placeH:@"请输入登录密码"];
    [self.view addSubview:view1];
    self.view1 = view1;
    view1.textField.secureTextEntry = YES;
    
    LBYanZhengMaView *view2 = [[LBYanZhengMaView alloc] initWithFrame:CGRectMake(0, 79 - kJian64, kScreenWidth, 50) title:@"原手机号" placeH:@"请输入原手机号"];
    [self.view addSubview:view2];
    self.view2 = view2;
    __weak typeof(self) weakSelf = self;
    [view2 setButtonBlock:^{
        // 发送验证码
        NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_yanZhengMa];
        NSDictionary *param = @{@"mobile":weakSelf.view2.textField.text};
        [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
            
        } failure:nil];
    }];
    
    // --- 79 + 50 - kJian64
    LBShuRuView *view3 = [[LBShuRuView alloc] initWithFrame:CGRectMake(0, 79 + 50 - kJian64, kScreenWidth, 50) title:@"验证码" placeH:@"请输入验证码"];
    [self.view addSubview:view3];
    self.view3 = view3;
    view3.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.button_next.layer.cornerRadius = 5;
    self.button_next.backgroundColor = kNavBarColor;
    
    
    [self changeBtnBackgroundColor:NO];
    UITextField *tf1 = view1.textField;
    UITextField *tf2 = view2.textField;
    UITextField *tf3 = view3.textField;
    tf1.delegate = self;
    tf2.delegate = self;
    tf3.delegate = self;
    self.tfArray = @[tf1, tf2, tf3];
    
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





- (IBAction)button_next:(id)sender {
    if (!self.view1.textField.text) {
        [[PSSToast shareToast] showMessage:@"密码不能为空"];
        return;
    } else if (!self.view3.textField.text) {
        [[PSSToast shareToast] showMessage:@"验证码不能为空"];
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
    NSString *stringUrl = [NSString stringWithFormat:@"%@%@", URL_HOST, url_jianChaYongHu];
    NSDictionary *param = @{
                            @"passWord":[self.view1.textField.text MD5Hash],
                            @"mobile":self.view2.textField.text,
                            @"userId":@(self.userModel.userId),
                            @"validCode":self.view3.textField.text,
                            @"token":self.userModel.token,
                            };
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HTTPTools POSTWithUrl:stringUrl parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dict[@"success"] boolValue]) {
            LBNewNumberVC *newVC = [LBNewNumberVC new];
            [self.navigationController pushViewController:newVC animated:YES];
            [newVC setNewNumberBlock:^{
                if (self.xiuGaiPhoneNumberBlock) {
                    self.xiuGaiPhoneNumberBlock();
                }
            }];
            
        } else {
//            LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:dict[@"message"] message:@"验证失败"];
//            [alert show];
            [[PSSToast shareToast] showMessage:dict[@"message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
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
