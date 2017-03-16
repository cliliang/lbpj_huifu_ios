//
//  LBDiscoveryVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  所有列表页全部进入银票苗(复用银票苗)


#import "LBDiscoveryVC.h"
#import "LBLoginViewController.h"
#import "SDCycleScrollView.h"
#import "LBGongGaoView.h" // 公告条
#import "LBFourButtonView.h"
#import "LBXinShouKuaiZhuanCell.h"
#import "LBNoticeVC.h"
#import "LBMoneyBillVC.h"
#import "LBMoneyBillDetailVC.h"
#import "LBLuoBoKuaiZhuanVC.h"
#import "LBGongGaoModel.h"
#import "LBGongGaoCollectionView.h"
#import "LBInvitationVC.h"
#import "LBCalculatorVC.h"
#import "LBExperMoneyVC.h"
#import "LBKuaiZhuanProductVC.h"

#import "LBFaXianShangChengVC.h"
#import "LBMoneyBillVC.h"
#import "LBInvitationVC.h"
#import "LBMoneyBillDetailVC.h"
#import "LBExperMoneyVC.h"
#import "LBCalculatorVC.h"
#import "LBMainVIPVC.h"

#import "LBCheckForUpdateView.h"

#define kGonggaoBottom 10 // 公告和下面按钮距离

@interface LBDiscoveryVC () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageModelArr;
//@property (nonatomic, strong) LBGongGaoView *gongGaoView;
@property (nonatomic, strong) LBGongGaoCollectionView *gongGaoView;
@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property (nonatomic, strong) LBFourButtonView *fourButtonView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *gongGaoArray;

@property (nonatomic, assign) int MBProHide;

@end

@implementation LBDiscoveryVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [LBHTTPObject POST_isHaveNotReadingMess:^(NSDictionary *dict) {
        if (!dict) {
            return;
        }
        if ([dict[@"success"] boolValue]) {
            [LBVCManager showMessageView];
        } else {
            [LBVCManager hideMessageView];
        }
    }];
    
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self.tableView.mj_header beginRefreshing];
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"首页";
    self.MBProHide = 0;
    [self addTableViewInThisView];
    [self addHeaderRefresh];
    [self timeHeart];
}
- (void)timeHeart
{
    [[[LBTimeHeart shareTime] rac_valuesForKeyPath:@"timeRun" observer:self] subscribeNext:^(id x) {
        [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LBGoodsModel *model = obj;
            LBXinShouKuaiZhuanCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
            if (model.onLineTimeStamp > 0) {
                model.onLineTimeStamp--;
                if (cell) {
                    [cell stringWithTimeCount:model.onLineTimeStamp];
                }
                if (model.onLineTimeStamp == 0) {
                    [self.tableView.mj_header beginRefreshing];
                }
            }
        }];
    }];

}

- (void)dealloc
{
    [[LBTimeHeart shareTime] removeObserver:self forKeyPath:@"timeRun"];
}

- (void)addHeaderRefresh
{
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        [self setUpDataImages];
        [self setUpDataGongGao];
        [self setUpData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setUpData
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_shouYeProduct];
    NSDictionary *param = [NSDictionary dictionary];
    // 第15个
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        self.MBProHide++;
        if ([dict[@"success"] boolValue]) {
            [self.dataArray removeAllObjects];
            
            NSArray *arr1 = dict[@"rows"][@"onLineGoods"];
            NSArray *arr2 = dict[@"rows"][@"goodList"];
            NSArray *mArr1 = [LBGoodsModel mj_objectArrayWithKeyValuesArray:arr1];
            NSArray *mArr2 = [LBGoodsModel mj_objectArrayWithKeyValuesArray:arr2];
            [mArr1 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LBGoodsModel *model = obj;
                model.onLineTimeStamp += 5;
            }];
            NSMutableArray *dataArr = [NSMutableArray arrayWithArray:mArr1];
            [dataArr addObjectsFromArray:mArr2];
            self.dataArray = dataArr;
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        self.MBProHide++;
    }];
}
- (void)setUpDataImages
{
    [LBHTTPObject POST_cycleImageWithActivityType:0 Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        self.MBProHide++;
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.imageArray removeAllObjects];

        if ([dict[@"success"] boolValue]) {
            [self.imageModelArr removeAllObjects];
            for (NSDictionary *dictData in dict[@"rows"]) {
                LBCycleModel *model = [LBCycleModel mj_objectWithKeyValues:dictData];
                if (model) {
                    [self.imageModelArr addObject:model];
                    [self.imageArray addObject:[NSString stringWithFormat:@"%@%@", URL_HOSTImage, model.activityScrollPic]];
                }
            }
            [self.cycleView removeFromSuperview];
            [self addCycleScrollView];
        }
    } failure:^(NSError * _Nonnull error) {
        self.MBProHide++;
    }];
}

- (void)setUpDataGongGao
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_searchAllNews];
    NSDictionary *param = @{@"page":@(1)};
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        self.MBProHide++;
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.gongGaoArray removeAllObjects];
        if ([dict[@"success"] boolValue]) {
            NSArray *dataArr = dict[@"rows"];
            for (NSDictionary *dataDic in dataArr) {
                LBGongGaoModel *model = [LBGongGaoModel mj_objectWithKeyValues:dataDic];
                [self.gongGaoArray addObject:model];
            }
//            if (self.gongGaoArray.count) {
//                self.gongGaoView.titleLabel.text = ((LBGongGaoModel *)self.gongGaoArray[0]).newsTitle;
//            }
            self.gongGaoView.dataArray = self.gongGaoArray;
            [self.gongGaoView reloadGongGaoData];
        }
    } failure:^(NSError * _Nonnull error) {
        self.MBProHide++;
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)addCycleScrollView
{
    SDCycleScrollView *scrollView = nil;
    if (self.imageArray.count == 0) {
        scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 482 * kScreenWidth / 750) imagesGroup:@[[UIImage imageNamed:@"image_placeHolder"]]];
    } else {
        scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 482 * kScreenWidth / 750) imageURLStringsGroup:self.imageArray];
    }
    scrollView.autoScrollTimeInterval = 3;
    scrollView.placeholderImage = [UIImage imageNamed:@"image_placeHolder"];
    [self.tableView addSubview:scrollView];
    _cycleView = scrollView;
    _cycleView.delegate = self;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.imageModelArr.count == 0) {
        return;
    }
    if ([[PSSUserDefaultsTool getValueWithKey:isAppCheckingKey] boolValue]) {
        return;
    }
    NSString *urlString = ((LBCycleModel *)self.imageModelArr[index]).activityUrl;
    if (urlString == nil || urlString.length == 0 || [urlString isEqualToString:@"000"] || [urlString isKindOfClass:[NSNull class]]) {
        return;
    }
    LBCycleModel *model = (LBCycleModel *)self.imageModelArr[index];
    [self clickCycleImageWithUrlStr:urlString title:model.activityTitle];
}
- (void)clickCycleImageWithUrlStr:(NSString *)urlStr title:(NSString *)title
{
    if ([urlStr containsString:@"mobile1601"]) {
        LBTabbarController *tabbarVC = [LBVCManager shareVCManager].tabbarVC;
        if ([urlStr containsString:@"theme"]) { // 首页
            tabbarVC.selectedIndex = 0;
        } else if ([urlStr containsString:@"dingtou"]) { // 定投列表
            LBMoneyBillVC *viewC = [LBMoneyBillVC new];
            viewC.navigationItem.title = @"萝卜定投";
            viewC.gcId = 10;
            tabbarVC.selectedIndex = 0;
            [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"yinpiaomiao"]) { // 银票苗
            tabbarVC.selectedIndex = 0;
            LBMoneyBillVC *viewC = [LBMoneyBillVC new];
            viewC.gcId = 5;
            viewC.navigationItem.title = @"银票苗";
            [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"yaoqingyouli"]) { // 邀请有礼
            if (kUserModel == nil) {
                [LBLoginViewController login];
                return ;
            }
            tabbarVC.selectedIndex = 0;
            LBInvitationVC *viewC = [[LBInvitationVC alloc] init];
            [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
            viewC.title = @"邀请有礼";
        } else if ([urlStr containsString:@"kuaizhuan"]) { // 快赚
            tabbarVC.selectedIndex = 0;
            LBMoneyBillDetailVC *viewC = [LBMoneyBillDetailVC new];
            viewC.goodId = 0;
            viewC.gcId = 0;
            viewC.navigationItem.title = @"萝卜快赚";
            [tabbarVC.viewControllers.firstObject pushViewController:viewC animated:YES];
        } else if ([urlStr containsString:@"tiyanjin"]) { // 体验金
            tabbarVC.selectedIndex = 0;
            LBExperMoneyVC *experVC = [LBExperMoneyVC new];
            [tabbarVC.viewControllers.firstObject pushViewController:experVC animated:YES];
            experVC.navcTitle = @"体验金";
        } else if ([urlStr containsString:@"jisuanqi"]) { // 计算器
            tabbarVC.selectedIndex = 0;
            LBCalculatorVC *clauVC = [[LBCalculatorVC alloc] init];
            clauVC.navcTitle = @"计算器";
            [tabbarVC.viewControllers.firstObject pushViewController:clauVC animated:YES];
        } else if ([urlStr containsString:@"faxian"]) { // 发现
            tabbarVC.selectedIndex = 1;
        } else if ([urlStr containsString:@"jifenshangcheng"]) { // 积分商城
            NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, @"website/mall.html"]; // @"http://baluobo-zxtc.imwork.net:59617/website/mall.html"
            if (kUserModel != nil) {
                url = [NSString stringWithFormat:@"%@?userId=%ld", url, (long)kUserModel.userId];
            }
            [self pushWebVCWithUrl:url title:@"积分商城"];
        } else if ([urlStr containsString:@"huiyuantequan"]) { // 会员特权
            LBMainVIPVC *vipVC = [[LBMainVIPVC alloc] init];
            [tabbarVC.viewControllers.firstObject pushViewController:vipVC animated:YES];
        } else if ([urlStr containsString:@"bangzhuzhongxin"]) { // 帮助中心
            NSString *url = [NSString stringWithFormat:@"%@%@", URL_HOST, @"wenti.html"];
            [self pushWebVCWithUrl:url title:@"帮助中心"];
        } else if ([urlStr containsString:@"wode"]) { // 我的
            tabbarVC.selectedIndex = 2;
        }
    } else {
        LBWebViewController *webVC = [LBWebViewController new];
        webVC.urlString = urlStr;
        webVC.webViewStyle = LBWebViewControllerStyleDefault;
        webVC.navcTitle = title;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
- (void)pushWebVCWithUrl:(NSString *)url title:(NSString *)title
{
    LBFaXianShangChengVC *webV = [LBFaXianShangChengVC new];
    webV.urlString = url;
    [self.navigationController pushViewController:webV animated:YES];
    webV.navigationItem.title = title;
    webV.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"关闭" titleColor:[UIColor whiteColor] highColor:[UIColor whiteColor] target:webV.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addGongGao
{
    __weak typeof(self) weakSelf = self;
    _gongGaoView = [[LBGongGaoCollectionView alloc] initWithFrame:CGRectMake(0, _cycleView.bottom, kScreenWidth, 30)];
    [self.tableView addSubview:_gongGaoView];
    [_gongGaoView setButtonBlock:^{
        LBNoticeVC *noticeVC = [LBNoticeVC new];
        [weakSelf.navigationController pushViewController:noticeVC animated:YES];
    }];
    
}

- (void)addFourButtonViewInThisView
{
    // 适配
    if (kIPHONE_6P) {
        _fourButtonView = [[LBFourButtonView alloc] initWithFrame:CGRectMake(0, _gongGaoView.bottom + kGonggaoBottom, kScreenWidth, 210)];
    } else {
        _fourButtonView = [[LBFourButtonView alloc] initWithFrame:CGRectMake(0, _gongGaoView.bottom + kGonggaoBottom, kScreenWidth, 185)];
    }
    
    [self.tableView addSubview:_fourButtonView];
    __weak typeof(self) weakSelf = self;
    [_fourButtonView setSelectedBlock:^(NSInteger index) {
        switch (index) {
            case 0: { // 萝卜定投
                LBMoneyBillVC *viewC = [LBMoneyBillVC new];
                viewC.navigationItem.title = @"萝卜定投";
                viewC.gcId = 10;
                [weakSelf.navigationController pushViewController:viewC animated:YES];
                break;
            }
            case 1: { // 银票苗
                
                LBMoneyBillVC *viewC = [LBMoneyBillVC new];
                viewC.gcId = 5;
                viewC.navigationItem.title = @"银票苗";
                [weakSelf.navigationController pushViewController:viewC animated:YES];
                
                break;
            }
            case 2: { // 萝卜快赚
//                LBMoneyBillDetailVC *viewC = [LBMoneyBillDetailVC new];
//                viewC.goodId = 0;
//                viewC.gcId = 0;
//                viewC.navigationItem.title = @"萝卜快赚";
                LBViewController *viewC = [NSClassFromString(@"LBKuaiZhuanProductVC") new];
                viewC.navcTitle = @"萝卜快赚";
                [weakSelf.navigationController pushViewController:viewC animated:YES];
                break;
            }
            case 3: { // 邀请有礼
                if (kUserModel == nil) {
                    [LBLoginViewController login];
                    return ;
                }
                LBInvitationVC *viewC = [[LBInvitationVC alloc] init];
                [weakSelf.navigationController pushViewController:viewC animated:YES];
                viewC.title = @"邀请有礼";
                
                
                break;
            }
            case 4: { // 体验金
                LBExperMoneyVC *experVC = [LBExperMoneyVC new];
                [weakSelf.navigationController pushViewController:experVC animated:YES];
                experVC.navcTitle = @"体验金";
                break;
            }
            case 5: { // 计算器
                LBCalculatorVC *clauVC = [[LBCalculatorVC alloc] init];
                clauVC.navcTitle = @"计算器";
                [weakSelf.navigationController pushViewController:clauVC animated:YES];
                break;
            }
            default:
                break;
        }
    }];
}

// 添加tableView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44) style:UITableViewStylePlain];
    tableView.backgroundColor = kBackgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
//    tableView.bounces = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 482 * kScreenWidth / 750 + 25 + 200 + kGonggaoBottom)];
    if (kIPHONE_6P) {
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 482 * kScreenWidth / 750 + 25 + 220 + kGonggaoBottom + 4)];
    }
    [self addCycleScrollView];
    [self addGongGao];
    [self addFourButtonViewInThisView];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count != 0) {
        return self.dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBXinShouKuaiZhuanCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBXinShouKuaiZhuanCell class]) owner:nil options:nil] firstObject];
    }
    if (self.dataArray.count - 1 < indexPath.row) {
        return cell;
    }
    cell.goodModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell animationWithTime:0.6];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (kIPHONE_6P) {
        return kCellHeight_6P;
    }
    return kCellHright;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LBGoodsModel *model = self.dataArray[indexPath.row];
    LBViewController *productVC = [self vcWithClassString:kStringFormat(@"%d", model.gcId)];
    productVC.navcTitle = model.goodName;
    [productVC setValue:@(model.goodId) forKey:@"goodId"];
    [productVC setValue:@(model.gcId) forKey:@"gcId"];
    [self.navigationController pushViewController:productVC animated:YES];
}
- (LBViewController *)vcWithClassString:(NSString *)classStr
{
    NSDictionary *classDic = [self getClassStrDict];
    LBViewController *vc = [[NSClassFromString(classDic[classStr]) alloc] init];
    return vc;
}
- (NSDictionary *)getClassStrDict
{
    return @{
             @"13":@"LBKuaiZhuanProductVC", // 活期
             @"5":@"LBMoneyBillDetailVC", // 银票苗
             @"10":@"LBMoneyBillDetailVC" // 定期
             };
}
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray new];
//        [_imageArray addObject:[UIImage imageNamed:@"image_placeHolder"]];
    }
    return _imageArray;
}
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (NSMutableArray *)imageModelArr
{
    if (_imageModelArr == nil) {
        _imageModelArr = [NSMutableArray new];
    }
    return _imageModelArr;
}
- (NSMutableArray *)gongGaoArray
{
    if (_gongGaoArray == nil) {
        _gongGaoArray = [NSMutableArray new];
    }
    return _gongGaoArray;
}
- (void)setMBProHide:(int)MBProHide
{
    _MBProHide = MBProHide;
    if (MBProHide == 3) {
        [self.tableView.mj_header endRefreshing];
        _MBProHide = 0;
    }
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
