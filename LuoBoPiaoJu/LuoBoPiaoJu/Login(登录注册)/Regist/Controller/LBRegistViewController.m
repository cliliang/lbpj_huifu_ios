//
//  LBRegistViewController.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBRegistViewController.h"
#import "LBUserServerProtocolVC.h"

@interface LBRegistViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tf_yaoQingMa;
@property (weak, nonatomic) IBOutlet UITextField *tf_phoneNmuber;
@property (weak, nonatomic) IBOutlet UITextField *tf_yanZhengMa;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btn_agree;
@property (weak, nonatomic) IBOutlet UIButton *btn_regist;
@property (weak, nonatomic) IBOutlet UIButton *btn_yanZhengMa;
@property (weak, nonatomic) IBOutlet UIView *lineView_investCode;

@property (nonatomic, assign) BOOL agree; // 是否同意协议
@property (nonatomic, assign) BOOL userProtocol; // 是否勾选用户协议

@property (nonatomic, strong) NSArray *tfArray;

@end

@implementation LBRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"已有账号" titleColor:[UIColor whiteColor] highColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] target:self action:@selector(clickIHad) forControlEvents:UIControlEventTouchUpInside];
    self.tf_phoneNmuber.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf_yanZhengMa.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.tf_yanZhengMa.keyboardType = UIKeyboardTypeNumberPad;
    self.tf_phoneNmuber.keyboardType = UIKeyboardTypeNumberPad;
//    self.tf_yaoQingMa.keyboardType = UIKeyboardTypeTwitter;
    self.tf_yaoQingMa.keyboardType = UIKeyboardTypeAlphabet;
    self.agree = YES; // 默认同意协议
    
    self.btn_regist.layer.cornerRadius = 5;
    self.btn_regist.backgroundColor = kNavBarColor;
    [self addGestureInImageView]; // 两个图片的手势
    
//    [self addRegistFooterImg];
    [self addRegistFooterLabel];
    [self addIHaveInviteCodeBtn];
    
    [self changeBtnBackgroundColor:NO];
    UITextField *tf1 = self.tf_phoneNmuber;
    UITextField *tf2 = self.tf_yanZhengMa;
    tf1.delegate = self;
    tf2.delegate = self;
    self.tfArray = @[tf1, tf2];
    
}
- (void)addIHaveInviteCodeBtn
{
    __block BOOL showBtn = YES;
    self.tf_yaoQingMa.hidden = showBtn;
    self.lineView_investCode.hidden = showBtn;
    UIButton *button = [UIButton buttonWithNormalColor:kLightColor highColor:kLightColor backgroundColor:[UIColor clearColor] fontSize:[UIFont pingfangWithFloat:KAutoHDiv2(30) weight:UIFontWeightLight] title:@"我有邀请码"];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.tf_yaoQingMa);
    }];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        showBtn = !showBtn;
        self.tf_yaoQingMa.hidden = showBtn;
        self.lineView_investCode.hidden = showBtn;
        button.hidden = !showBtn;
    }];
}

- (void)changeBtnBackgroundColor:(BOOL)animate
{
    self.btn_regist.userInteractionEnabled = animate;
    self.btn_regist.backgroundColor = animate ? kNavBarColor : [UIColor lightGrayColor];
}

- (void)addRegistFooterLabel
{
    UILabel *label_Footer = [UILabel new];
    [label_Footer setText:@"萝卜票据保证, 任何情况下绝不泄露您的个人隐私" textColor:UIColorFromHexString(@"929292", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightLight]];
    [self.view addSubview:label_Footer];
    [label_Footer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(26));
        make.bottom.mas_equalTo(KAutoHDiv2(-80));
        make.centerX.mas_equalTo(self.view);
    }];
}
- (void)addRegistFooterImg
{
    UIImageView *imageV = [[UIImageView alloc] init];
    [self.view addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"image_resign_footer"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btn_regist.mas_bottom).offset(KAutoHDiv2(68));
        make.bottom.mas_equalTo(self.view).offset(-KAutoHDiv2(68));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(imageV.mas_height).multipliedBy(414 / 332.0);
    }];
}
- (void)addGestureInImageView
{
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.imageView addGestureRecognizer:tap];
}
- (void)tapGesture
{
    kLog(@"点击图片了");
    _agree = !_agree;
    UIImage *image1 = [UIImage imageNamed:@"icon_agreeProtocol"];
    UIImage *image2 = [UIImage imageNamed:@"icon_disAgreeProtocol"];
    self.imageView.image = _agree ? image1 : image2;
}

// 已有账号
- (void)clickIHad
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 点击验证码
- (IBAction)clickYanZhengMa:(id)sender {
    if (self.tf_phoneNmuber.text.length != 11) {
        [[PSSToast shareToast] showMessage:@"手机号格式不正确"];
        return;
    }
    [[PSSToast shareToast] showMessage:@"验证码发送成功"];
    self.btn_yanZhengMa.userInteractionEnabled = NO;
    LBYanZhengMaTimer *timer = [[LBYanZhengMaTimer alloc] init];
    [timer setTimeBlock:^(NSInteger second) {
        if (second == 0) {
            self.btn_yanZhengMa.titleLabel.text = @"获取验证码"; // 位置决定是否闪烁
            [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
            [sender setTitle:@"获取验证码" forState:UIControlStateHighlighted];
            [sender setTitle:@"获取验证码" forState:UIControlStateSelected];
            self.btn_yanZhengMa.userInteractionEnabled = YES;
        } else {
            self.btn_yanZhengMa.titleLabel.text = [NSString stringWithFormat:@"%ld秒", (long)second];
            [sender setTitle:[NSString stringWithFormat:@"%ld秒", (long)second] forState:UIControlStateHighlighted];
            [sender setTitle:[NSString stringWithFormat:@"%ld秒", (long)second] forState:UIControlStateNormal];
            [sender setTitle:[NSString stringWithFormat:@"%ld秒", (long)second] forState:UIControlStateSelected];
        }
    }];
    [timer timeFire];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, url_yanZhengMa];
    NSMutableString *secrteString = [[NSMutableString alloc] init];
    [secrteString appendString:self.tf_phoneNmuber.text];
    [secrteString appendString:kSendSecurtyType(SendSecurtyTypeRegister)];
    [secrteString appendString:kDeviceType];
    [secrteString appendString:kMd5SecretCode];
    kLog(@"%@", secrteString);
    NSString *md5String = [secrteString MD5Hash];
    NSDictionary *param = @{@"mobile":self.tf_phoneNmuber.text,
                            @"type":kSendSecurtyType(SendSecurtyTypeRegister),
                            @"deviceType":kDeviceType,
                            @"encryptKey":md5String};
    [HTTPTools POSTWithUrl:url parameter:param progress:nil success:^(NSDictionary *dict, BOOL successOrNot) {
    } failure:nil];
}

- (IBAction)clickUserProtocol:(id)sender {
    LBUserServerProtocolVC *proVC = [[LBUserServerProtocolVC alloc] init];
    [self.navigationController pushViewController:proVC animated:YES];
}

- (IBAction)clickRegistBtn:(id)sender {
    if (self.tf_phoneNmuber.text.length != 11) {
        [[PSSToast shareToast] showMessage:@"手机号格式不正确"];
    } else if (self.tf_yanZhengMa.text.length == 0) {
        [[PSSToast shareToast] showMessage:@"验证码不能为空"];
    } else if (!self.agree) {
        [[PSSToast shareToast] showMessage:@"您未同意用户服务协议"];
    } else {
        [self registUpdate]; // 注册
    }
}

- (void)registUpdate
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, url_fastRegist];
    NSDictionary *param = @{
                            @"mobile"   :self.tf_phoneNmuber.text,
                            @"validCode":self.tf_yanZhengMa.text,
                            @"beInviteCode":self.tf_yaoQingMa.text,
                            @"deviceType":@"ios"
                            };
    
    [HTTPTools POSTWithUrl:url parameter:param progress:nil success:^(NSDictionary *dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dict[@"success"] boolValue]) {
            [[PSSToast shareToast] showMessage:@"注册成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [[PSSToast shareToast] showMessage:dict[@"message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
// -限制密码最高20位 , 并且只能输入数组和字母
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
