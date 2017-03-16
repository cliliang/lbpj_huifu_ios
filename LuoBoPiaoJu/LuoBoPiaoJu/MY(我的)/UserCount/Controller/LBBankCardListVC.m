//
//  LBBankCardListVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBBankCardListVC.h"
#import "LBBankCardTVCell.h"
#import "LBBankCardInfoModel.h"

#define kCell @"LBBankCardTVCell"

@interface LBBankCardListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefresh;

@end

@implementation LBBankCardListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addTableViewInThisView];
    self.page = 1;
    [self addRefresh];
}

- (void)addRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self setUpData];
    }];
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        self.isHeaderRefresh = YES;
        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
        self.page = 1;
        [self setUpData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

// 数据请求
- (void)setUpData
{
    //    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_AllBankCardList];
    NSDictionary *param = @{
                            @"page":@(self.page)
                            };
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([dict[@"success"] boolValue]) {
            if (self.isHeaderRefresh) {
                [self.dataArray removeAllObjects];
                self.isHeaderRefresh = NO;
            }
            NSArray *row = dict[@"rows"];
            if (row == nil || [row isKindOfClass:[NSNull class]]) {
                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
                return;
            }
            if (row.count == 0) {
                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@"没有更多数据了" forState:MJRefreshStateIdle];
            } else {
                for (NSDictionary *dataDict in row) {
                    LBBankCardInfoModel *model = [LBBankCardInfoModel mj_objectWithKeyValues:dataDict];
                    [self.dataArray addObject:model];
                }
                [self.tableView reloadData];
                self.page++;
            }
        }
    } failure:^(NSError * _Nonnull error) {
        //        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}


// 添加collectionView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBBankCardTVCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBBankCardTVCell class]) owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 39;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    kLog(@"点击LBBankCardTVCell");
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil || _dataArray.count == 0) {
        _dataArray = [NSMutableArray new];
        // 第一个是表头
        LBBankCardInfoModel *bankCardModel = [LBBankCardInfoModel new];
        bankCardModel.bankCardCode = @"银行";
        bankCardModel.danBiXianE = @"单笔限额";
        bankCardModel.dangRiXianE = @"当日限额";
        [_dataArray addObject:bankCardModel];
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
