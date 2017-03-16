//
//  LBAccountSecurityVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBAccountSecurityVC.h"
#import "LBAccountSecurityCell.h"
#import "LBXiuGaiShouJiHaoVC.h"
#import "LBChangeLoginPasswordVC.h"
#import "LBAnQuanCircleView.h"
#import "LBGesturePasswordCell.h"
#import "PSSLockVC.h"
#import "CoreLockConst.h"
#import "PSSUserDefaultsTool.h"
#import "LBBankCardManagerVC.h"

#define kAccountSecurityCellId @"AccountSecurityCellId"

@interface LBAccountSecurityVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) LBUserModel *userModel;

@end

@implementation LBAccountSecurityVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userModel = [LBUserModel getInPhone];
    if (!self.userModel) {
        return;
    }
    [self setUIForUserModel];
    [self.tableView reloadData];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.titleArray = @[@"实名认证", @"手机号码", @"登录密码"];
    [self fingerLockSupport:^{
        self.titleArray = @[@"实名认证", @"绑定银行卡", @"手机号码", @"登录密码", @"指纹密码", @"手势密码"];
    } unsupport:^{
//        self.titleArray = @[@"实名认证", @"绑定银行卡", @"手机号码", @"登录密码", @"手势密码"];
        self.titleArray = @[@"实名认证", @"绑定银行卡", @"手机号码", @"登录密码", @"指纹密码", @"手势密码"];
    }];
    self.navigationItem.title = @"账户信息";
    [self addTableViewInThisView];
    self.userModel = [LBUserModel getInPhone];
    [self addAnQuanDengJiCircle];
}
- (void)dealloc
{
    [self fingerLockSupport:^{
        // 拿到指纹cell
        LBGesturePasswordCell *fingerCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.titleArray.count - 2 inSection:0]];
        if (fingerCell.swi.on != [[PSSUserDefaultsTool getValueWithKey:kFingerLockBool] boolValue]) {
            [PSSUserDefaultsTool saveValue:@(NO) WithKey:kFingerLockBool];
        }
    } unsupport:^{
        
    }];
}


- (void)fingerLockSupport:(void(^)(void))support unsupport:(void(^)(void))unsupport
{
    BOOL isSupportFingerLock = [[PSSUserDefaultsTool getValueWithKey:kSupportingFingerLock] boolValue];
    if (isSupportFingerLock) {
        if (support) {
            support();
        }
    } else {
        if (unsupport) {
            unsupport();
        }
    }
}


- (void)setUIForUserModel
{
    NSString *string_renzheng = [LBUserModel getInPhone].isAutonym ? [LBUserModel getSecretUserName] : @"未认证";
    NSString *phoneNumber = [LBUserModel getInPhone].mobile;
    NSString *string_shoujihao = phoneNumber ? [NSString stringWithFormat:@"%@****%@", [phoneNumber substringToIndex:3], [phoneNumber substringWithRange:NSMakeRange(7, 4)]] : @"";
    NSString *string_mima = @"修改";
    
    NSString *string_card = [LBUserModel getSecretBankCard].length ? [LBUserModel getSecretBankCard] : @"未绑定";
    
    self.contentArray = @[string_renzheng, string_card, string_shoujihao, string_mima, @"", @""];
}

//
- (void)addAnQuanDengJiCircle
{
    if (self.userModel == nil) {
        return;
    }
    
    CGFloat top = 20;
    CGFloat width = 141;
    
    CGFloat x_cir = (kScreenWidth - width) / 2;
    CGFloat y_cir = top + 3;
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = kNavBarColor;
    label.font = [UIFont systemFontOfSize:24];
    [self.tableView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView).offset(79);
        make.centerX.mas_equalTo(self.tableView);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"您的账户安全等级为";
    label1.textColor = kDeepColor;
    label1.font = [UIFont systemFontOfSize:15];
    [self.tableView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView).offset(div_2(40 + 255));
        make.centerX.mas_equalTo(self.tableView);
    }];
    
    if (self.userModel.bankCard) { // 高
        LBAnQuanCircleView *anquanView = [[LBAnQuanCircleView alloc] initWithFrame:CGRectMake(x_cir, y_cir, width, width) backWidth:5 frontWidth:7 progress:1.0 fromColor:[UIColor colorWithRGBString:@"f3f3f3"] toColor:[UIColor colorWithRGBString:@"7cedbd"]];
        [self.tableView addSubview:anquanView];
        [anquanView animationStartWithTime:2];
        label.text = @"高";
        label.textColor = [UIColor colorWithRGBString:@"7cedbd"];
    } else if (self.userModel.isAutonym) { // 中
        LBAnQuanCircleView *anquanView = [[LBAnQuanCircleView alloc] initWithFrame:CGRectMake(x_cir, y_cir, width, width) backWidth:5 frontWidth:7 progress:0.666667 fromColor:[UIColor colorWithRGBString:@"f3f3f3"] toColor:[UIColor colorWithRGBString:@"ffc562"]];
        [self.tableView addSubview:anquanView];
        [anquanView animationStartWithTime:2];
        label.text = @"中";
        label.textColor = [UIColor colorWithRGBString:@"ffc562"];
        
    } else { // 低
        LBAnQuanCircleView *anquanView = [[LBAnQuanCircleView alloc] initWithFrame:CGRectMake(x_cir, y_cir, width, width) backWidth:5 frontWidth:7 progress:0.33333 fromColor:[UIColor colorWithRGBString:@"f3f3f3"] toColor:[UIColor colorWithRGBString:@"ff7f68"]];
        [self.tableView addSubview:anquanView];
        [anquanView animationStartWithTime:2];
        label.text = @"低";
        label.textColor = [UIColor colorWithRGBString:@"ff7f68"];
    }
}

// 添加collectionView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 190)];
    tableView.tableHeaderView = view;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 190)];
    [tableView addSubview:headerView];
    tableView.scrollEnabled = NO;
    tableView.backgroundColor = kBackgroundColor;
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *str = [PSSUserDefaultsTool getValueWithKey:kGesturePasswordKey];
    if (str == nil || str.length == 0 || [str isKindOfClass:[NSNull class]]) {
        return self.titleArray.count;
    } else {
        return self.titleArray.count + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  && [[PSSUserDefaultsTool getValueWithKey:kSupportingFingerLock] boolValue]
    if (indexPath.row == self.titleArray.count - 2) { // 指纹
        static NSString *identifier = @"LBGesturePasswordCellID";
        LBGesturePasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LBGesturePasswordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier cellStyle:LBGesturePasswordCellStyleNone];
        }
        cell.showLineView = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title = self.titleArray[indexPath.row];
        __weak typeof(cell) weakCell = cell;
        [cell setChangeBlock:^(BOOL theOn) {
            
            LBGesturePasswordCell *gesCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.titleArray.count - 1 inSection:0]];
            if (gesCell.swi.on) {
                //
            } else {
                if (theOn) {
                    weakCell.swi.on = NO;
                    if (gesCell.clickBlock) {
                        gesCell.clickBlock();
                    }
                }
            }
            
        }];
        
        return cell;
        
        
    } else if (indexPath.row == self.titleArray.count - 1) { // 手势密码
        static NSString *identifier = @"LBGesturePasswordCellID";
        LBGesturePasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[LBGesturePasswordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier cellStyle:LBGesturePasswordCellStyleDefault];
        }
        cell.showLineView = YES;
        __weak typeof(cell) weakCell = cell;
        [cell setClickBlock:^{
            __block PSSLockVC *lockVC = [[PSSLockVC alloc] init];
            NSString *gesPW = [PSSUserDefaultsTool getValueWithKey:kGesturePasswordKey];
            if ([gesPW isEqualToString:@""] || gesPW == nil || [gesPW isKindOfClass:[NSNull class]]) {
                lockVC.lockStyle = PSSLockStyleSet;
                lockVC.navigationItem.title = @"设置手势密码";
            } else {
                lockVC.navigationItem.title = @"关闭手势密码";
                lockVC.lockStyle = PSSLockStyleRemove;
                [PSSFingerLock unlockFingerSuccess:^{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [lockVC removeGesture];
                    });
                }];
            }
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:lockVC];
            [self.navigationController presentViewController:naVC animated:NO completion:nil];
        
            [lockVC setSuccessBlock:^{
                
                [self fingerLockSupport:^{
                    // 拿到指纹cell
                    LBGesturePasswordCell *fingerCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.titleArray.count - 2 inSection:0]];
                    
                    NSString *gesPW = [PSSUserDefaultsTool getValueWithKey:kGesturePasswordKey];
                    if ([gesPW isEqualToString:@""] || gesPW == nil || [gesPW isKindOfClass:[NSNull class]]) {
                        // 删除密码成功
                        fingerCell.swi.on = NO;
                    } else {
                        // 设置密码成功
                        if ([[PSSUserDefaultsTool getValueWithKey:kFingerLockBool] boolValue]) {
                            fingerCell.swi.on = YES;
                        }
                    }
                } unsupport:^{
                    
                }];
                [weakCell refreshSwitch];
                [tableView reloadData];
            }];
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == self.titleArray.count) { // 修改手势密码
        LBAccountSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:kAccountSecurityCellId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBAccountSecurityCell class]) owner:nil options:nil] firstObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.img_sign.image = nil;
        cell.label_info.text = @"";
        cell.label_title.text = @"修改手势密码";
        cell.linePosition = LBLinePositionTop;
        cell.img_sign.image = [UIImage imageNamed:@"icon_wode_ass"];
        return cell;
    }else {
        LBAccountSecurityCell *cell = [tableView dequeueReusableCellWithIdentifier:kAccountSecurityCellId];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBAccountSecurityCell class]) owner:nil options:nil] firstObject];
        }
        if (self.titleArray.count - 1 < indexPath.row) {
            return cell;
        }
        cell.img_sign.image = [UIImage imageNamed:@"icon_wode_ass"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.linePosition = LBLinePositionBottom;
        cell.label_title.text = self.titleArray[indexPath.row];
        if (self.contentArray.count >= indexPath.row + 1) {
            cell.label_info.text = self.contentArray[indexPath.row];
        }
        
        
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.titleArray.count) { // 修改手势密码
        PSSLockVC *lockVC = [[PSSLockVC alloc] init];
        lockVC.lockStyle = PSSLockStyleReset;
        lockVC.navigationItem.title = @"修改手势密码";
        [lockVC presentViewControllerWithVC:self.navigationController];
        [lockVC setSuccessBlock:^{
            [tableView reloadData];
        }];
    } else if (indexPath.row == 2) { // 修改手机号
        LBXiuGaiShouJiHaoVC *viewC = [LBXiuGaiShouJiHaoVC new];
        [self.navigationController pushViewController:viewC animated:YES];
        [viewC setXiuGaiPhoneNumberBlock:^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [LBUserModel updateUserWithUserModel:^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [self setUIForUserModel];
                [self.tableView reloadData];
            }];
        }];
    } else if (indexPath.row == 3) { // 修改密码
        LBChangeLoginPasswordVC *viewC = [LBChangeLoginPasswordVC new];
        viewC.navigationItem.title = @"修改密码";
        [self.navigationController pushViewController:viewC animated:YES];
    } else if (indexPath.row == 0) { // 实名认证
        if (!self.userModel.isAutonym) {
            [self loadShiMingRenZheng];
        }
    } else if (indexPath.row == 1) { // 绑定银行卡
        [self bindingCard];
    }
}
// 绑定银行卡
- (void)bindingCard
{
    LBBankCardManagerVC *bankVC = [LBBankCardManagerVC new];
    bankVC.navigationItem.title = @"银行卡";
    [self.navigationController pushViewController:bankVC animated:YES];
}
// 实名认证
- (void)loadShiMingRenZheng
{
    LBWebViewController *webVC = [LBWebViewController new];
    webVC.webViewStyle = LBWebViewControllerStyleRenZheng;
    [self.navigationController pushViewController:webVC animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
