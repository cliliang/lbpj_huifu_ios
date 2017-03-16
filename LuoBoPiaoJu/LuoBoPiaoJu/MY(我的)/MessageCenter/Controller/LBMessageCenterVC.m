//
//  LBMessageCenterVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMessageCenterVC.h"
#import "LBMessageCell.h"
#import "LBLoginViewController.h"
#import "LBWoDeTouZiVC.h"
#import "LBMainBenefitCenterVC.h"
#import "LBMainVIPVC.h"

#define kMessageCellId @"messageCenterCellId"

@interface LBMessageCenterVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *boolImageArray; // 控制图片样式
@property (nonatomic, assign) BOOL isHeaderRefresh;
@property (nonatomic, strong) LBUserModel *userModel;

@property (nonatomic, strong) UIView *view_noData;

@end

@implementation LBMessageCenterVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"消息中心";
    [self addBarButtonItem];
    [self addTableViewInThisView];
    self.userModel = [LBUserModel getInPhone];
    [self addHeaderAndFooterRefresh];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
// 添加上下拉刷新
- (void)addHeaderAndFooterRefresh
{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf updateMessages];
    }];
    self.tableView.mj_header = [MJGifHeader headerWithRefreshingBlock:^{
        weakSelf.isHeaderRefresh = YES;
        self.page = 1;
        [weakSelf updateMessages];
    }];
    if (self.userModel == nil || [self.userModel isKindOfClass:[NSNull class]]) {
        __weak typeof(self) weakSelf = self;
        LBYesOrNoAlert *alert = [LBYesOrNoAlert alertWithMessage:@"您还未登录, 请登录!" sureBlock:^{
            [LBLoginViewController login];
        }];
        [alert setNoButtonBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [alert show];
        return;
    }
    [self.tableView.mj_header beginRefreshing];
}

// 请求消息接口
- (void)updateMessages
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_messageCenter];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"page":@(self.page),
                            @"token":self.userModel.token
                            };
    __weak typeof(self) weakSelf = self;
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if (weakSelf.isHeaderRefresh) {
            [weakSelf.dataArray removeAllObjects];
            [weakSelf.boolImageArray removeAllObjects];
            weakSelf.isHeaderRefresh = NO;
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NSArray *array = dict[@"rows"];
        if (!([array isKindOfClass:[NSNull class]] || array == nil)) {
            if (array.count > 0) {
                weakSelf.page++;
            }
            for (NSDictionary *dataDict in array) {
                LBMessageModel *model = [LBMessageModel mj_objectWithKeyValues:dataDict];
                [weakSelf.dataArray addObject:model];
                NSNumber *boolNumber = [NSNumber numberWithBool:NO];
                [self.boolImageArray addObject:boolNumber];
            }
            if (self.dataArray.count == 0) {
                [self addNoDataView];
            } else {
                [self removeNoDataView];
            }
            [weakSelf.tableView reloadData];
            if (weakSelf.dataArray.count < 5) {
                self.tableView.mj_footer.alpha = 0;
            } else {
                self.tableView.mj_footer.alpha = 1;
            }
            [self clickRightBarButton];
        }
        
    } failure:nil];
}

- (void)addNoDataView
{
    UIView *view = [[UIView alloc] init];
    [self.tableView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView);
        make.left.mas_equalTo(self.tableView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight - 64);
    }];
    view.backgroundColor = kBackgroundColor;
    self.view_noData = view;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(div_2(426));
        make.centerX.mas_equalTo(view);
    }];
    imageV.image = [UIImage imageNamed:@"image_noMessage"];
    
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).offset(div_2(95.0));
        make.centerX.mas_equalTo(view);
    }];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = kLightColor;
    label.text = @"这还没有信息哦~";
}
- (void)removeNoDataView
{
    if (self.view_noData != nil) {
        [self.view_noData removeFromSuperview];
    }
}

- (void)addBarButtonItem
{
    UIBarButtonItem *barButton = [UIBarButtonItem barButtonItemWithTitle:@"" titleColor:[UIColor whiteColor] highColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5] target:self action:@selector(clickRightBarButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = barButton;
    
}
- (void)clickRightBarButton
{
    kLog(@"一键已读");
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_readAllMessage];
    NSDictionary *param = @{
                            @"uId":@(self.userModel.userId),
                            @"token":self.userModel.token
                            };
//    for (LBMessageModel *model in self.dataArray) {
//        model.seenType = YES;
//    }
//    [self.tableView reloadData];
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        kLog(@"%@", dict);
    } failure:nil];
}
// 添加collectionView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView = tableView;
    tableView.backgroundColor = kBackgroundColor;
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
    
    LBMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:kMessageCellId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBMessageCell class]) owner:nil options:nil] firstObject];
    }
    if (self.dataArray.count) {
        cell.imageType = [self.boolImageArray[indexPath.row] boolValue];
        cell.model = self.dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBMessageModel *model = self.dataArray[indexPath.row];
    if (!model.seenType) {
        // 设置本条消息已读
        [self readMessageWithIndex:model.messId row:indexPath.row];
        LBMessageModel *model = self.dataArray[indexPath.row];
        model.seenType = YES;
        [self.tableView reloadData];
    }
    BOOL boolValue = [self.boolImageArray[indexPath.row] boolValue];
    boolValue = !boolValue;
    self.boolImageArray[indexPath.row] = [NSNumber numberWithBool:boolValue];
    LBMessageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.imageType = boolValue;
    // 消息跳转类型（messType字段）： 1普通消息(前台点击不可跳转) 2用户投资 3会员特权礼遇 4红包到期
    if (model.messType == 2) { // 我的理财
        LBWoDeTouZiVC *myMoneyVC = [LBWoDeTouZiVC new];
        [self.navigationController pushViewController:myMoneyVC animated:YES];
    } else if (model.messType == 3) { // 会员特权
        LBMainVIPVC *vipVC = [LBMainVIPVC new];
        [self.navigationController pushViewController:vipVC animated:YES];
    } else if (model.messType == 4) { // 福利中心
        LBMainBenefitCenterVC *benefitVC = [LBMainBenefitCenterVC new];
        [self.navigationController pushViewController:benefitVC animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)readMessageWithIndex:(NSInteger)index row:(NSInteger)row
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_readMessage];
    NSDictionary *param = @{
                            @"userId":@(self.userModel.userId),
                            @"mId":@(index),
                            @"token":self.userModel.token,
                            };
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        
    } failure:nil];
}

#pragma mark -- 所有懒加载
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (NSMutableArray *)boolImageArray
{
    if (!_boolImageArray) {
        _boolImageArray = [NSMutableArray new];
    }
    return _boolImageArray;
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
