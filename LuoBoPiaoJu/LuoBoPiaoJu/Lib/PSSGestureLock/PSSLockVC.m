//
//  PSSLockVC.m
//  PSSGestureLock
//
//  Created by 庞仕山 on 16/7/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSLockVC.h"
#import "PSSLockView.h"
#import "PSSSignView.h"
#import "CoreLockConst.h"
#import <Masonry.h>
#import "CALayer+Anim.h"
#import "CoreArchive.h"
#import "LBGestureTimeView.h"
#import "LBForgetGesAlert.h"
#import "LBChangeLoginPasswordVC.h"


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize   [UIScreen mainScreen].bounds.size

@interface PSSLockVC ()

@property (nonatomic, strong) PSSLockView *lockView;
@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) LBGestureTimeView *timeView;
@property (nonatomic, strong) PSSSignView *signView;

@property (nonatomic, strong) UIButton *forgetGesPW;
@property (nonatomic, strong) UIButton *forgetLoginPW;

@property (nonatomic, assign) BOOL isTimeView;

@end

@implementation PSSLockVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_timeView whatTimeIsIt];
    if (self.navExistingStyle == LBNavigationExistingStyleNO) {
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 64)] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.hidden = YES;
    } else {
        self.navigationController.navigationBar.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 1. signView
    PSSSignView *signView = [[PSSSignView alloc] init];
    [self.view addSubview:signView];
    [signView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.navExistingStyle == LBNavigationExistingStyleNO) {
            make.top.mas_equalTo(self.view).offset(64 + div_2(136));
        } else {
            make.top.mas_equalTo(self.view).offset(64 + div_2(136) - kJian64);
        }
        make.centerX.mas_equalTo(self.view);
        make.width.and.height.mas_equalTo(54);
    }];
    self.signView = signView;
    
    PSSLockView *lockView = [[PSSLockView alloc] init];
    [self.view addSubview:lockView];
    [lockView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.navExistingStyle == LBNavigationExistingStyleNO) {
            make.top.mas_equalTo(self.view).offset(kAutoH(div_2(556)));
        } else {
            make.top.mas_equalTo(self.view).offset(kAutoH(div_2(556)) - 50);
        }
        make.left.and.right.and.width.mas_equalTo(self.view);
        make.height.mas_equalTo(250);
    }];
    lockView.backgroundColor = [UIColor clearColor];
    self.lockView = lockView;
    self.lockView.lockStyle = _lockStyle;
    
    UILabel *signLabel = [[UILabel alloc] init];
    [self.view addSubview:signLabel];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        CGFloat bottom = -40;
        if (kIPHONE_5s) {
            bottom = -13;
        }
        make.bottom.mas_equalTo(lockView.mas_top).offset(bottom);
        make.height.mas_equalTo(15);
    }];
    self.signLabel = signLabel;
    signLabel.textColor = kLightColor;
    signLabel.font = [UIFont systemFontOfSize:15];
    
    LBGestureTimeView *timeView = [[LBGestureTimeView alloc] init];
    [self.view addSubview:timeView];
    _timeView = timeView;
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (self.navExistingStyle == LBNavigationExistingStyleNO) {
            make.top.mas_equalTo(self.view).offset(kAutoH(div_2(179.0)));
            make.left.mas_equalTo(self.view).offset(kAutoW(div_2(102)));
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(signLabel);
        } else {
            make.top.mas_equalTo(self.view).offset(kAutoH(div_2(243.0 )) - kJian64);
            make.left.mas_equalTo(self.view).offset(kAutoW(div_2(102)));
            make.right.mas_equalTo(self.view);
            make.bottom.mas_equalTo(signLabel);
        }
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom normalColor:kLightColor highColor:kLightColor fontSize:13 target:self action:@selector(forgetLoginAction) forControlEvents:UIControlEventTouchUpInside title:@"忘记登录密码"];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-40);
        make.left.mas_equalTo(self.view).offset(25);
    }];
    
    UIButton *gesBtn = [UIButton buttonWithType:UIButtonTypeCustom normalColor:kLightColor highColor:kLightColor fontSize:13 target:self action:@selector(forgetGestureAction) forControlEvents:UIControlEventTouchUpInside title:@"验证登录密码"];
    [self.view addSubview:gesBtn];
    [gesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(loginBtn);
        make.right.mas_equalTo(self.view).offset(-25);
    }];
    
    _forgetLoginPW = loginBtn;
    _forgetGesPW = gesBtn;
    
    // 少于4个
    [lockView setLessThanFourBlock:^{
        // 以下判断是: 当密码小于4位, 是否计入到五次错误中
        if (lockView.lockStyle == PSSLockStyleSet) {
            signLabel.text = CoreLockLabelLessThanLeast;
        } else {
            [self decreaseInputCount];
        }
        signLabel.textColor = kNavBarColor;
        [signLabel.layer shake];
    }];
    
    // 设置密码
    [lockView setFirstSettingBlock:^(NSString *password) {
        signLabel.text = CoreLockLabelSecondSetting;
        signLabel.textColor = kLightColor;
        [signView showWithString:password];
        [self addRightNavItem];
    }];
    [lockView setFailureSetBlock:^{
        signLabel.text = CoreLockLabelFailureSetting;
        signLabel.textColor = kNavBarColor;
        [signLabel.layer shake];
    }];
    [lockView setSuccessSetBlock:^(NSString *password) {
        signLabel.text = CoreLockLabelSuccessSetting;
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        [CoreArchive setStr:password key:kGesturePasswordKey];
        [CoreArchive setInt:5 key:kGesturePasswordErrorCountKey];
        [LBHTTPObject postWithGesPassword:password userId:(int)[LBUserModel getInPhone].userId token:[LBUserModel getInPhone].token success:nil failure:nil];
        if (self.successBlock) {
            self.successBlock();
        }
    }];
    
    // 验证密码
    [lockView setFailureVerifyBlock:^{
        signLabel.text = CoreLockLabelFailureVerify;
        [self decreaseInputCount];
        signLabel.textColor = kNavBarColor;
        [signLabel.layer shake];
    }];
    [lockView setSuccessVerifyBlock:^{
        signLabel.text = CoreLockLabelSuccessVerify;
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        [CoreArchive setInt:5 key:kGesturePasswordErrorCountKey];
        if (self.successBlock) {
            self.successBlock();
        }
    }];
    
    // 修改密码
    [lockView setFailureAllowBlock:^{
        signLabel.text = CoreLockLabelFailureVerify;
        [self decreaseInputCount];
        signLabel.textColor = kNavBarColor;
        [signLabel.layer shake];
    }];
    [lockView setSuccessAllowBlock:^{
        self.isTimeView = NO;
        signLabel.text = CoreLockLabelFirstSetting;
        signLabel.textColor = kLightColor;
        [CoreArchive setInt:5 key:kGesturePasswordErrorCountKey];
    }];
    
    // 关闭手势密码
    [lockView setSuccessRemoveBlock:^{
        [self removeGesture];
    }];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return"] style:UIBarButtonItemStyleDone target:self action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    if (self.leftBtnStyle == PSSLockVCLeftBtnStyleNone) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    [self showTimeViewOrNot];
}
- (void)verifySuccess // 验证成功 - 外部使用
{
    _signLabel.text = CoreLockLabelSuccessVerify;
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [CoreArchive setInt:5 key:kGesturePasswordErrorCountKey];
    if (self.successBlock) {
        self.successBlock();
    }
}

- (void)forgetLoginAction
{
    LBChangeLoginPasswordVC *vc = [[LBChangeLoginPasswordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [vc setSuccessBlock:^{
        if (self.lockStyle == PSSLockStyleRemove) {
            [self removeGesture];
        } else {
            self.lockStyle = PSSLockStyleSet;
        }
    }];
}
- (void)forgetGestureAction
{
    [LBForgetGesAlert showWithYesBlock:^(NSString *password) {
        kLineLog(@"%@", password);
        [self loginUpdateWithPassword:password];
    }];
}

- (void)removeGesture
{
    [CoreArchive removeStrForKey:kGesturePasswordKey];
    [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:NO] WithKey:kFingerLockBool];
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    [CoreArchive setInt:5 key:kGesturePasswordErrorCountKey];
    [LBHTTPObject postWithGesPassword:@"" userId:(int)[LBUserModel getInPhone].userId token:[LBUserModel getInPhone].token success:nil failure:nil];
    if (self.successBlock) {
        self.successBlock();
    }
}

- (void)addRightNavItem
{
    UIBarButtonItem *rightItem = [UIBarButtonItem barButtonItemWithTitle:@"重置" titleColor:[UIColor whiteColor] highColor:[UIColor whiteColor] target:self action:@selector(clickRightItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)clickRightItem
{
    self.lockView.firstPassword = nil;
    self.lockStyle = PSSLockStyleSet;
    [self.signView showWithString:@""];
}

// 登录请求
- (void)loginUpdateWithPassword:(NSString *)password
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, url_login];
    [HTTPTools POSTWithUrl:url parameter:@{@"mobile":[LBUserModel getInPhone].mobile, @"passWord":[password MD5Hash]} progress:nil success:^(NSDictionary *dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (![dict[@"success"] boolValue]) {
            LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:@"验证登录密码失败"];
            [alert show];
        } else {
            LBUserModel *userModel = [LBUserModel mj_objectWithKeyValues:dict[@"rows"]];
            [PSSUserDefaultsTool saveValue:userModel.handPassword WithKey:kGesturePasswordKey];
            userModel.token = dict[@"token"];
            [userModel saveInPhone];
            self.navigationItem.title = @"设置密码";
            if (self.lockStyle == PSSLockStyleRemove) {
                [self removeGesture];
            } else {
                self.lockStyle = PSSLockStyleSet;
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)leftBtnAction
{
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

- (void)presentViewControllerWithVC:(UIViewController *)VC
{
    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:self];
    [VC presentViewController:naVC animated:NO completion:nil];
}

- (void)decreaseInputCount
{
    NSInteger count = [CoreArchive intForKey:kGesturePasswordErrorCountKey];
    count--;
    if (count <= 0) { // 超过五次走这里
        [self.navigationController dismissViewControllerAnimated:NO completion:nil];
        [CoreArchive setInt:5 key:kGesturePasswordErrorCountKey];
        [LBUserModel deleteGesPassword];
        [[LBVCManager shareVCManager] instanceMainRoot];
        [LBVCManager hideMessageView];
        
        LBLoginViewController *loginVC = [LBLoginViewController new];
        LBNavigationController *naVC = [[LBNavigationController alloc] initWithRootViewController:loginVC];
        [[LBVCManager shareVCManager].tabbarVC presentViewController:naVC animated:NO completion:nil];
        loginVC.userString = kUserModel.mobile;
        [LBUserModel deleteInPhone];
        
        return;
    }
    [CoreArchive setInt:count key:kGesturePasswordErrorCountKey];
    self.signLabel.text = [NSString stringWithFormat:@"密码错误, 还可以再输入%ld次", count];
}

// 指纹解锁
- (void)zhiWenJieSuo
{
    [PSSFingerLock unlockFingerSuccess:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self verifySuccess];
        });
    }];
}

- (void)setLockStyle:(PSSLockStyle)lockStyle
{
    _lockStyle = lockStyle;
    _lockView.lockStyle = lockStyle;
    self.signLabel.textColor = kLightColor;
    switch (_lockStyle) {
        case PSSLockStyleSet: {
            self.signLabel.text = CoreLockLabelFirstSetting;
            self.isTimeView = NO;
            break;
        }
        case PSSLockStyleVerify: {
            self.signLabel.text = CoreLockLabelPleaseVerify;
            self.isTimeView = YES;
            break;
        }
        case PSSLockStyleReset: {
            self.signLabel.text = CoreLockLabelPleaseVerify;
            self.isTimeView = YES;
            break;
        }
        case PSSLockStyleRemove: {
            self.signLabel.text = CoreLockLabelPleaseVerify;
            self.isTimeView = YES;
            break;
        }
        default:
            break;
    }
}

- (void)showTimeViewOrNot
{
    switch (_lockStyle) {
        case PSSLockStyleSet: {
            self.signLabel.text = CoreLockLabelFirstSetting;
            self.isTimeView = NO;
            break;
        }
        case PSSLockStyleVerify: {
            self.signLabel.text = CoreLockLabelPleaseVerify;
            self.isTimeView = YES;
            break;
        }
        case PSSLockStyleReset: {
            self.signLabel.text = CoreLockLabelPleaseVerify;
            self.isTimeView = YES;
            break;
        }
        case PSSLockStyleRemove: {
            self.signLabel.text = CoreLockLabelPleaseVerify;
            self.isTimeView = YES;
            break;
        }
        default:
            break;
    }
}

- (void)setIsTimeView:(BOOL)isTimeView
{
    _isTimeView = isTimeView;
    self.signView.hidden = isTimeView;
    self.timeView.hidden = !isTimeView;
    
    _forgetLoginPW.hidden = !isTimeView;
    _forgetGesPW.hidden = !isTimeView;
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
