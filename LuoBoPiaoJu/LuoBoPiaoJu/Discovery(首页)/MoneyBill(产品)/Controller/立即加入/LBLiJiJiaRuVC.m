//
//  LBLiJiJiaRuVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  立即加入

#import "LBLiJiJiaRuVC.h"
#import "LBLiJiFirstView.h"
#import "LBLiJiThirdView.h"
#import "LBLiJiRulerView.h"
#import "LBTopUpViewController.h"
#import "LBUsableHongBaoView.h"
#import "LBUsableHBModel.h"
#import "LBUsableHongBaoCell.h"

#define kOneMoney 1
#define k100Money 100

#define kPingFangFont(a) [UIFont fontWithName:@"PingFangSC-Light" size:(a)]

@interface LBLiJiJiaRuVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *img_header;
@property (nonatomic, strong) UILabel *label_kegoujine; // 可购金额
@property (nonatomic, strong) UILabel *label_nianHuaShouYi;
@property (nonatomic, strong) UILabel *zhangHuYuE;
@property (nonatomic, strong) UILabel *zhangHuYuENum; // 账户余额数值
@property (nonatomic, strong) UILabel *nianHuaShouYeNum; // 年化收益百分比
@property (nonatomic, strong) UIView *view_firstWhite; // 账户充值下面的白条view
@property (nonatomic, strong) UIButton *btn_topUp;

@property (nonatomic, strong) UILabel *label_chanpinbiaoqian; // 产品标签
@property (nonatomic, strong) UILabel *label_chanpinshuoming; // 产品说明

@property (weak, nonatomic) IBOutlet UIButton *btn_queDing;
@property (nonatomic, strong) LBLiJiFirstView *firstView;
@property (nonatomic, strong) LBLiJiThirdView *thirdView;
@property (nonatomic, strong) LBLiJiRulerView *rulerView;

@property (nonatomic, assign) CGFloat tf_height;

@property (nonatomic, strong) LBUserModel *userModel;
@property (nonatomic, strong) LBOrderModel *orderModel;

@property (nonatomic, strong) NSArray *hongbaoArr;
@property (nonatomic, strong) LBUsableHongBaoView *hongBaoView;

@property (nonatomic, strong) UITapGestureRecognizer *endEditingGes;

@property (nonatomic, strong) UILabel *label_hongBaoMoney;
@property (nonatomic, strong) UILabel *label_hongBaoProceeds;
@property (nonatomic, strong) UILabel *label_add1;
@property (nonatomic, strong) UILabel *label_add2;


@end

@implementation LBLiJiJiaRuVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBUserModel updateUserWithUserModel:^{
        weakSelf.userModel = [LBUserModel getInPhone];
        weakSelf.zhangHuYuENum.text = [NSString stringWithFormat:@"%.2lf", weakSelf.userModel.enAbleMoney];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    [self setUpHongBaoData];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated]; // 100开始
    if (self.gcId == 0 || self.gcId == 13) { // 活期
    } else { // 非活期
        self.thirdView.tf_mairujine.placeholder = @"一元起投";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"立即加入";
    
    [self addBuKengView]; // 补坑啊
    
    self.userModel = [LBUserModel getInPhone];
    self.btn_topUp.layer.cornerRadius = 4;
    self.btn_queDing.layer.cornerRadius = 4;

    self.nianHuaShouYeNum.text = [NSString stringWithFormat:@"%.2lf%%", self.goodModel.proceeds];
    [self addRulerViewInThis];
    [self addKeyboardNotification];
    self.img_header.backgroundColor = kNavBarColor;
    self.img_header.image = [UIImage imageNamed:@"image_detailHeader"];
    self.btn_topUp.backgroundColor = kNavBarColor;
    self.btn_queDing.backgroundColor = kNavBarColor;
    [self layoutHeaderLabel];
    
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        __weak typeof(self) weakSelf = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [LBUserModel updateUserWithUserModel:^{
            weakSelf.userModel = [LBUserModel getInPhone];
            weakSelf.zhangHuYuENum.text = [NSString stringWithFormat:@"%.2lf", weakSelf.userModel.enAbleMoney];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        [self setUpHongBaoData];
    }];
}
- (void)endEditings
{
    [self.view endEditing:YES];
}
- (void)addHongBaoView
{
    [_hongBaoView removeFromSuperview];
    if (self.hongbaoArr.count == 0) {
        return;
    }
    if ([[PSSUserDefaultsTool getValueWithKey:kLiJiJiaRuFirst] boolValue]) {
        [LBFunctionRemindView showWithImageName:@"image_lijijiaru"];
        [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:NO] WithKey:kLiJiJiaRuFirst];
    }
    NSInteger row = (self.hongbaoArr.count - 1) / 3 + 1;
    CGFloat height = kDiv2(90 + kCellHeight * row);
    LBUsableHongBaoView *hongBaoView = [[LBUsableHongBaoView alloc] init];
    hongBaoView.dataArray = _hongbaoArr;
    hongBaoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:hongBaoView];
    [hongBaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_thirdView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(height);
    }];
    [_scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(hongBaoView.mas_bottom);
    }];
    _hongBaoView = hongBaoView;

    [hongBaoView setClickItem:^(NSInteger index, LBUsableHongBaoCell *cell) {
        LBUsableHBModel *model = self.hongbaoArr[index];
        model.usingBool = !model.usingBool;
        cell.imageV.image = model.usingBool ? [UIImage imageNamed:@"image_usableHongBao_sele"] : [UIImage imageNamed:@"image_usableHongBao_nor"];
        
        double money = [self.thirdView.tf_mairujine.text doubleValue];
        double benjin = [self getBenJinHBCount];
        double xianjin = [self getXianJinHBCount];
        double allTotal = money + xianjin + benjin;
        
        // 判断红包是否为0
        if (benjin + xianjin) {
            self.label_add1.text = @"+";
            self.label_hongBaoMoney.text = [NSString stringWithFormat:@"%d", (int)(benjin + xianjin)];
            self.label_add2.hidden = NO;
            self.label_hongBaoProceeds.hidden = NO;
        } else {
            self.label_add1.text = @"";
            self.label_hongBaoMoney.text = @"";
            self.label_add2.hidden = YES;
            self.label_hongBaoProceeds.hidden = YES;
        }
        NSString *moneyStr = nil;
        if (self.gcId == 0 || self.gcId == 13) { // 活期
            CGFloat money_30 = 1.0 * allTotal * pow(1 + self.goodModel.proceeds / 100 / 365, 30) - allTotal; // 总收益
            CGFloat money_hongbao = 1.0 * (benjin + xianjin) * (pow(1 + self.goodModel.proceeds / 100 / 365, 30) - 1); // 红包收益
            moneyStr = [NSString stringWithFormat:@"%.2lf", money_30 - money_hongbao];
            self.label_hongBaoProceeds.text = [NSString stringWithFormat:@"%.2lf", money_hongbao + xianjin];
        } else { // 非活期
            CGFloat all_pro = 1.0 * allTotal * [self.goodModel getInvestDayNum] * self.goodModel.proceeds / 100 / 365;
            CGFloat all_hongbao = 1.0 * (benjin + xianjin) * [self.goodModel getInvestDayNum] * self.goodModel.proceeds / 100 / 365;
            moneyStr = [NSString stringWithFormat:@"%.2lf", all_pro - all_hongbao];
            self.label_hongBaoProceeds.text = [NSString stringWithFormat:@"%.2lf", all_hongbao + xianjin];
        }
        self.firstView.label_yujishouyi.text = moneyStr;
    }];
}

- (void)setUpHongBaoData
{
    [LBHTTPObject POST_getHongBaosInBuyGcId:(NSInteger)self.goodModel.gcId Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if ([NSObject nullOrNilWithObjc:dict]) {
            return ;
        }
        NSArray *rows = dict[@"rows"];
        _hongbaoArr = [LBUsableHBModel mj_objectArrayWithKeyValuesArray:rows];
        [self addHongBaoView];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)addBuKengView
{
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
        make.bottom.mas_equalTo(self.view).offset(-68);
    }];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    scrollView.bounces = NO;
    scrollView.delegate = self;
    _scrollView = scrollView;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditings)];
    self.endEditingGes = tapGes;
    
    // 图
    UIImageView *imageV1 = [[UIImageView alloc] init];
    _img_header = imageV1;
    [scrollView addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scrollView).offset(0);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(185);
    }];
    // 6.18
    UILabel *label1 = [UILabel new];
    _nianHuaShouYeNum = label1;
    [scrollView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV1).offset(46);
        make.centerX.mas_equalTo(imageV1);
        make.height.mas_equalTo(26);
    }];
    [label1 setText:@"" textColor:[UIColor whiteColor] font:[UIFont fontWithName:@"PingFangSC-Light" size:26]];
    // 年华收益
    UILabel *label2 = [UILabel new];
    _label_nianHuaShouYi = label2;
    [_scrollView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(7);
        make.centerX.mas_equalTo(imageV1);
        make.height.mas_equalTo(11);
    }];
    [label2 setText:@"年化收益" textColor:[UIColor whiteColor] font:[UIFont fontWithName:@"PingFangSC-Light" size:11]];
    // 白条
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV1.mas_bottom);
        make.left.right.mas_equalTo(imageV1);
        make.height.mas_equalTo(50);
    }];
    // 账户余额 + 数值
    UILabel *label3 = [UILabel new];
    _zhangHuYuE = label3;
    [view1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view1).offset(15);
        make.centerY.mas_equalTo(view1);
    }];
    [label3 setText:@"账户余额" textColor:kDeepColor font:[UIFont fontWithName:@"PingFangSC-Light" size:15]];
    UILabel *label4 = [UILabel new];
    _zhangHuYuENum = label4;
    [view1 addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_zhangHuYuE.mas_right).offset(14);
        make.centerY.mas_equalTo(view1);
    }];
    [label4 setText:@"" textColor:kDeepColor font:[UIFont fontWithName:@"PingFangSC-Light" size:15]];
    // 充值
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor whiteColor] highColor:[UIColor whiteColor] fontSize:15 target:self action:@selector(clickTopUpBtn:)  forControlEvents:UIControlEventTouchUpInside title:@"充值"];
    button1.backgroundColor = kNavBarColor;
    _btn_topUp = button1;
    [view1 addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view1.mas_right).offset(-15);
        make.top.mas_equalTo(view1).offset(7);
        make.bottom.mas_equalTo(view1).offset(-7);
        make.width.mas_equalTo(77);
    }];
    // 可够金额
    UILabel *label5 = [UILabel new];
    _label_kegoujine = label5;
    [_scrollView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(view1.mas_bottom).offset(125);
    }];
    [label5 setText:@"" textColor:kDeepColor font:[UIFont fontWithName:@"PingFangSC-Light" size:15]];
    // 白条
    UIView *view2 = [UIView new];
    view2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    _view_firstWhite = view2;
    
}

- (void)layoutHeaderLabel
{
    if (self.gcId != 0 && self.gcId != 13) {
        self.label_chanpinbiaoqian.text = @"";
        self.label_chanpinshuoming.text = @"";
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.text = @"理财期限(天)";
        label_1.textColor = [UIColor whiteColor];
        label_1.font = [UIFont systemFontOfSize:11];
        [_scrollView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.label_nianHuaShouYi.mas_left).offset(-57);
            make.height.mas_equalTo(11);
            make.centerY.mas_equalTo(self.label_nianHuaShouYi);
        }];
        
        UILabel *label_2 = [[UILabel alloc] init];
        label_2.text = @"可购金额(元)";
        label_2.textColor = [UIColor whiteColor];
        label_2.font = [UIFont systemFontOfSize:11];
        [_scrollView addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.label_nianHuaShouYi.mas_right).offset(57);
            make.height.mas_equalTo(11);
            make.centerY.mas_equalTo(self.label_nianHuaShouYi);
        }];
        
        UILabel *label_1_num = [[UILabel alloc] init];
        label_1_num.text = @"";
        label_1_num.textColor = [UIColor whiteColor];
        label_1_num.font = [UIFont systemFontOfSize:18];
        [_scrollView addSubview:label_1_num];
        [label_1_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(18);
            make.bottom.mas_equalTo(label_1.mas_top).offset(-10);
            make.centerX.mas_equalTo(label_1);
        }];
        label_1_num.text = [NSString stringWithFormat:@"%d", (int)self.goodModel.investTime];
        
        UILabel *label_2_num = [[UILabel alloc] init];
        label_2_num.text = @"";
        label_2_num.textColor = [UIColor whiteColor];
        label_2_num.font = [UIFont systemFontOfSize:18];
        [_scrollView addSubview:label_2_num];
        [label_2_num mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(18);
            make.bottom.mas_equalTo(label_2.mas_top).offset(-10);
            make.centerX.mas_equalTo(label_2);
        }];
        label_2_num.text = [NSString stringWithFormat:@"%d", (int)self.goodModel.surplusMoney];
    } else {
        
        CGFloat distance = 47;
        if (kIPHONE_5s) {
            distance = 25;
        }
        self.label_chanpinbiaoqian.text = @"萝卜快赚";
        self.label_chanpinshuoming.text = @"零存零取";
        [self.label_chanpinbiaoqian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_scrollView).offset(100 - kJian64 / 2);
            make.left.mas_equalTo(_scrollView).offset(distance);
            make.height.mas_equalTo(18);
        }];

        [self.label_chanpinshuoming mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_scrollView).offset(100 - kJian64 / 2);
            make.right.mas_equalTo(self.view).offset(-distance);
            make.height.mas_equalTo(18);
        }];
    }
}

- (void)addRulerViewInThis
{
    __weak typeof(self) weakSelf = self;
    LBLiJiFirstView *firstView = [LBLiJiFirstView createNibView];
    [_scrollView addSubview:firstView];
    self.firstView = firstView;
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view_firstWhite.mas_bottom).offset(10);
        make.right.and.left.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    if (self.gcId != 0 && self.gcId != 13) { // 非活期
        firstView.label_yujishouyi_title.text = @"预计收益";
    }
    
    CGFloat hongbaoSize = 13;
    if (kIPHONE_5s) {
        hongbaoSize = 12;
    }
    UILabel *label_add1 = [UILabel new];
    label_add1.textColor = kNavBarColor;
    label_add1.font = [UIFont systemFontOfSize:hongbaoSize weight:UIFontWeightLight];
    [firstView addSubview:label_add1];
    [label_add1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(firstView.label_touzijine);
        make.left.mas_equalTo(firstView.label_touzijine.mas_right);
    }];
    self.label_add1 = label_add1;
    UILabel *label_add2 = [UILabel new];
    label_add2.textColor = kNavBarColor;
    label_add2.font = [UIFont systemFontOfSize:hongbaoSize weight:UIFontWeightLight];
    [firstView addSubview:label_add2];
    [label_add2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(firstView.label_yujishouyi);
        make.left.mas_equalTo(firstView.label_yujishouyi.mas_right);
    }];
    self.label_add2 = label_add2;
    
    self.label_hongBaoMoney = [UILabel new];
    self.label_hongBaoMoney.textColor = kNavBarColor;
    self.label_hongBaoMoney.font = [UIFont systemFontOfSize:hongbaoSize weight:UIFontWeightLight];
    [firstView addSubview:self.label_hongBaoMoney];
    [self.label_hongBaoMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(firstView.label_touzijine);
        make.left.mas_equalTo(label_add1.mas_right);
    }];
    
    UILabel *label_hongBaoPro = [UILabel new];
    label_hongBaoPro.textColor = kNavBarColor;
    label_hongBaoPro.font = [UIFont systemFontOfSize:hongbaoSize weight:UIFontWeightLight];
    [firstView addSubview:label_hongBaoPro];
    [label_hongBaoPro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(firstView.label_touzijine);
        make.left.mas_equalTo(label_add2.mas_right);
    }];
    self.label_hongBaoProceeds = label_hongBaoPro;
    label_add2.text = @"+";
    label_add2.hidden = YES;
    label_hongBaoPro.text = @"0";
    label_hongBaoPro.hidden = YES;
    
    
    //
    LBLiJiThirdView *thirdView = [LBLiJiThirdView createNibView];
    [_scrollView addSubview:thirdView];
    self.thirdView = thirdView;
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstView.mas_bottom).offset(92);
        make.right.and.left.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    thirdView.allMoney = self.goodModel.surplusMoney;
    
    LBLiJiRulerView *rulerView = [[LBLiJiRulerView alloc] init];
    [_scrollView addSubview:rulerView];
    self.rulerView = rulerView;
    [rulerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstView.mas_bottom).offset(0);
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(thirdView.mas_top).offset(0);
    }];
    rulerView.totalMoney = self.goodModel.surplusMoney;
    [rulerView setScrollingBlock:^(int money) {
        weakSelf.thirdView.tf_mairujine.text = [NSString stringWithFormat:@"%d", money];
        weakSelf.firstView.label_touzijine.text = [NSString stringWithFormat:@"%d", money];
        
//        double benjin = [self getBenJinHBCount];
//        double xianjin = [self getXianJinHBCount];
//        double allTotal = money + xianjin + benjin;
        
        NSString *moneyStr = nil;
        if (weakSelf.gcId == 0 || weakSelf.gcId == 13) { // 活期
            CGFloat money_30 = 1.0 * money * pow(1 + weakSelf.goodModel.proceeds / 100 / 365, 30) - money;
            moneyStr = [NSString stringWithFormat:@"%.2lf", money_30];
        } else { // 非活期
            moneyStr = [NSString stringWithFormat:@"%.2lf", 1.0 * money * [self.goodModel getInvestDayNum] * self.goodModel.proceeds / 100 / 365];
        }
        weakSelf.firstView.label_yujishouyi.text = moneyStr;
    }];
    
    // 购买金额变动的回调
    [thirdView setTextFieldBlock:^(NSString *numString) {
        
        weakSelf.firstView.label_touzijine.text = numString;
        [weakSelf.rulerView scrollToNumber:[numString intValue]];
        NSInteger money = [numString integerValue];
        NSString *moneyStr = nil;
        
//        double benjin = [self getBenJinHBCount];
//        double xianjin = [self getXianJinHBCount];
//        double allTotal = money + xianjin + benjin;
        
        if (weakSelf.gcId == 0 || weakSelf.gcId == 13) { // 活期
            CGFloat money_30 = 1.0 * money * pow(1 + weakSelf.goodModel.proceeds / 100 / 365, 30) - money;
            moneyStr = [NSString stringWithFormat:@"%.2lf", money_30];
        } else { // 非活期
            moneyStr = [NSString stringWithFormat:@"%.2lf", 1.0 * money * [self.goodModel getInvestDayNum] * self.goodModel.proceeds / 100 / 365];
        }
        weakSelf.firstView.label_yujishouyi.text = moneyStr;
    }];
    
    // 点击金额全选
    [thirdView setButtonBlock:^{
        
        NSInteger money = (NSInteger)self.goodModel.surplusMoney;
        if (money > _userModel.enAbleMoney) {
            money = (NSInteger)_userModel.enAbleMoney;
        }
        kLog(@"%ld", (long)money);
        weakSelf.thirdView.tf_mairujine.text = [NSString stringWithFormat:@"%ld", (long)money];
        [weakSelf.rulerView scrollToNumber:money];
        weakSelf.firstView.label_touzijine.text = [NSString stringWithFormat:@"%ld", (long)money];
        
        NSString *moneyStr = nil;
//        double benjin = [self getBenJinHBCount];
//        double xianjin = [self getXianJinHBCount];
//        double allTotal = money + xianjin + benjin;
        if (weakSelf.gcId == 0 || weakSelf.gcId == 13) { // 活期
            CGFloat money_30 = 1.0 * money * (pow(1 + weakSelf.goodModel.proceeds / 100 / 365, 30) - 1);
            moneyStr = [NSString stringWithFormat:@"%.2lf", money_30];
        } else { // 非活期
            moneyStr = [NSString stringWithFormat:@"%.2lf", 1.0 * money * [weakSelf.goodModel getInvestDayNum] * self.goodModel.proceeds / 100 / 365];
        }
        weakSelf.firstView.label_yujishouyi.text = moneyStr;
        
    }];
    
    [_scrollView bringSubviewToFront:self.label_kegoujine];

    NSString *attrStr = [NSString stringWithFormat:@"可购金额 %ld元", (long)rulerView.totalMoney];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:attrStr];
    [attri addAttribute:NSForegroundColorAttributeName value:kNavBarColor range:NSMakeRange(5, attri.length - 6)];
    _label_kegoujine.attributedText = attri;
}

- (double)getBenJinHBCount
{
    double total = 0.0;
    for (LBUsableHBModel *model in self.hongbaoArr) {
        if (model.usingBool && model.couponType == 1) {
            total += [model.couponMoney doubleValue];
        }
    }
    return total;
}
- (double)getXianJinHBCount
{
    double total = 0.0;
    for (LBUsableHBModel *model in self.hongbaoArr) {
        if (model.usingBool && model.couponType == 0) {
            total += [model.couponMoney doubleValue];
        }
    }
    return total;
}


// 点击确定 
- (IBAction)clickQueDingBtn:(id)sender {
    if ([NSObject nullOrNilWithObjc:[LBUserModel getInPhone]]) {
        [LBLoginViewController login];
        return;
    }
    [[LBYesOrNoAlert alertWithMessage:@"如未付款，此笔订单资金将会冻结，10分钟之后自动返还账户" sureBlock:^{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if (self.goodModel.gcId == 13 || self.goodModel.gcId == 0) { // 萝卜快赚 -- 本息
            NSDictionary *param = @{
                                    @"uId":@(self.userModel.userId),
                                    @"goodId":@(self.goodModel.goodId),
                                    @"money":@([self.firstView.label_touzijine.text integerValue]),
                                    @"token":self.userModel.token,
                                    @"couponIds":[self appendingHongBaoID],
                                    @"deviceType":@"ios"
                                    };
            [self setUpDataWithUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, url_goumaiFeibenxi] param:param];
        } else { // 
            NSDictionary *param = @{@"uId":@(self.userModel.userId),
                                    @"goodId":@(self.goodModel.goodId),
                                    @"money":@([self.firstView.label_touzijine.text integerValue]),
                                    @"token":self.userModel.token,
                                    @"couponIds":[self appendingHongBaoID],
                                    @"deviceType":@"ios"
                                    };
            [self setUpDataWithUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, url_goumaiFeibenxi] param:param];
        }
    }] show];
}

- (void)setUpDataWithUrl:(NSString *)url param:(NSDictionary *)param
{
    [HTTPTools POSTWithUrl:url parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dict[@"success"] boolValue]) {
            NSDictionary *dataDict = dict[@"rows"];
            self.orderModel = [LBOrderModel mj_objectWithKeyValues:dataDict];
            LBWebViewController *webVC = [LBWebViewController new];
            webVC.webViewStyle = LBWebViewControllerStyleZhifu;
            webVC.buyOrderId = [NSString stringWithFormat:@"%ld", (long)self.orderModel.buyOrderId];
            if (self.gcId == 13) {
                webVC.isGuaGuaLe = YES;
            }
            [self.navigationController pushViewController:webVC animated:YES];
        } else {
            LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:dict[@"message"]];
            [alert show];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (NSString *)appendingHongBaoID
{
    if (self.hongbaoArr.count) {
        NSString *appStr = @"";
        for (int i = 0; i < self.hongbaoArr.count; i++) {
            LBUsableHBModel *model = self.hongbaoArr[i];
            if (model.usingBool) {
                if (appStr.length == 0) {
                    appStr = [appStr stringByAppendingString:[NSString stringWithFormat:@"%ld", model.couponId]];
                } else {
                    appStr = [appStr stringByAppendingString:[NSString stringWithFormat:@",%ld", model.couponId]];
                }
            }
        }
        return appStr;
    } else {
        return @"";
    }
}

// 点击充值按钮
- (void)clickTopUpBtn:(UIButton *)sender {
    if ([NSObject nullOrNilWithObjc:[LBUserModel getInPhone]]) {
        [LBLoginViewController login];
        return;
    }
    if (!kUserModel.isAutonym) {
        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:@"您还没有实名认证"];
        [alert show];
    } else {
        LBTopUpViewController *topUp = [LBTopUpViewController new];
        topUp.buttonTitle = @"充值";
        topUp.title = @"充值";
        [self.navigationController pushViewController:topUp animated:YES];
    }
}

- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillAppear:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyboardFrame.size.height == 0) {
        return;
    }
    CGFloat keyHeight = keyboardFrame.size.height;
    CGFloat animaH = keyHeight - (kScreenHeight - self.tf_height) + 40;
    [UIView animateWithDuration:duration animations:^{
        self.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2 - animaH);
    }];
    [_scrollView addGestureRecognizer:self.endEditingGes];
}
- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2 + 32);
    }];
    [_scrollView removeGestureRecognizer:self.endEditingGes];
}

- (UILabel *)label_chanpinbiaoqian
{
    if (_label_chanpinbiaoqian == nil) {
        _label_chanpinbiaoqian = [[UILabel alloc] init];
        _label_chanpinbiaoqian.textColor = [UIColor whiteColor];
        _label_chanpinbiaoqian.font = [UIFont systemFontOfSize:18];
        [_scrollView addSubview:_label_chanpinbiaoqian];
    }
    return _label_chanpinbiaoqian;
}
- (UILabel *)label_chanpinshuoming
{
    if (_label_chanpinshuoming == nil) {
        _label_chanpinshuoming = [[UILabel alloc] init];
        _label_chanpinshuoming.textColor = [UIColor whiteColor];
        _label_chanpinshuoming.font = [UIFont systemFontOfSize:18];
        [_scrollView addSubview:_label_chanpinshuoming];
    }
    return _label_chanpinshuoming;
}

// 约束已经生效
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tf_height = self.thirdView.bottom + self.thirdView.tf_mairujine.top;
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
