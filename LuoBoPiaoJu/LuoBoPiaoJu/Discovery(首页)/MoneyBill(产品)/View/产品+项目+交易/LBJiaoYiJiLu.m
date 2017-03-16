//
//  LBJiaoYiJiLu.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  交易记录

#import "LBJiaoYiJiLu.h"
#import "LBJiaoYiJiLuCell.h"
#import "LBJiaoYiJiLuHeaderCell.h"

@interface LBJiaoYiJiLu () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefresh;
@property (nonatomic, assign) int page;

@end

@implementation LBJiaoYiJiLu

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        _page = 1;
        [self addTableViewInThisView];
    }
    return self;
}

- (void)refreshHeader
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self setUpData];
    }];
//    self.tableView.mj_footer.automaticallyHidden = YES;
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        self.isHeaderRefresh = YES;
        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
        self.tableView.mj_footer.hidden = NO;
        [self.tableView.mj_footer resetNoMoreData];
//        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateNoMoreData];
        self.page = 1;
        [self setUpData];
    }];
    [self.tableView.mj_header beginRefreshing];
}

// 数据请求
- (void)setUpData
{
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_DanGeJiaoYiJiLu];
    NSDictionary *param = @{@"goodId":@(self.goodId), @"page":@(self.page)};
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([dict[@"success"] boolValue]) {
            if (self.isHeaderRefresh) {
                [self.dataArray removeAllObjects];
                self.isHeaderRefresh = NO;
            }
            NSArray *row = dict[@"rows"];
            if (row == nil || [row isKindOfClass:[NSNull class]] || row.count == 0) {
//                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@"没有更多数据了" forState:MJRefreshStateIdle];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.hidden = YES;
                return;
            }
            if (row.count < 10) {
//                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" 没有更多数据了" forState:MJRefreshStateIdle];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.hidden = YES;
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = YES;
    [self addSubview:tableView];
    self.tableView = tableView;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    tableView.backgroundColor = [UIColor whiteColor];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray) {
        return self.dataArray.count + 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        LBJiaoYiJiLuHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:kHeaderCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBJiaoYiJiLuHeaderCell class]) owner:nil options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        LBJiaoYiJiLuCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBJiaoYiJiLuCell class]) owner:nil options:nil] firstObject];
        }
        if (self.dataArray) {
            cell.model = self.dataArray[indexPath.row - 1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kHeaderCellHeight;
    } else {
        return kCellHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
