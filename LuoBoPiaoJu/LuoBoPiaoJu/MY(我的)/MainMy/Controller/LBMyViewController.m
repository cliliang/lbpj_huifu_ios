//
//  LBMyViewController.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyViewController.h"
#import "LBMyHeaderView.h"
#import "LBMyTopUpCell.h"
#import "LBMyCell.h"
#import "LBTopUpViewController.h"
#import "LBUserAccountVC.h"
#import "LBMainMore.h"
#import "LBMessageCenterVC.h"
#import "LBLoginViewController.h"
#import "LBAccountSecurityVC.h"
#import "LBTradeRecordVC.h"
#import "LBMyMoneyVC.h"
#import "LBLuoBoKuaiZhuanVC.h"
#import "LBWoDeTouZiVC.h"
#import "LBMainBenefitCenterVC.h"
#import "LBMyFooterCell1.h"
#import "LBMyFooter2Cell.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize   [UIScreen mainScreen].bounds.size

#define kTopUpCellId @"myTopUpCellId"
#define kMyCellId @"myCellId"

@interface LBMyViewController () <UITableViewDelegate, UITableViewDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label_phoneNumber;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, strong) LBMyHeaderView *myHeaderView;

@property (nonatomic, strong) LBUserModel *userModel;

@property (nonatomic, assign) BOOL showMBProgress;

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, assign) BOOL isRedShow;
@property (nonatomic, assign) NSInteger redCount; // 未读消息条数

@property (nonatomic, strong) UITapGestureRecognizer *tapGes;

//@property (nonatomic, assign) BOOL havingLine;

@end

@implementation LBMyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.isShow = YES;
    if (!_showMBProgress) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _showMBProgress = YES;
    }
    [LBUserModel refreshUser:^(LBUserModel *userModel) {
        _userModel = userModel ? userModel : [LBUserModel getInPhone];
        [self updateAllMoney];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([[PSSUserDefaultsTool getValueWithKey:kWodeFirst] boolValue]) {
            [LBFunctionRemindView showWithImageName:@"image_wode"];
            [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:NO] WithKey:kWodeFirst];
        }
    }];
    
    
    [LBHTTPObject POST_isHaveNotReadingMess:^(NSDictionary *dict) {
        if (!dict) {
            return;
        }
        _redCount = [dict[@"total"] integerValue];
        _isRedShow = [dict[@"success"] boolValue];
        if ([dict[@"success"] boolValue]) {
            [LBVCManager showMessageView];
        } else {
            [LBVCManager hideMessageView];
        }
        [self.tableView reloadData];
    }];
    
    [[[LBTimeHeart shareTime] rac_valuesForKeyPath:@"networking" observer:self] subscribeNext:^(id x) {
        if (self.tapGes) {
            [self.view removeGestureRecognizer:self.tapGes];
        }
        if (![x boolValue]) {
            [self.view addGestureRecognizer:self.tapGes];
        }
    }];
}
- (void)tapMyView
{
    [[PSSToast shareToast] showMessage:@"网络不给力, 请检查网络设置"];
}
- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的";
    self.navigationItem.leftBarButtonItem = nil;
    _userModel = [LBUserModel getInPhone];
    
    
    _sectionArray = @[
                      @[@""],
                      @[@"萝卜快赚", @"我的理财", @"福利中心"],
                      @[@"交易记录", @"消息中心", @"账户信息"],
                      @[@"更多"]
                      ];
    // -图片数组
    _imagesArray = @[
                        @[
                            [UIImage imageNamed:@"icon_wode_00"] //
                          ],
                     
                        @[
                             [UIImage imageNamed:@"icon_wode_10"], //
                             [UIImage imageNamed:@"icon_wode_11"], //
                             [UIImage imageNamed:@"icon_wode_fulizhongxin"] //
                         ],
                        
                        @[
                            [UIImage imageNamed:@"icon_wode_jiaoyijilu"], //
                            [UIImage imageNamed:@"icon_wode_20"], //
                            [UIImage imageNamed:@"icon_wode_21"] //
                            
                          ],
                        @[
                            [UIImage imageNamed:@"icon_wode_22"] //
                        ]
                     ];
    
    [self addTableViewInThisView];
    [self addKeFu];
    
    
}
- (void)addKeFu
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_wode_zaixiankefu"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickOnline) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-KAutoWDiv2(78));
        make.bottom.mas_equalTo(self.view).offset(-KAutoHDiv2(165) + 44);
        make.width.mas_equalTo(KAutoWDiv2(86));
        make.height.mas_equalTo(KAutoWDiv2(112));
    }];
}
- (void)clickOnline 
{
    if ([LBTimeHeart shareTime].networking == NO) {
        [self netWorkingToast];
        return;
    }
    LBWebViewController *webVC = [[LBWebViewController alloc] init];
    webVC.webViewStyle = LBWebViewControllerStyleDefault;
    webVC.navcTitle = @"在线客服";
    webVC.urlString = @"http://www.sobot.com/chat/h5/index.html?sysNum=4a452db0d290432ba19f469a0c8b1f15&source=2";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)updateAllMoney
{
    NSString *tatalM = [NSString stringWithFormat:@"%.2lf", _userModel.countMoney];
    self.myHeaderView.label_totalMoney.text = tatalM;
    self.myHeaderView.label_allIncome.text = [NSString stringWithFormat:@"%.2lf", _userModel.sumProceeds];
    self.myHeaderView.label_yestodayIncome.text = [NSString stringWithFormat:@"%.2lf", _userModel.yesterdayIncome];
    [self.tableView reloadData];

}
- (void)setBarbuttonItem
{
    UIBarButtonItem *barButton = [UIBarButtonItem barButtonItemWithTitle:@"交易记录" titleColor:[[UIColor whiteColor] colorWithAlphaComponent:1] highColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] target:self action:@selector(rightButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = barButton;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_wode"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftButton)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}
- (void)leftButton
{
    if (!self.isShow) {
        return;
    }
    self.isShow = NO;
    // 账户
    if (self.userModel) {
        LBUserAccountVC *userAccountVC = [[LBUserAccountVC alloc] init];
        NSString *phoneN = [NSString stringWithFormat:@"%@****%@", [self.userModel.mobile substringToIndex:3], [self.userModel.mobile substringWithRange:NSMakeRange(7, 4)]];
        userAccountVC.phoneNumber = phoneN;
        
        userAccountVC.trueName = self.userModel.isAutonym ? YES : NO;
        userAccountVC.binding = self.userModel.idCard ? @"已绑定" : @"未绑定";
        [self.navigationController pushViewController:userAccountVC animated:YES];
    } else {
        [LBLoginViewController login];
    }
}
// 点击交易记录
- (void)rightButton
{
    if (self.userModel == nil) {
        [LBLoginViewController login];
        return;
    }
    LBTradeRecordVC *viewC = [LBTradeRecordVC new];
    [self.navigationController pushViewController:viewC animated:YES];
}
// 添加tableView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 108) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 154)];
    LBMyHeaderView *headerView = [LBMyHeaderView myHeaderViewWithFrame:CGRectMake(0, 0, kScreenWidth, 154)];
    [self.tableView addSubview:headerView];
    self.myHeaderView = headerView;
    tableView.bounces = NO;
    
    // header加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableHeaderView)];
    [headerView addGestureRecognizer:tapGesture];
    self.tableView.backgroundColor = kBackgroundColor;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 5)];
    
}
// 点击总资产
- (void)tapTableHeaderView
{
    if (![LBTimeHeart shareTime].networking) {
        [[PSSToast shareToast] showMessage:@"网络不给力, 请检查网络设置"];
        return;
    }
    if (self.userModel == nil) {
        [LBLoginViewController login];
        return;
    }
    LBMyMoneyVC *viewC = [[LBMyMoneyVC alloc] init];
    [self.navigationController pushViewController:viewC animated:YES];
}

#pragma mark - tableView代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LBMyTopUpCell *cell = [tableView dequeueReusableCellWithIdentifier:kTopUpCellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBMyTopUpCell class]) owner:nil options:nil] firstObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.imageV.image = self.imagesArray[indexPath.section][indexPath.row];
        cell.moneyString = [NSString stringWithFormat:@"可用余额:%.2lf元", _userModel.enAbleMoney];
        __weak typeof(self) weakSelf = self;
        [cell setTopUpBlock:^{
            if ([LBTimeHeart shareTime].networking == NO) {
                [self netWorkingToast];
                return;
            }
            if (weakSelf.userModel == nil) {
                [LBLoginViewController login];
            } else {
                if (self.userModel.isAutonym == 0) {
                    LBWebViewController *webVC = [[LBWebViewController alloc] init];
                    webVC.webViewStyle = LBWebViewControllerStyleRenZheng;
                    [weakSelf.navigationController pushViewController:webVC animated:YES];
                } else {
                    LBTopUpViewController *topUp = [LBTopUpViewController new];
                    topUp.buttonTitle = @"充值";
                    topUp.title = @"充值";
                    [weakSelf.navigationController pushViewController:topUp animated:YES];
                }
            }
        }];
        return cell;
    } else {
        LBMyCell *cell = [tableView dequeueReusableCellWithIdentifier:kMyCellId];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBMyCell class]) owner:nil options:nil] firstObject];
        }
            cell.imageV.image = self.imagesArray[indexPath.section][indexPath.row];
            cell.myTitleLabel.text = _sectionArray[indexPath.section][indexPath.row];
            cell.tintColor = [UIColor grayColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 0) {
            cell.topLine.backgroundColor = kLineColor;} else {
            cell.topLine.backgroundColor = [UIColor whiteColor];}
        
            if ([LBUserModel boolWithIndexPath:indexPath section:2 row:1]) {
            cell.messSignV.hidden = !_isRedShow;
            cell.redCount = _redCount;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowStr = self.sectionArray[indexPath.section][indexPath.row];
    BOOL b0 = self.userModel == nil;
    BOOL b1 = [self boolWithIndexPath:indexPath section:0 row:0];
    BOOL b2 = [rowStr isEqualToString:@"更多"];
    BOOL b3 = [rowStr isEqualToString:@"cell1"];
    BOOL b4 = [rowStr isEqualToString:@"cell2"];
    BOOL b5 = [rowStr isEqualToString:@"cell3"];
    if (b0 && !b1 && !b2 && !b3 && !b4 && !b5) {
        [LBLoginViewController login];
        return;
    }
    if ([rowStr isEqualToString:@"萝卜快赚"]) {
        LBLuoBoKuaiZhuanVC *viewC = [LBLuoBoKuaiZhuanVC new];
        [self.navigationController pushViewController:viewC animated:YES];
    } else if ([rowStr isEqualToString:@"我的理财"]) {
        LBWoDeTouZiVC *viewC = [LBWoDeTouZiVC new];
        [self.navigationController pushViewController:viewC animated:YES];
    } else if ([rowStr isEqualToString:@"交易记录"]) {
        [self rightButton];
    } else if ([rowStr isEqualToString:@"消息中心"]) {
        LBMessageCenterVC *messageVC = [LBMessageCenterVC new];
        [self.navigationController pushViewController:messageVC animated:YES];
    } else if ([rowStr isEqualToString:@"账户信息"]) {
        LBAccountSecurityVC *accountSecur = [LBAccountSecurityVC new];
        [self.navigationController pushViewController:accountSecur animated:YES];
    } else if ([rowStr isEqualToString:@"福利中心"]) {
        LBMainBenefitCenterVC *benefitVC = [LBMainBenefitCenterVC new];
        [self.navigationController pushViewController:benefitVC animated:YES];
    } else if ([rowStr isEqualToString:@"更多"]) {
        LBMainMore *moreVC = [[LBMainMore alloc] init];
        [self.navigationController pushViewController:moreVC animated:YES];
    } else if ([rowStr isEqualToString:@"cell1"]) {
    } else if ([rowStr isEqualToString:@"cell2"]) {
        if (![LBTimeHeart shareTime].networking) {
            [self netWorkingToast];
            return;
        }
        [self callPhoneNumber];
    } else if ([rowStr isEqualToString:@"cell3"]) {
        LBWebViewController *webVC = [[LBWebViewController alloc] init];
        webVC.webViewStyle = LBWebViewControllerStyleDefault;
        webVC.navcTitle = @"在线客服";
        webVC.urlString = @"http://www.sobot.com/chat/h5/index.html?sysNum=4a452db0d290432ba19f469a0c8b1f15&source=2";
        [self.navigationController pushViewController:webVC animated:YES];
        
    } else {
       
    }
    
}
- (void)netWorkingToast
{
    [[PSSToast shareToast] showMessage:@"网络不给力, 请检查网络设置"];
}
// 拨打电话
- (void)callPhoneNumber
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"客服电话" message:@"400-825-8626" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-825-8626"]];
    [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertC addAction:action_1];
    [alertC addAction:action_2];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (BOOL)boolWithIndexPath:(NSIndexPath *)indexPath section:(NSInteger)section row:(NSInteger)row
{
    if (indexPath.section == section && indexPath.row == row) {
        return YES;
    } else {
        return NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.sectionArray[section];
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (kIPHONE_6P) {
        return 56;
    } else {
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    } return 10;
}
- (UITapGestureRecognizer *)tapGes
{
    if (_tapGes == nil) {
        _tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMyView)];
    }
    return _tapGes;
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
