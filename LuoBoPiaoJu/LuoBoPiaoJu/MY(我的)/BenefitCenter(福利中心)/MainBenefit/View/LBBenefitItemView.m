//
//  LBBenefitItemView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBBenefitItemView.h"
#import "LBBenefitCenterCell.h"
#import "LBBenefitModel.h"

@interface LBBenefitItemView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isHeaderRefresh;

@end

@implementation LBBenefitItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        [self addTableViewInThisView];
        _page = 1;
        [self addRefresh];
    }
    return self;
}
// 添加tableView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    tableView.backgroundColor = kBackgroundColor;
    _tableView = tableView;
}
- (void)reloadDate
{
    [_tableView reloadData];
}
- (void)startHeaderRefresh
{
    [self.tableView.mj_header beginRefreshing];
}
- (void)addRefresh
{
    //    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self reloadThisView];
    }];
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        self.isHeaderRefresh = YES;
        [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
        self.page = 1;
        [self reloadThisView];
    }];
}
- (void)reloadThisView
{
    [self isSearchingBenefit:^{
        [self updateBenefit];
    } recordBenefit:^{
        [self updateRecordBenefit];
    }];
}
- (void)isSearchingBenefit:(void(^)(void))benefit
             recordBenefit:(void(^)(void))recordBenefit
{
    if ([_url isEqualToString:url_searchBenefitBill]) {
        benefit();
    } else {
        recordBenefit();
    }
}
- (void)updateBenefit
{
    [LBHTTPObject POST_searchBenefitBill:url_searchBenefitBill page:_page pageSize:10 couponType:_type success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([dict[@"success"] boolValue]) {
            if (self.isHeaderRefresh) {
                [self.dataArray removeAllObjects];
                self.isHeaderRefresh = NO;
            }
            NSArray *rowArr = dict[@"rows"];
            for (NSDictionary *dataDic in rowArr) {
                LBBenefitModel *model = [LBBenefitModel mj_objectWithKeyValues:dataDic];
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
- (void)updateRecordBenefit
{
    [LBHTTPObject POST_searchBenefitBill:url_searchBenefitBillRecord page:_page pageSize:10 couponRecType:_type success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        kLog(@"%@", dict);
        if ([dict[@"success"] boolValue]) {
            if (self.isHeaderRefresh) {
                [self.dataArray removeAllObjects];
                self.isHeaderRefresh = NO;
            }
            
            NSArray *rowArr = dict[@"rows"];
            for (NSDictionary *dataDic in rowArr) {
                LBBebefitRecordModel *model = [LBBebefitRecordModel mj_objectWithKeyValues:dataDic];
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


#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = [NSString stringWithFormat:@"cell_%ld", self.type];
    LBBenefitCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LBBenefitCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self isSearchingBenefit:^{
        cell.benefitModel = self.dataArray[indexPath.row];
    } recordBenefit:^{
        cell.benefitRecModel = self.dataArray[indexPath.row];
    }];
    if (indexPath.row > 0) {
        LBBenefitModel *model2 = self.dataArray[indexPath.row];
        LBBenefitModel *model1 = self.dataArray[indexPath.row - 1];
        if (model1.state == 0 && model2.state) {
            cell.space = YES;
        } else {
            cell.space = NO;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        LBBenefitModel *model2 = self.dataArray[indexPath.row];
        LBBenefitModel *model1 = self.dataArray[indexPath.row - 1];
        if (model1.state == 0 && model2.state) {
            return div_2(260) + 15;
        }
    }
    return div_2(260);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
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
