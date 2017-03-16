//
//  LBFaXianMainVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFaXianMainVC.h"
#import "LBFaXianTVCell.h"
#import "LBSignInView.h"
#import "LBFaXianBannerView.h"
#import "LBFaXianFourView.h"
#import "LBFaXianNewsModel.h"

#import "LBFaXianShangChengVC.h"
#import "LBMoneyBillVC.h"
#import "LBInvitationVC.h"
#import "LBMoneyBillDetailVC.h"
#import "LBExperMoneyVC.h"
#import "LBCalculatorVC.h"
#import "LBMainVIPVC.h"
#import "LBSignEverydayVC.h"
#import "LBLuoBoToJiFenView.h"
#import "LBCheckForUpdateView.h"
#import <SDImageCache.h>


@interface LBFaXianMainVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LBSignInView *signView;
@property (nonatomic, strong) LBFaXianBannerView *bannerView;
@property (nonatomic, strong) LBFaXianFourView *fourView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefresh;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, assign) NSInteger luobobi;

@end

@implementation LBFaXianMainVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self reFreshUI];
    [self refreshJiFen];
    [LBHTTPObject POST_getLuoBoBiCount:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if (![NSObject nullOrNilWithObjc:dict] && ![NSObject nullOrNilWithObjc:dict[@"rows"]]) {
            self.luobobi = [dict[@"rows"] integerValue];
        }
    } failure:^(NSError * _Nonnull error) {
        self.luobobi = 0;
    }];
    
    
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self setUpCycleImage];
        [self.tableView.mj_header beginRefreshing];
    }];
}
- (void)refreshJiFen
{
    [LBUserModel updateUserWithUserModel:^{
        self.signView.label_jiFen.text = kUserModel.userScore ? [NSString stringWithFormat:@"%@积分", kUserModel.userScore] : @"0积分";
        [self reFreshUI];
    }];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        _isRefresh = YES;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发现";
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    [self addTableViewInThisView];
    [self addRefresh];
}
- (void)setUpCycleImage
{
    [LBHTTPObject POST_cycleImageWithActivityType:1 Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if (![NSObject nullOrNilWithObjc:dict]) {
            self.imgArray = [LBCycleModel mj_objectArrayWithKeyValuesArray:dict[@"rows"]];
            self.bannerView.modelArr = self.imgArray;
            [self.bannerView refreshCollectionV];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)addRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self uploadData];
    }];
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        self.isHeaderRefresh = YES;
        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
        self.page = 1;
        [self uploadData];
        [self setUpCycleImage];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)uploadData
{
    [LBHTTPObject POST_getFaXianListWithContentType:4 page:self.page pageSize:10 Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (![NSObject nullOrNilWithObjc:dict] && [dict[@"success"] boolValue]) {
            if (self.isHeaderRefresh) {
                [self.dataArray removeAllObjects];
                self.isHeaderRefresh = NO;
            }
            NSArray *rows = dict[@"rows"];
            for (NSDictionary *subDict in rows) {
                LBFaXianNewsModel *model = [LBFaXianNewsModel mj_objectWithKeyValues:subDict];
                model.description1 = subDict[@"description"];
                [self.dataArray addObject:model];
            }
            [self.tableView reloadData];
            self.page++;
        }
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
// 添加tableView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.backgroundColor = kBackgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, div_2(40 + 96 + 356 + 180 + 10 + 10))];
    [self addSomeViewInTableView];
}
// -刷新UI的方法
- (void)reFreshUI
{
    self.signView.signBtnTitle = @"每日签到";
    self.signView.label_jiFen.text = kUserModel.userScore ? [NSString stringWithFormat:@"%@积分", kUserModel.userScore] : @"0积分";
    NSArray *imgArr = @[@"vip_normal_icon_selected", @"vip_bronze_icon_selected", @"vip_silver_icon_selected", @"vip_gold_icon_selected", @"vip_diamond_icon_selected", @"vip_gold_diamond_icon_selected"];
    NSInteger count = [NSObject vipWithMoney:kUserModel.countMoney];
    if (count < 10) {
        _signView.myVipImgV.image = [UIImage imageNamed:imgArr[count]];
    } else {
        _signView.myVipImgV.image = [UIImage imageNamed:@"vip_normal_icon_normal"];
    }
}
- (void)clickCycleImageWithUrlStr:(NSString *)urlStr
{
    if ([urlStr containsString:@"mobile1601"]) {
        LBTabbarController *tabbarVC = [LBVCManager shareVCManager].tabbarVC;
        LBNavigationController *faxianNAVC = tabbarVC.viewControllers[1];
        if ([urlStr containsString:@"theme"]) {
            tabbarVC.selectedIndex = 0;
        } else if ([urlStr containsString:@"dingtou"]) {
            LBMoneyBillVC *viewC = [LBMoneyBillVC new];
            viewC.navigationItem.title = @"萝卜定投";
            viewC.gcId = 10;
            [faxianNAVC pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"dingtou"]) {
            LBMoneyBillVC *viewC = [LBMoneyBillVC new];
            viewC.gcId = 5;
            viewC.navigationItem.title = @"银票苗";
            [faxianNAVC pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"yaoqingyouli"]) {
            if (kUserModel == nil) {
                [LBLoginViewController login];
                return ;
            }
            LBInvitationVC *viewC = [[LBInvitationVC alloc] init];
            [faxianNAVC pushViewController:viewC animated:YES];
            viewC.title = @"邀请有礼";
        } else if ([urlStr containsString:@"kuaizhuan"]) {
            LBMoneyBillDetailVC *viewC = [LBMoneyBillDetailVC new];
            viewC.goodId = 0;
            viewC.gcId = 0;
            viewC.navigationItem.title = @"萝卜快赚";
            [faxianNAVC pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"tiyanjin"]) {
            LBExperMoneyVC *experVC = [LBExperMoneyVC new];
            [faxianNAVC pushViewController:experVC animated:YES];
            experVC.navcTitle = @"体验金";
        } else if ([urlStr containsString:@"jisuanqi"]) {
            LBCalculatorVC *clauVC = [[LBCalculatorVC alloc] init];
            clauVC.navcTitle = @"计算器";
            [faxianNAVC pushViewController:clauVC animated:YES];
        } else if ([urlStr containsString:@"faxian"]) {
            tabbarVC.selectedIndex = 1;
        } else if ([urlStr containsString:@"jifenshangcheng"]) {
            tabbarVC.selectedIndex = 1;
            NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, @"website/mall.html"]; // @"http://baluobo-zxtc.imwork.net:59617/website/mall.html"
            if (kUserModel != nil) {
                url = [NSString stringWithFormat:@"%@?userId=%ld", url, (long)kUserModel.userId];
            }
            [self pushWebVCWithUrl:url title:@"积分商城"];
        } else if ([urlStr containsString:@"huiyuantequan"]) {
            tabbarVC.selectedIndex = 1;
            LBMainVIPVC *vipVC = [[LBMainVIPVC alloc] init];
            [self.navigationController pushViewController:vipVC animated:YES];
        } else if ([urlStr containsString:@"bangzhuzhongxin"]) {
            tabbarVC.selectedIndex = 1;
            NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, @"wenti.html"];
            [self pushWebVCWithUrl:url title:@"帮助中心"];
        } else if ([urlStr containsString:@"wode"]) {
            tabbarVC.selectedIndex = 2;
        }
    } else {
        LBWebViewController *webVC = [LBWebViewController new];
        webVC.urlString = urlStr;
        webVC.webViewStyle = LBWebViewControllerStyleDefault;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
// 添加一些UI空间
- (void)addSomeViewInTableView
{
    LBSignInView *signView = [[LBSignInView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, div_2(96 + 40))];
    self.signView = signView;
    [self.tableView addSubview:signView];
    __weak typeof(self) weakSelf = self;
    [self.signView setClickBtnBlock:^(UIButton *button) {
        if (!kUserModel) {
            [LBLoginViewController login];
        } else {
            LBSignEverydayVC *signEveryVC = [[LBSignEverydayVC alloc] init];
            [weakSelf.navigationController pushViewController:signEveryVC animated:YES];
        }
    }];
    signView.clickBlock = ^{
        kLog(@"点击积分");
        if (self.luobobi >= 100) {
            NSInteger toJifen = self.luobobi / 100;
            [LBLuoBoToJiFenView luoBoBiToJiFen:kIntString(toJifen) luoBoBi:kIntString(self.luobobi) success:^{
                self.luobobi = 0;
                [self refreshJiFen];
            }];
        }
    };
    [self reFreshUI];
    
    // banner
    LBFaXianBannerView *bannerV = [[LBFaXianBannerView alloc] initWithFrame:CGRectMake(0, signView.bottom, kScreenWidth, div_2(356))];
    self.bannerView = bannerV;
    [self.tableView addSubview:bannerV];
    [bannerV setItemBlock:^(NSInteger index) {
        if (!self.imgArray) {
            return;
        }
        if ([[PSSUserDefaultsTool getValueWithKey:isAppCheckingKey] boolValue]) {
            return;
        }
        LBCycleModel *model = self.imgArray[index];
        [self clickCycleImageWithUrlStr:model.activityUrl];
    }];
    
    LBFaXianFourView *fourView = [[LBFaXianFourView alloc] initWithFrame:CGRectMake(0, bannerV.bottom, kScreenWidth, div_2(180))];
    self.fourView = fourView;
    [self.tableView addSubview:fourView];
    
    [fourView setClickBtnBlock:^(NSInteger index) {
        switch (index) {
            case 0:{
                if ([[PSSUserDefaultsTool getValueWithKey:isAppCheckingKey] boolValue]) {
                    [[PSSToast shareToast] showMessage:@"请到萝卜票据官网使用"];
                    break;
                }
                NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, @"website/mall.html"]; // @"http://baluobo-zxtc.imwork.net:59617/website/mall.html"
                if (kUserModel != nil) {
                    url = [NSString stringWithFormat:@"%@?userId=%ld", url, (long)kUserModel.userId];
                }
                [self pushWebVCWithUrl:url title:@"积分商城"];
                break;
            }
            case 1:{
                if ([[PSSUserDefaultsTool getValueWithKey:isAppCheckingKey] boolValue]) {
                    [[PSSToast shareToast] showMessage:@"请到萝卜票据官网查看 "];
                    break;
                }
                LBMainVIPVC *vipVC = [[LBMainVIPVC alloc] init];
                [self.navigationController pushViewController:vipVC animated:YES];
                break;
            }
            case 2:{
                if ([[PSSUserDefaultsTool getValueWithKey:isAppCheckingKey] boolValue]) {
                    [[PSSToast shareToast] showMessage:@"请到萝卜票据官网浏览  "];
                    break;
                }
                // @"http://baluobo-zxtc.imwork.net:59617/wenti.html"
                NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, @"wenti.html"];
                [self pushWebVCWithUrl:url title:@"帮助中心"];
                break;
            }
            default:
                break;
        }
    }];
    signView.backgroundColor = [UIColor whiteColor];
    fourView.backgroundColor = [UIColor yellowColor];
}
- (void)pushWebVCWithUrl:(NSString *)url title:(NSString *)title
{
    LBFaXianShangChengVC *webV = [LBFaXianShangChengVC new];
    webV.urlString = url;
    [self.navigationController pushViewController:webV animated:YES];
    webV.navigationItem.title = title;
//    webV.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"关闭" titleColor:[UIColor whiteColor] highColor:[UIColor whiteColor] target:webV.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBFaXianTVCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBFaXianTVCell class]) owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBFaXianNewsModel *model = self.dataArray[indexPath.row];
    LBWebViewController *webVC = [[LBWebViewController alloc] init];
    webVC.webViewStyle = LBWebViewControllerStyleDefault;
    NSString *urlString = [NSString stringWithFormat:@"%@story/%ld.html",URL_HOST, (long)model.nId];
    webVC.navcTitle = @"新闻详情";
    webVC.urlString = urlString;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
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
