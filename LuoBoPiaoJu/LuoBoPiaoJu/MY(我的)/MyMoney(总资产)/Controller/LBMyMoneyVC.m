//
//  LBMyMoneyVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyMoneyVC.h"
#import "LBCircleView.h"
#import "LBCirclePathView.h"
#import "LBMyMoneyCell.h"
#import "LBTopUpViewController.h"

#define kCell @"allMoneyCell"

@interface LBMyMoneyVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *view_twoLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_firstLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_zuoRiShouYiTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_leiJiShouYiTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_zongZiChanNum;
@property (weak, nonatomic) IBOutlet UIView *view_oneLine;
@property (weak, nonatomic) IBOutlet UILabel *label_zongzichanNum;
@property (weak, nonatomic) IBOutlet UIButton *btn_topUp;
@property (weak, nonatomic) IBOutlet UIButton *btn_tixian;

@property (weak, nonatomic) IBOutlet UILabel *label_zuorishouyiNum;
@property (weak, nonatomic) IBOutlet UILabel *label_leijishouyiNum;
@property (weak, nonatomic) IBOutlet UILabel *label_zuorishouyiTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_leijishouyiTitle;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LBCirclePathView *circleView;
@property (nonatomic, strong) LBUserModel *userModel;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *biliArray; // 比例数组
@property (nonatomic, strong) NSArray *moneyArray;

@property (nonatomic, strong) LBUserModel *moneyModel;

@property (nonatomic, assign) int refreshCount;

@property (nonatomic, strong) NSMutableArray *numArr;


@end

@implementation LBMyMoneyVC
- (void)viewWillAppear:(BOOL)animated
{
//    [super viewDidAppear:animated];
//    [self.view addSubview:self.circleView];
    [super viewWillAppear:YES];
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    self.refreshCount = 0;
    [LBUserModel updateUserWithUserModel:^{
        weakSelf.userModel = [LBUserModel getInPhone];
        weakSelf.label_zongzichanNum.text = [NSString stringWithFormat:@"%.2lf", self.userModel.countMoney];
        weakSelf.refreshCount++;
    }];
    
    [self setUPdata];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self setUPdata];
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.circleView removeFromSuperview];
    self.circleView = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userModel = [LBUserModel getInPhone];
    self.navigationItem.title = @"总资产";
    self.btn_topUp.layer.cornerRadius = 5;
    self.btn_topUp.backgroundColor = kNavBarColor;
    self.btn_tixian.layer.cornerRadius = 5;
    self.btn_tixian.layer.borderWidth = 1;
    self.btn_tixian.layer.borderColor = kNavBarColor.CGColor;
    
    self.view_oneLine.backgroundColor = kLineColor;
    self.view_twoLine.backgroundColor = kLineColor;
    
    if (kIPHONE_5s) {
        self.top_zongZiChanNum.constant = 140 - kJian64;
        self.top_firstLine.constant = 305 - kJian64;
        self.bottom_leiJiShouYiTitle.constant = 18;
        self.bottom_zuoRiShouYiTitle.constant = 18;
        [self.view setNeedsLayout];
    }
}
- (void)viewDidLayoutSubviews
{
    if (self.tableView != nil) {
        return;
    }
    [super viewDidLayoutSubviews];
    _titleArray = @[@"萝卜快赚", @"萝卜定投", @"新手抢赚", @"银票苗", @"体验金" ,@"可用余额"];
    UIColor *color_1 = [UIColor colorWithRGBString:@"fbc870"];
    UIColor *color_2 = [UIColor colorWithRGBString:@"aae9f4"];
    UIColor *color_3 = [UIColor colorWithRGBString:@"f9bca0"];
    UIColor *color_4 = [UIColor colorWithRGBString:@"59daa4"];
    UIColor *color_5 = [UIColor colorWithRGBString:@"ffe762"];
    UIColor *color_6 = [UIColor colorWithRGBString:@"fb765e" withAlpha:1];
    _colorArray = @[color_1, color_2, color_3, color_4, color_5, color_6];
    [self addTableViewInThisView];
}
- (void)setUPdata
{
    if (self.userModel == nil) {
        return;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_getAllMoney];
    NSDictionary *param = @{@"userId":@(self.userModel.userId), @"token":self.userModel.token};
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        self.refreshCount++;
        if ([NSObject nullOrNilWithObjc:dict]) {
            return ;
        }
        if ([dict[@"success"] boolValue]) {
            NSDictionary *dataDict = dict[@"rows"];
            LBUserModel *moneyModel = [LBUserModel mj_objectWithKeyValues:dataDict];
            self.moneyModel = moneyModel;
            self.label_zuorishouyiNum.text = [NSString stringWithFormat:@"%.2lf", moneyModel.yesterdayIncome];
            self.label_leijishouyiNum.text = [NSString stringWithFormat:@"%.2lf", moneyModel.sumProceeds];
            [self updateBiliMoney];
            [self updateMoneyArray];
            [self.view addSubview:self.circleView];
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        self.refreshCount++;
    }];
}
- (IBAction)clickChongZhi:(id)sender {
    // 点击充值
//    if (self.userModel.bankCard == nil || [self.userModel.bankCard isKindOfClass:[NSNull class]] || self.userModel.bankCard.length == 0) {
//        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:@"您还未绑定银行卡"];
//        [alert show];
//        return;
//    }
    if (self.userModel.isAutonym == 0) {
        LBWebViewController *webVC = [[LBWebViewController alloc] init];
        webVC.webViewStyle = LBWebViewControllerStyleRenZheng;
        [self.navigationController pushViewController:webVC animated:YES];
        return;
    }
//    if (self.userModel.bankCard == nil || [self.userModel.bankCard isKindOfClass:[NSNull class]]) {
//        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"您还没有绑定银行卡" message:@"请先绑定"];
//        [alert show];
//    } else {
        LBTopUpViewController *topUp = [LBTopUpViewController new];
        topUp.buttonTitle = @"充值";
        topUp.title = @"充值";
        [self.navigationController pushViewController:topUp animated:YES];
//    }
}
- (IBAction)chickTiXian:(id)sender {
    // 点击提现
//    if (self.userModel.bankCard == nil || [self.userModel.bankCard isKindOfClass:[NSNull class]] || self.userModel.bankCard.length == 0) {
//        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:@"您还未绑定银行卡"];
//        [alert show];
//        return;
//    }
    
//    if (self.userModel.bankCard == nil || [self.userModel.bankCard isKindOfClass:[NSNull class]]) {
//        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"您还没有绑定银行卡" message:@"请先绑定"];
//        [alert show];
//    } else {
//        LBTopUpViewController *topUp = [LBTopUpViewController new];
//        topUp.buttonTitle = @"提现";
//        topUp.title = @"提现";
//        [self.navigationController pushViewController:topUp animated:YES];
//    }
    
    if (self.userModel.isAutonym == 0) {
        LBWebViewController *webVC = [[LBWebViewController alloc] init];
        webVC.webViewStyle = LBWebViewControllerStyleRenZheng;
        [self.navigationController pushViewController:webVC animated:YES];
        return;
    }
    
    if (self.userModel != nil && (self.userModel.bankCard == nil || self.userModel.bankCard.length == 0 ||  [self.userModel.bankCard isKindOfClass:[NSNull class]]) ) {
        LBWebViewController *viewC = [LBWebViewController new];
        viewC.webViewStyle = LBWebViewControllerStyleBindingCard;
        viewC.navcTitle = @"绑定银行卡";
        viewC.title = @"绑定银行卡";
        [self.navigationController pushViewController:viewC animated:YES];
    } else {
        LBTopUpViewController *topUp = [LBTopUpViewController new];
        topUp.buttonTitle = @"提现";
        topUp.title = @"提现";
        [self.navigationController pushViewController:topUp animated:YES];
    }
    
}

// 添加collectionView
- (void)addTableViewInThisView
{
    CGFloat y_table = self.btn_topUp.bottom + 30;
    if (kIPHONE_5s) {
        y_table = self.btn_topUp.bottom + 20;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, y_table, kScreenWidth, kScreenHeight - self.btn_topUp.bottom - 30) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.scrollEnabled = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBMyMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBMyMoneyCell class]) owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.view_Color.backgroundColor = self.colorArray[indexPath.row];
    cell.label_title.text = self.titleArray[indexPath.row];
    if (self.biliArray != nil && self.biliArray.count != 0) {
        cell.label_retio.text = self.biliArray[indexPath.row];
        cell.label_money.text = self.moneyArray[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (kIPHONE_5s) {
        return 30;
    }
    return 35;
}

- (LBCirclePathView *)circleView
{
    if (_circleView == nil) {
        CGFloat y_circle = 120 - kJian64;
        CGFloat lineWidth = 35;
        if (kIPHONE_5s) {
            lineWidth = 30;
            y_circle = 100 - kJian64;
        }
//        LBCirclePathView *view = [[LBCirclePathView alloc] initWithFrame:CGRectMake((kScreenWidth - 120) / 2, y_circle, 120, 120) number1:self.moneyModel.lbkzMoneys color1:_colorArray[0] number2:self.moneyModel.lbdtMoneys color2:_colorArray[1] number3:self.moneyModel.xsbMoneys color3:_colorArray[2] number4:self.moneyModel.ypmMoneys color4:_colorArray[3] number5:self.userModel.enAbleMoney color5:_colorArray[4] width:0 time:1 lineWidth:lineWidth];
        LBCirclePathView *view = [[LBCirclePathView alloc] initWithFrame:CGRectMake((kScreenWidth - 120) / 2, y_circle, 120, 120) colorArray:_colorArray numberArr:self.numArr width:0 time:1 lineWidth:lineWidth];
        _circleView = view;
    }
    return _circleView;
}

- (void)updateBiliMoney
{
    if ([NSObject nullOrNilWithObjc:self.userModel]) {
        return;
    }
    float num_1 = (float)self.moneyModel.lbkzMoneys ? (float)self.moneyModel.lbkzMoneys * 100 / self.userModel.countMoney : 0;
    float num_2 = (float)self.moneyModel.lbdtMoneys ? (float)self.moneyModel.lbdtMoneys * 100 / self.userModel.countMoney : 0;
    float num_3 = (float)self.moneyModel.xsbMoneys ? (float)self.moneyModel.xsbMoneys * 100 / self.userModel.countMoney : 0;
    float num_4 = (float)self.moneyModel.ypmMoneys ? (float)self.moneyModel.ypmMoneys * 100 / self.userModel.countMoney : 0;
    float num_5 = (float)self.moneyModel.experienceIncome ? (float)self.moneyModel.experienceIncome * 100 / self.userModel.countMoney : 0;
    float num_6 = (float)self.userModel.enAbleMoney * 100 ? (float)self.userModel.enAbleMoney * 100 / self.userModel.countMoney : 0;
    
    NSString *str_1 = [NSString stringWithFormat:@"%.2lf%%", num_1];
    NSString *str_2 = [NSString stringWithFormat:@"%.2lf%%", num_2];
    NSString *str_3 = [NSString stringWithFormat:@"%.2lf%%", num_3];
    NSString *str_4 = [NSString stringWithFormat:@"%.2lf%%", num_4];
    NSString *str_5 = [NSString stringWithFormat:@"%.2lf%%", num_5];
    NSString *str_6 = [NSString stringWithFormat:@"%.2lf%%", num_6];
    
    _biliArray = @[str_1, str_2, str_3, str_4, str_5, str_6];
}

- (void)updateMoneyArray
{
    if ([NSObject nullOrNilWithObjc:self.userModel]) {
        return;
    }
    CGFloat num_1 = self.moneyModel.lbkzMoneys;
    CGFloat num_2 = self.moneyModel.lbdtMoneys;
    CGFloat num_3 = self.moneyModel.xsbMoneys;
    CGFloat num_4 = self.moneyModel.ypmMoneys;
    CGFloat num_5 = self.moneyModel.experienceIncome;
    CGFloat num_6 = self.userModel.enAbleMoney;
    [self.numArr removeAllObjects];
    [self.numArr addObject:[NSNumber numberWithFloat:num_1]];
    [self.numArr addObject:[NSNumber numberWithFloat:num_2]];
    [self.numArr addObject:[NSNumber numberWithFloat:num_3]];
    [self.numArr addObject:[NSNumber numberWithFloat:num_4]];
    [self.numArr addObject:[NSNumber numberWithFloat:num_5]];
    [self.numArr addObject:[NSNumber numberWithFloat:num_6]];
    
    NSString *str_1 = [NSString stringWithFormat:@"%.2lf", num_1];
    NSString *str_2 = [NSString stringWithFormat:@"%.2lf", num_2];
    NSString *str_3 = [NSString stringWithFormat:@"%.2lf", num_3];
    NSString *str_4 = [NSString stringWithFormat:@"%.2lf", num_4];
    NSString *str_5 = [NSString stringWithFormat:@"%.2lf", num_5];
    NSString *str_6 = [NSString stringWithFormat:@"%.2lf", num_6];

    _moneyArray = @[str_1, str_2, str_3, str_4, str_5, str_6];
}

- (void)setRefreshCount:(int)refreshCount
{
    _refreshCount = refreshCount;
    if (refreshCount >= 2) {
        refreshCount = 0;
        [MBProgressHUD hideHUDForView:kWindow animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)numArr
{
    if (_numArr == nil) {
        _numArr = [NSMutableArray array];
    }
    return _numArr;
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
