//
//  LBMoneyBillVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMoneyBillVC.h"
#import "LBXinShouKuaiZhuanCell.h"
#import "LBMoneyBillDetailVC.h"
#import "SDCycleScrollView.h"
#import "MJRefreshAutoFooter.h"

@interface LBMoneyBillVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageModelArr;

//@property (nonatomic, strong) SDCycleScrollView *cycleView;
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefresh;
@property (nonatomic, assign) int page;

@end

@implementation LBMoneyBillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.page = 1;
    [self addTableViewInThisView];
//    [self setUpDataImages];
    [self addRefresh];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self.tableView.mj_header beginRefreshing];
    }];
}
- (void)addRefresh
{
//    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self setUpData];
    }];
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        self.isHeaderRefresh = YES;
        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
        self.page = 1;
        [self setUpData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setUpData
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_product];
    NSDictionary *param = @{
                          @"gcId":@(self.gcId),
                          @"page":@(self.page),
                          };
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([dict[@"success"] boolValue]) {
            if (self.isHeaderRefresh) {
                [self.dataArray removeAllObjects];
                self.isHeaderRefresh = NO;
            }
            NSArray *row = dict[@"rows"];
            if (row == nil || [row isKindOfClass:[NSNull class]]) {
                return;
            }
            // 如果没有更多数据，footer置为空
            if (row.count == 0 || self.dataArray.count + 10 >= [dict[@"total"] intValue]) {
                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
            }
            for (NSDictionary *dataDict in row) {
                LBGoodsModel *model = [LBGoodsModel mj_objectWithKeyValues:dataDict];
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
//- (void)setUpDataImages
//{
//    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_HuoQuShouYeBanner];
//    NSDictionary *param = @{};
//    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
//        if ([dict[@"success"] boolValue]) {
//            [self.imageArray removeAllObjects];
//            for (NSDictionary *dictData in dict[@"rows"]) {
//                LBCycleModel *model = [LBCycleModel mj_objectWithKeyValues:dictData];
//                [self.imageModelArr addObject:model];
//                [self.imageArray addObject:[NSString stringWithFormat:@"%@%@", URL_HOSTImage, model.activityPic]];
//            }
//            [self.cycleView removeFromSuperview];
//            [self addCycleScrollView];
//        }
//    } failure:nil];
//}

// 添加tableView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0,  123 * kScreenWidth / 375 + 10)];
    tableView.backgroundColor = kBackgroundColor;
//    [self addCycleScrollView];
    
    self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 123 * kScreenWidth / 375)];
    [self.tableView addSubview:self.imageV];
    if (self.gcId == 5) { // 银票苗
        self.imageV.image = [UIImage imageNamed:@"image_yinPiaoMiao"];
    } else if (self.gcId == 11) { // 新手
        self.imageV.image = [UIImage imageNamed:@"image_xinShouQiangZhuan"];
    } else { // 萝卜定投
        self.imageV.image = [UIImage imageNamed:@"image_luoBoDingTou"];
    }
    
}
//// 添加轮播图
//- (void)addCycleScrollView
//{
//    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 240) imageURLStringsGroup:self.imageArray];
//    scrollView.backgroundColor = kNavBarColor;
//    [self.tableView addSubview:scrollView];
//    _cycleView = scrollView;
//    _cycleView.delegate = self;
//}
//- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
//{
//    if (self.imageModelArr.count == 0) {
//        return;
//    }
//    LBWebViewController *webVC = [LBWebViewController new];
//    webVC.urlString = ((LBCycleModel *)self.imageModelArr[index]).activityUrl;
//    [self.navigationController pushViewController:webVC animated:YES];
//}

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
    LBMoneyBillDetailVC *detailVC = [LBMoneyBillDetailVC new];
    detailVC.goodId = model.goodId;
    detailVC.gcId = self.gcId;
    if (self.gcId == 11) { // 这是新手列表
        detailVC.isNewHand = YES;
    }
    detailVC.navcTitle = model.goodName;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}
- (NSMutableArray *)imageModelArr
{
    if (_imageModelArr == nil) {
        _imageModelArr = [NSMutableArray new];
    }
    return _imageModelArr;
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
