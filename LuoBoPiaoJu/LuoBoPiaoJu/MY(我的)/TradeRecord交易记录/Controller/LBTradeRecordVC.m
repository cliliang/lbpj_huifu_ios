
//
//  LBTradeRecordVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBTradeRecordVC.h"
#import "LBTradeRecordCell.h"
#import "LBTradeRecordCell1.h"
#import "LBTradeRecordModel.h"

#define kCell @"LBTradeRecordCell"

@interface LBTradeRecordVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LBUserModel *userModel;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefresh;

@end

@implementation LBTradeRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"交易记录";
    self.userModel = [LBUserModel getInPhone];
    self.page = 1;
    [self addTableViewInThisView];
    [self addRefresh];
    
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self.tableView.mj_header beginRefreshing];
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        
    }];
}
- (void)addRefresh
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self setUpData];
    }];
    [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        self.isHeaderRefresh = YES;
        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@"下拉加载更多" forState:MJRefreshStateIdle];
        self.page = 1;
        [self setUpData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)setUpData
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_jiaoYiJiLu];
    NSDictionary *param = @{
                            @"token":self.userModel.token,
                            @"userId":@(self.userModel.userId),
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
            if (row.count < 10) {
                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
            }
            if (row.count == 0) {
                
            } else {
                for (NSDictionary *dataDict in row) {
                    LBTradeRecordModel *model = [LBTradeRecordModel mj_objectWithKeyValues:dataDict];
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
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray) {
        return self.dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    LBTradeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBTradeRecordCell class]) owner:nil options:nil] firstObject];
//    }
    LBTradeRecordCell1 *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (cell == nil) {
        cell = [[LBTradeRecordCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCell];
    }
    if (self.dataArray.count) {
        cell.model = self.dataArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 83;
    return 50; // 2.2.2
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
