//
//  LBNoticeVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBNoticeVC.h"
#import "LBNoticeTVCell.h"
#import "LBGongGaoModel.h"

@interface LBNoticeVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *gonggaoArray;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) BOOL isHeaderRefresh;

@end

@implementation LBNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.page = 1;
    [self addTableViewInThisView];
    [self addRefresh];
    self.navigationItem.title = @"公告";
    
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self.tableView.mj_header beginRefreshing];
    }];
}

- (void)addRefresh
{
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self reloadData];
//    }];
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        self.isHeaderRefresh = YES;
//        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@"" forState:MJRefreshStateIdle];
        self.page = 1;
        [self reloadData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self reloadData];
//    }];
}

- (void)reloadData
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_searchAllNews];
    [HTTPTools POSTWithUrl:urlString parameter:@{@"page":@(self.page)} progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([dict[@"success"] boolValue]) {
            if (self.isHeaderRefresh) {
                [self.gonggaoArray removeAllObjects];
                self.isHeaderRefresh = NO;
            }
            NSArray *array = dict[@"rows"];
            if (array == nil || array.count == 0 || [array isKindOfClass:[NSNull class]]) {
//                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@"没有更多了" forState:MJRefreshStateIdle];
                return;
            }
            for (NSDictionary *dic in array) {
                LBGongGaoModel *model = [LBGongGaoModel mj_objectWithKeyValues:dic];
                [self.gonggaoArray addObject:model];
            }
            [self.tableView reloadData];
            self.page++;
        }
    } failure:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
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
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.gonggaoArray.count) {
        return self.gonggaoArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBNoticeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBNoticeTVCell class]) owner:nil options:nil] firstObject];
    }
    if (self.gonggaoArray.count - 1 < indexPath.row) {
        return cell;
    }
    cell.model = self.gonggaoArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBGongGaoModel *model = self.gonggaoArray[indexPath.row];
    NSString *urlString = [NSString stringWithFormat:@"%@notice/%d.html",URL_HOST, model.nId];
    LBWebViewController *gongGaoWeb = [LBWebViewController new];
    gongGaoWeb.webViewStyle = LBWebViewControllerStyleDefault;
    gongGaoWeb.urlString = urlString;
    gongGaoWeb.navcTitle = @"公告详情";
    [self.navigationController pushViewController:gongGaoWeb animated:YES];
}

- (NSMutableArray *)gonggaoArray
{
    if (_gonggaoArray == nil) {
        _gonggaoArray = [NSMutableArray new];
    }
    return _gonggaoArray;
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
