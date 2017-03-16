//
//  LBShuHuiVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  赎回

#import "LBShuHuiVC.h"
#import "LBShuHuiCell.h"
#import "LBShuHuiDetailVC.h"

@interface LBShuHuiVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LBUserModel *userModel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefresh;
@property (nonatomic, assign) int page;


@end

@implementation LBShuHuiVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self.tableView.mj_header beginRefreshing];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"赎回";
    self.userModel = [LBUserModel getInPhone];
    self.page = 1;
    [self addTableViewInThisView];
    [self addRefresh];
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
}
- (void)setUpData
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_keshuhuiList];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"token":self.userModel.token,
                            @"page":@(self.page)
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
                [self.tableView reloadData];
                return;
            }
            if (row.count == 0) {
                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
            }
            for (NSDictionary *dataDict in row) {
                LBOrderModel *model = [LBOrderModel mj_objectWithKeyValues:dataDict];
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];
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
    LBShuHuiCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBShuHuiCell class]) owner:nil options:nil] firstObject];
    }
    if (self.dataArray) {
        cell.model = self.dataArray[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBShuHuiDetailVC *shuHuiDetail = [LBShuHuiDetailVC new];
    shuHuiDetail.orderModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:shuHuiDetail animated:YES];
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
