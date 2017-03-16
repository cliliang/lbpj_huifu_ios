//
//  LBMyMoneyTableView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyMoneyTableView.h"
#import "LBMyMoneyTVCell.h"
#import "LBJiaoYeDetailVC.h"

@interface LBMyMoneyTableView () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_countArray;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LBUserModel *userModel;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL isHeaderRefresh;


@property (nonatomic, strong) UIView *view_noData;

@end

@implementation LBMyMoneyTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTableViewInThisView];
        _page = 1;
        [self addRefresh];
        [self.tableView.mj_header beginRefreshing];
    }
    return self;
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
/**
 接口地址：mobile/buyOrder/queryPageForMyOrders
 接口描述：根据用户的userId分页查询固定投资状态的订单列表
 接口返回：返回类型为字典，其中rows为我们需要的订单对象数组
 */

- (void)reloadThisView
{
    _userModel = [LBUserModel getInPhone];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_searchThreeTypeOrder];
    NSDictionary *param = @{
                            @"userId":@(_userModel.userId),
                            @"page":@(_page),
                            @"buyflg":@(_buyflg),
                            @"token":_userModel.token
                            };
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        if ([dict[@"success"] boolValue]) {
            if (self.isHeaderRefresh) {
                [self.dataArray removeAllObjects];
                self.isHeaderRefresh = NO;
            }
            NSArray *row = [dict[@"rows"] objectForKey:@"buyOrders"];
            if (row == nil || [row isKindOfClass:[NSNull class]]) {
                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
                if (self.dataArray.count == 0 || self.dataArray == nil) {
                    [self addNoDataView];
                } else {
                    [self removeNoDataView];
                }
                return;
            }
            
            //
            if (row.count < 7) {
                [(MJRefreshAutoNormalFooter *)self.tableView.mj_footer setTitle:@" " forState:MJRefreshStateIdle];
            }
            
            for (NSDictionary *dataDict in row) {
                LBOrderModel *model = [LBOrderModel mj_objectWithKeyValues:dataDict];
                [self.dataArray addObject:model];
            }
            
            NSDictionary *experDic = [dict[@"rows"] objectForKey:@"experienceOrder"];
            if (![NSObject nullOrNilWithObjc:experDic] && _page == 1) {
                LBOrderModel *experModel = [LBOrderModel mj_objectWithKeyValues:experDic];
                [self.dataArray insertObject:experModel atIndex:0];
            }
            
            // -自适应cell高度
            NSMutableArray *mArr = [NSMutableArray new];
            [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                LBOrderModel *model = obj;
                int count = 0;
                if (model.cashMoney) {
                    count++;
                }
                if (model.principalMoney) {
                    count++;
                }
                [mArr addObject:@(count)];
            }];
            _countArray = mArr;
            
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    tableView.backgroundColor = kBackgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count) {
        return self.dataArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBMyMoneyTVCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBMyMoneyTVCell class]) owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray) {
        cell.model = self.dataArray[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBOrderModel *model = self.dataArray[indexPath.row];
    if (model.gcId == 0) {
        return;
    }
    LBJiaoYeDetailVC *viewC = [LBJiaoYeDetailVC new];
    // 根据订单的buyflg值进行订单状态判断：3：投资中；2：还款中；1:已还款
    if (_buyflg == 3) {
        viewC.statusString = @"投资中";
    } else if (_buyflg == 2) {
        viewC.statusString = @"还款中";
    } else if (_buyflg == 1) {
        viewC.statusString = @"已还款";
    }
    viewC.name = model.goodName;
    viewC.gouMaiJinE = [NSString stringWithFormat:@"%.2lf", model.countMoney];
    viewC.yuJiHuanKuan = [NSString stringWithFormat:@"%.2lf", model.countMoney + model.preProceeds]; // 没有用到这个属性， 用的是 本金 + 预计收益（活期为：计算出来的预计30天收益）
    viewC.nianHuaShouYi = [NSString stringWithFormat:@"%@%%", model.proceeds];
    viewC.huanKuanTime = model.buyEndTime;
    viewC.chengJiaoTime = model.createTime;
    viewC.orderModel = model;
    
    viewC.yuJiShouYi = [NSString stringWithFormat:@"%.2lf", model.preProceeds];
    if (model.gcId == 13) { // 活期
//        self.label_daiShouBenXi.text = @"预计30天收益";
        
        CGFloat moneys = model.principalMoney + model.countMoney;
        
        CGFloat resMoney = moneys * 1.0 * pow((1 + [model.proceeds floatValue] / 36500), 30) - moneys;
        viewC.yuJiShouYi = [NSString stringWithFormat:@"%.2lf", resMoney];
    }
    [self.VC.navigationController pushViewController:viewC animated:YES];
}

- (void)addNoDataView
{
    UIView *view = [[UIView alloc] init];
    [self.tableView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView);
        make.left.mas_equalTo(self.tableView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(self.height);
    }];
    view.backgroundColor = kBackgroundColor;
    self.view_noData = view;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(div_2(308));
        make.centerX.mas_equalTo(view);
    }];
    imageV.image = [UIImage imageNamed:@"image_noMoney"];
    
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).offset(div_2(95.0));
        make.centerX.mas_equalTo(view);
    }];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = kLightColor;
    if (_buyflg == 3) {
        label.text = @"您还没有记录哦, 快去投资吧~~";
    } else if (_buyflg == 2) {
        label.text = @"您没有还款中的产品";
    } else {
        label.text = @"您还没有已还款的产品";
    }
}
- (void)removeNoDataView
{
    if (self.view_noData != nil) {
        [self.view_noData removeFromSuperview];
    }
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
