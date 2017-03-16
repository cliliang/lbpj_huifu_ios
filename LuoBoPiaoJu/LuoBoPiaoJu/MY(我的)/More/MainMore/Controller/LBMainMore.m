//
//  LBMainMore.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMainMore.h"
#import "LBConnectUsVC.h"
#import "LBAboutUsVC.h"
#import "LBFeedBackVC.h"
#import "LBVersionInfoVC.h"
#import "LBRadishCoinVC.h"
#import "LBMainMoreCell.h"

@interface LBMainMore () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) LBUserModel *userModel;
@property (nonatomic, strong) UIButton *button;

@end

@implementation LBMainMore

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LBUserModel updateUserWithUserModel:^{
        self.userModel = [LBUserModel getInPhone];
        [self refreshUI];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userModel = [LBUserModel getInPhone];
    self.navigationItem.title = @"更多";
    self.titleArray = @[
                   @[@"联系我们", @"关于我们"],
                   @[@"给个好评", @"意见反馈", @"版本信息"]
                   ];
    if ([[PSSUserDefaultsTool getValueWithKey:@"isAppCheckingKey"] boolValue]) {
        self.titleArray = @[
                            @[@"联系我们", @"关于我们"],
                            @[@"赞", @"意见反馈", @"版本信息"]
                            ];
    }
    
    [self addTableViewInThisView];
    
    [self addQuitButton];
}

- (void)addQuitButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"安全退出" forState:UIControlStateNormal];
    button.layer.borderWidth = 0.5;
    [button setBackgroundColor:kBackgroundColor];
    button.layer.cornerRadius = 5;
    button.frame = CGRectMake(35, 300, kScreenWidth - 70, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    button.userInteractionEnabled = NO;
    self.button = button;
    [self refreshUI];
}
- (void)refreshUI
{
    UIColor *btnColor = [UIColor colorWithRGBString:@"929292"];
    LBUserModel *userModel = kUserModel;
    btnColor = userModel ? kNavBarColor : btnColor;
    self.button.userInteractionEnabled = userModel ? YES : NO;
    self.button.layer.borderColor = btnColor.CGColor;
    [self.button setTitleColor:btnColor forState:UIControlStateNormal];
}
- (void)clickQuitButton
{
    LBYesOrNoAlert *alert = [LBYesOrNoAlert alertWithMessage:@"是否退出当前账号" sureBlock:^{
        [LBUserModel deleteInPhone];
        [LBUserModel deleteGesPassword];
        [[LBVCManager shareVCManager] instanceMainRoot];
        [LBVCManager hideMessageView];
    }];
    [alert show];
}

// 添加collectionView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = kBackgroundColor;
    self.tableView = tableView;
    self.tableView.scrollEnabled = NO;
}

#pragma mark - tableView代理方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBMainMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBMainMoreCell class]) owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.label_title.text = self.titleArray[indexPath.section][indexPath.row];
    if ([self boolWithIndexPath:indexPath section:1 row:2]) {
        cell.label_banbenInfo.text = [self getVersionInfo];
    }
    if (indexPath.row == 0) {
        cell.topView.backgroundColor = kLineColor;
    }
    if ([self boolWithIndexPath:indexPath section:1 row:2]) {
        // 版本信息
        cell.imageV_ass.image = nil;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self boolWithIndexPath:indexPath section:0 row:0]) {
        LBConnectUsVC *connectVC = [[LBConnectUsVC alloc] init];
        [self.navigationController pushViewController:connectVC animated:YES];
    } else if ([self boolWithIndexPath:indexPath section:0 row:1]) {
        LBAboutUsVC *aboutVC = [LBAboutUsVC new];
        [self.navigationController pushViewController:aboutVC animated:YES];
    } else if ([self boolWithIndexPath:indexPath section:1 row:0]) {
        if ([[PSSUserDefaultsTool getValueWithKey:@"isAppCheckingKey"] boolValue]) {
            [[PSSToast shareToast] showMessage:@"您的满意使我们最大的鼓舞"];
            return;
        }
        NSString *str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1050564862"];
        NSURL *url = [NSURL URLWithString:str];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        } else {
            kLog(@"can not open");
        }
    } else if ([self boolWithIndexPath:indexPath section:1 row:1]) {
        if (self.userModel == nil || [self.userModel isKindOfClass:[NSNull class]]) {
//            [LBLoginViewController alertLogin];
            [LBLoginViewController login];
            return;
        }
        LBFeedBackVC *feedVC = [LBFeedBackVC new];
        [self.navigationController pushViewController:feedVC animated:YES];
    } else if ([self boolWithIndexPath:indexPath section:1 row:2]) {
//        LBVersionInfoVC *vc = [LBVersionInfoVC new];
//        [self.navigationController pushViewController:vc animated:YES];
    } else { //
//        LBRadishCoinVC *radishVC = [LBRadishCoinVC new];
//        [self.navigationController pushViewController:radishVC animated:YES];
//        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"尊敬的用户您好,由于版本升级需要,当前版本暂不支持萝卜币兑换,新版本敬请期待" message:@""];
//        [alert show];
    }
}

- (BOOL)boolWithIndexPath:(NSIndexPath *)indexPath section:(CGFloat)section row:(CGFloat)row
{
    if (indexPath.section == section && indexPath.row == row) {
        return YES;
    }
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}
- (NSString *)getVersionInfo
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
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
