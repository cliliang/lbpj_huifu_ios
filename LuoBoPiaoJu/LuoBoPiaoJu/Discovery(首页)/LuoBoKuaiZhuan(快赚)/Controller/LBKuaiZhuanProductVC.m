//
//  LBKuaiZhuanProductVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/12/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBKuaiZhuanProductVC.h"
#import "LBKuaiZhuanProgressView.h"

#define kBank (2.0 / 100)
#define kBaoBao (3.03 / 100)

@interface LBKuaiZhuanProductVC () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *BGView;
@property (nonatomic, strong) UIButton *goButton;

@property (nonatomic, strong) UIView *bgView1;
@property (nonatomic, strong) UIView *bgView2;
@property (nonatomic, strong) UIView *bgView3;
@property (nonatomic, strong) UIView *bgView4;

@property (nonatomic, strong) UILabel *yearLable;
@property (nonatomic, strong) UILabel *qitouLabel;

@property (nonatomic, strong) LBKuaiZhuanProgressView *progressView;
@property (nonatomic, strong) UILabel *availableLabel;

@property (nonatomic, strong) UILabel *totalMoneyLabel;
@property (nonatomic, strong) UILabel *totalPersonsLabel;

@property (nonatomic, strong) UITextField *moneyTextF;
@property (nonatomic, strong) UILabel *acountMoneyLabel;

@property (nonatomic, strong) UIView *view_bank;
@property (nonatomic, strong) UIView *view_luobo;
@property (nonatomic, strong) UIView *view_baobao;

@property (nonatomic, strong) UILabel *label_bank;
@property (nonatomic, strong) UILabel *label_luobo;
@property (nonatomic, strong) UILabel *label_baobao;

@property (nonatomic, strong) LBGoodsModel *goodsModel;
@property (nonatomic, strong) LBOrderModel *orderModel;

@property (nonatomic, weak) UIView *whiteView;

@end

@implementation LBKuaiZhuanProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBackgroundColor;
    self.BGView = [UIView new];
    [self.view addSubview:self.BGView];
    [self.BGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self addBgViews];
    [self addButtonAndSoOn];
    [self addViewsInBgView1];
    [self addViewsInBgView2];
    [self addViewsInBgView3];
    [self addViewsInBgView4];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpData];
    [LBUserModel updateUserWithUserModel:^{
        self.acountMoneyLabel.text = kStringFormat(@"%.2lf", kUserModel.enAbleMoney);
    }];
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
    CGFloat animaH = keyHeight - (self.view.height - self.goButton.bottom) + 20;
    CGFloat moveY = self.view.height - _moneyTextF.superview.bottom;
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 64 - animaH + moveY, self.view.width, self.view.height);
    }];
}
- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 64, self.view.width, self.view.height);
    }];
}
- (void)setUpData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBHTTPObject POST_huoQi_2_2_6:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (![NSObject nullOrNilWithObjc:dict] && ![NSObject nullOrNilWithObjc:dict[@"rows"]]) {
            LBGoodsModel *goodsModel = [LBGoodsModel mj_objectWithKeyValues:dict[@"rows"]];
            _goodsModel = goodsModel;
            [self refreshUI];
            [self.whiteView removeFromSuperview];
            self.whiteView = nil;
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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
            webVC.isGuaGuaLe = YES;
            
            [self.navigationController pushViewController:webVC animated:YES];
        } else {
            LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:dict[@"message"]];
            [alert show];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
// --
- (void)refreshUI
{
    _yearLable.text = [NSString stringWithFormat:@"%.2lf", _goodsModel.proceeds];
    _qitouLabel.text = [NSString stringWithFormat:@"%ld", _goodsModel.investUnit];
    double progress = (_goodsModel.buyMoney - _goodsModel.surplusMoney) / _goodsModel.buyMoney;
    self.progressView.progress = progress;
    self.availableLabel.text = [NSString stringWithFormat:@"可投金额: %ld", (NSInteger)_goodsModel.surplusMoney];
    self.totalMoneyLabel.text = [PSSTool wanWithNumber:_goodsModel.sumMoney];
    self.totalPersonsLabel.text = [NSString stringWithFormat:@"%ld", _goodsModel.buyUserCount];
    self.acountMoneyLabel.text = kStringFormat(@"%.2lf", kUserModel.enAbleMoney);
    [self changeViewHeightWithNum1:kBank num2:_goodsModel.proceeds / 100 num3:kBaoBao];
    
}
- (void)changeThreeNumberWithMoney:(double)money
{
    double bank = 1.0 * money * pow(1 + kBank / 365, 30) - money;
    double luobo = 1.0 * money * pow(1 + _goodsModel.proceeds / 100 / 365, 30) - money;
    double baobao = 1.0 * money * pow(1 + kBaoBao / 365, 30) - money;
    self.label_bank.text = kStringFormat(@"%.2lf", [PSSTool roundFloat:bank]);
    self.label_luobo.text = kStringFormat(@"%.2lf", [PSSTool roundFloat:luobo]);
    self.label_baobao.text = kStringFormat(@"%.2lf", [PSSTool roundFloat:baobao]);
}
- (void)addButtonAndSoOn
{
    // button
    UIButton *button = [UIButton buttonWithNormalColor:[UIColor whiteColor] highColor:[UIColor whiteColor] backgroundColor:kNavBarColor fontSize:[UIFont pingfangWithFloat:KAutoWDiv2(34) weight:UIFontWeightRegular] title:@"开始赚钱"];
    [button becomeCircleWithR:KAutoWDiv2(8)];
    [self.BGView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-KAutoHDiv2(30));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(KAutoHDiv2(610));
        make.height.mas_equalTo(KAutoHDiv2(80));
    }];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"开始赚钱");
        if ([NSObject nullOrNilWithObjc:[LBUserModel getInPhone]]) {
            [LBLoginViewController login];
            return;
        }
        if (_moneyTextF.text.length == 0) {
            [[PSSToast shareToast] showMessage:@"请输入购买金额"];
            return;
        }
        LBUserModel *userModel = kUserModel;
        [[LBYesOrNoAlert alertWithMessage:@"如未付款，此笔订单资金将会冻结，10分钟之后自动返还账户" sureBlock:^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            NSDictionary *param = @{
                                    @"uId":@(userModel.userId),
                                    @"goodId":@(_goodsModel.goodId),
                                    @"money":@([self.moneyTextF.text doubleValue]),
                                    @"token":userModel.token,
                                    @"couponIds":@"",
                                    @"deviceType":@"ios"
                                    };
            [self setUpDataWithUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, url_goumaiFeibenxi] param:param];
        }] show];
    }];
    self.goButton = button;
    
    // 2.回款方式
    UILabel *label = [UILabel mj_label];
    [label setText:@"汇款方式: 用户提现" textColor:[UIColor colorWithRGBString:@"999999"] font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [self.BGView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        double bottom = -22;
        if (kIPHONE_5s) {
            bottom = -12;
        }
        if (kIPHONE_6P) {
            bottom = -27;
        }
        make.bottom.mas_equalTo(button.mas_top).offset(KAutoHDiv2(bottom));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoHDiv2(22));
    }];
}
- (void)addBgViews
{
    // 1.四个背景View
    UIView *bgView1 = [[UIView alloc] init];
    bgView1.backgroundColor = [UIColor whiteColor];
    [self.BGView addSubview:bgView1];
    [bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoHDiv2(452));
    }];
    UIView *bgView2 = [[UIView alloc] init];
    bgView2.backgroundColor = [UIColor whiteColor];
    [self.BGView addSubview:bgView2];
    [bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView1.mas_bottom).offset(KAutoHDiv2(20));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoHDiv2(144));
    }];
    UIView *bgView3 = [[UIView alloc] init];
    bgView3.backgroundColor = [UIColor whiteColor];
    [self.BGView addSubview:bgView3];
    [bgView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView2.mas_bottom).offset(KAutoHDiv2(20));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoHDiv2(84));
    }];
    UIView *bgView4 = [[UIView alloc] init];
    bgView4.backgroundColor = [UIColor whiteColor];
    [self.BGView addSubview:bgView4];
    [bgView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView3.mas_bottom).offset(KAutoHDiv2(1));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoHDiv2(308));
    }];
    
    _bgView1 = bgView1;
    _bgView2 = bgView2;
    _bgView3 = bgView3;
    _bgView4 = bgView4;
}
- (void)addViewsInBgView1
{
    // 1. 4.18 + %
    UILabel *label1 = [UILabel new];
    [label1 setText:@"4.18" textColor:kNavBarColor font:kPingFangFont(KAutoHDiv2(74))];
    [_bgView1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(KAutoHDiv2(80));
        make.centerX.mas_equalTo(_bgView1).offset(-KAutoHDiv2(15));
        make.height.mas_equalTo(KAutoHDiv2(74));
    }];
    UILabel *label1_1 = [UILabel new];
    [label1_1 setText:@"%" textColor:kNavBarColor font:kPingFangFont(KAutoHDiv2(30))];
    [_bgView1 addSubview:label1_1];
    [label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(0);
        make.bottom.mas_equalTo(label1).offset(KAutoHDiv2(-2));
    }];
    _yearLable = label1;
    
    // 2. 年华收益
    UILabel *label2 = [UILabel new];
    [label2 setText:@"年化收益" textColor:[UIColor colorWithRGBString:@"333333"] font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(22));
        make.top.mas_equalTo(label1.mas_bottom).offset(KAutoHDiv2(15));
        make.centerX.mas_equalTo(_bgView1);
    }];
    
    
    // 3.当日起息 按日计息
    UILabel *label3 = [UILabel new];
    [label3 setText:@"当日起息 按日计息" textColor:[UIColor colorWithRGBString:@"333333"] font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label2);
        make.right.mas_equalTo(label1.mas_left).offset(-KAutoHDiv2(60));
        make.height.mas_equalTo(KAutoHDiv2(22));
    }];
    
    // 4.起投金额
    UILabel *label4 = [UILabel new];
    [label4 setText:@"起投金额" textColor:[UIColor colorWithRGBString:@"333333"] font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView1 addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label2);
        make.left.mas_equalTo(label1_1.mas_right).offset(KAutoHDiv2(89));
        make.height.mas_equalTo(KAutoHDiv2(22));
    }];
    
    // 5.随存随取
    UILabel *label5 = [UILabel new];
    [label5 setText:@"随存随取" textColor:[UIColor colorWithRGBString:@"ff6e54"] font:[UIFont pingfangWithFloat:KAutoHDiv2(32) weight:UIFontWeightLight]];
    [_bgView1 addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(label3);
        make.bottom.mas_equalTo(label1_1);
        make.height.mas_equalTo(KAutoHDiv2(32));
    }];
    
    // 6. 100
    UILabel *label6 = [UILabel new];
    [label6 setText:@"100" textColor:[UIColor colorWithRGBString:@"ff6e54"] font:[UIFont pingfangWithFloat:KAutoHDiv2(38) weight:UIFontWeightLight]];
    [_bgView1 addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(label4);
        make.bottom.mas_equalTo(label1_1).offset(KAutoHDiv2(5));
        make.height.mas_equalTo(KAutoHDiv2(38));
    }];
    _qitouLabel = label6;
    
    // 7. 添加progress
    LBKuaiZhuanProgressView *progressView = [[LBKuaiZhuanProgressView alloc] init];
    [_bgView1 addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).offset(KAutoHDiv2(86));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoHDiv2(20));
        make.width.mas_equalTo(KAutoHDiv2(660));
    }];
    _progressView = progressView;
    progressView.progress = 0.2;
    
    // 8. 可投金额
    UILabel *label8 = [UILabel new];
    [label8 setText:@"可投金额: 88888" textColor:UIColorFromHexString(@"666666", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightLight]];
    [_bgView1 addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(progressView.mas_bottom).offset(KAutoHDiv2(18));
        make.height.mas_equalTo(KAutoHDiv2(26));
    }];
    _availableLabel = label8;
    
    // 9.银行承兑汇票
    UILabel *label9 = [UILabel new];
    [label9 setText:@"银行承兑汇票" textColor:UIColorFromHexString(@"404040", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(28) weight:UIFontWeightLight]];
    [_bgView1 addSubview:label9];
    [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(_bgView1).offset(-KAutoHDiv2(28));
        make.height.mas_equalTo(KAutoHDiv2(28));
    }];
    
    [self whiteView];
}
- (void)addViewsInBgView2
{
    // 0. 竖线
    UIView *lineView = [UIView new];
    [_bgView2 addSubview:lineView];
    lineView.backgroundColor = kBackgroundColor;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_bgView2);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(KAutoHDiv2(94));
    }];
    // 1. 累计交易金额
    UIImageView *imageV_1 = [UIImageView new];
    [_bgView2 addSubview:imageV_1];
    imageV_1.image = [UIImage imageNamed:@"KuaiZhuanMoneyNumber"];
    [imageV_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgView2).offset(KAutoHDiv2(50));
        make.centerY.mas_equalTo(_bgView2);
        make.width.height.mas_equalTo(KAutoHDiv2(94));
    }];
    UILabel *label_1_a = [UILabel new]; // 文字
    [label_1_a setText:@"累计交易金额(元)" textColor:UIColorFromHexString(@"666666", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView2 addSubview:label_1_a];
    UILabel *label_1_b = [UILabel new]; // 数值
    [label_1_b setText:@"100000000" textColor:UIColorFromHexString(@"ff6e54", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(32) weight:UIFontWeightLight]];
    [_bgView2 addSubview:label_1_b];
    [label_1_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV_1.mas_right).offset(KAutoHDiv2(12));
        make.centerX.mas_equalTo(label_1_b);
        make.top.mas_equalTo(label_1_b.mas_bottom).offset(KAutoHDiv2(0));
        make.height.mas_equalTo(22);
    }];
    [label_1_b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV_1).offset(KAutoHDiv2(16));
        make.height.mas_equalTo(KAutoHDiv2(32));
    }];
    
    // 2. 累计购买人次
    UIImageView *imageV_2 = [UIImageView new];
    [_bgView2 addSubview:imageV_2];
    [imageV_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).offset(KAutoHDiv2(50));
        make.centerY.mas_equalTo(_bgView2);
        make.width.height.mas_equalTo(KAutoHDiv2(94));
    }];
    imageV_2.image = [UIImage imageNamed:@"KuaiZhuanPersonNumber"];
    UILabel *label_2_a = [UILabel new]; // 文字
    [label_2_a setText:@"累计购买人次" textColor:UIColorFromHexString(@"666666", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView2 addSubview:label_2_a];
    UILabel *label_2_b = [UILabel new]; // 数值
    [label_2_b setText:@"888" textColor:UIColorFromHexString(@"ff6e54", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(32) weight:UIFontWeightLight]];
    [_bgView2 addSubview:label_2_b];
    [label_2_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageV_2.mas_right).offset(KAutoHDiv2(31));
        make.centerX.mas_equalTo(label_2_b);
        make.top.mas_equalTo(label_2_b.mas_bottom).offset(KAutoHDiv2(0));
        make.height.mas_equalTo(22);
    }];
    [label_2_b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV_2).offset(KAutoHDiv2(16));
        make.height.mas_equalTo(KAutoHDiv2(32));
    }];
    
    _totalMoneyLabel = label_1_b;
    _totalPersonsLabel = label_2_b;
}
- (void)addViewsInBgView3
{
    // 1. 买入金额
    UILabel *label1 = [UILabel new];
    [label1 setText:@"买入金额" textColor:kDeepColor font:[UIFont pingfangWithFloat:KAutoHDiv2(28) weight:UIFontWeightLight]];
    [_bgView3 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgView3).offset(KAutoHDiv2(34));
        make.centerY.mas_equalTo(_bgView3);
    }];
    
    UITextField *textF = [[UITextField alloc] init];
    [_bgView3 addSubview:textF];
    textF.textColor = UIColorFromHexString(@"999999", 1);
    textF.font = [UIFont pingfangWithFloat:KAutoHDiv2(28) weight:UIFontWeightLight];
    [textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(KAutoHDiv2(24));
        make.centerY.mas_equalTo(_bgView3);
        make.width.mas_equalTo(kScreenWidth / 4);
    }];
    textF.placeholder = @"起投金额100元";
    textF.keyboardType = UIKeyboardTypeNumberPad;
    textF.delegate = self;
    [textF.rac_textSignal subscribeNext:^(id x) {
        if (kUserModel && [x doubleValue] > kUserModel.enAbleMoney) {
            textF.text = kStringFormat(@"%.2lf", [PSSTool roundFloat:kUserModel.enAbleMoney]);
            return;
        }
        [self changeThreeNumberWithMoney:[x doubleValue]];
    }];
    
    
    // 2. 账户余额
    UILabel *label2 = [UILabel new];
    [label2 setText:@"账户余额" textColor:kDeepColor font:[UIFont pingfangWithFloat:KAutoHDiv2(28) weight:UIFontWeightLight]];
    [_bgView3 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgView3).offset(KAutoHDiv2(472));
        make.centerY.mas_equalTo(_bgView3);
    }];
    
    UILabel *label2_num = [UILabel new];
    [label2_num setText:@"66666" textColor:kNavBarColor font:[UIFont pingfangWithFloat:KAutoHDiv2(28) weight:UIFontWeightLight]];
    [_bgView3 addSubview:label2_num];
    [label2_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label2.mas_right).offset(KAutoHDiv2(26));
        make.centerY.mas_equalTo(_bgView3);
    }];
    _moneyTextF = textF;
    _acountMoneyLabel = label2_num;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length > 1) {
        return NO;
    }
    if (string.length == 1 && ![string isSingleNumber]) {
        return NO;
    }
    if ([string isEqualToString:@"."] && [textField.text containsString:@"."]) {
        return NO;
    }
    if (!textField.text.length && [string isEqualToString:@"."]) {
        textField.text = @"0.";
        return NO;
    }
    if (string.length >= 1 && [textField.text containsString:@"."] && [[textField.text componentsSeparatedByString:@"."] lastObject].length >= 2) {
        return NO;
    }
    return YES;
}
- (void)addViewsInBgView4
{
    // 1. 预计30天收益(元)
    UILabel *label1 = [UILabel new];
    [label1 setText:@"预计30天收益(元)" textColor:UIColorFromHexString(@"999999", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView4 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_bgView4).offset(KAutoHDiv2(528));
        make.top.mas_equalTo(_bgView4).offset(KAutoHDiv2(15));
        make.height.mas_equalTo(KAutoHDiv2(22));
    }];
    // 2. 银行同期, 萝卜票据, 宝宝类
    UILabel *label_luobo = [UILabel new];
    [label_luobo setText:@"萝卜票据" textColor:UIColorFromHexString(@"333333", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightLight]];
    [_bgView4 addSubview:label_luobo];
    [label_luobo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(26));
        make.bottom.mas_equalTo(_bgView4).offset(-KAutoHDiv2(26));
        make.centerX.mas_equalTo(_bgView4);
    }];
    UILabel *label_yinhang = [UILabel new];
    [label_yinhang setText:@"银行同期" textColor:UIColorFromHexString(@"333333", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightLight]];
    [_bgView4 addSubview:label_yinhang];
    [label_yinhang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(26));
        make.right.mas_equalTo(label_luobo.mas_left).offset(-KAutoHDiv2(55));
        make.centerY.mas_equalTo(label_luobo);
    }];
    UILabel *label_baobao = [UILabel new];
    [label_baobao setText:@"宝宝类" textColor:UIColorFromHexString(@"333333", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightLight]];
    [_bgView4 addSubview:label_baobao];
    [label_baobao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(26));
        make.left.mas_equalTo(label_luobo.mas_right).offset(KAutoHDiv2(65));
        make.centerY.mas_equalTo(label_luobo);
    }];
    
    // 3. 色块 + 上部文字
    // 银行
    UIView *view_yinhang = [UIView new];
    view_yinhang.backgroundColor = UIColorFromHexString(@"b6f0fa", 1);
    [_bgView4 addSubview:view_yinhang];
    [view_yinhang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(label_yinhang.mas_top).offset(-KAutoHDiv2(17));
        make.centerX.mas_equalTo(label_yinhang);
        make.width.mas_equalTo(KAutoHDiv2(38));
        make.height.mas_equalTo(0);
    }];
    UILabel *label_yinhangN = [UILabel new];
    [label_yinhangN setText:@"" textColor:UIColorFromHexString(@"666666", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView4 addSubview:label_yinhangN];
    [label_yinhangN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(22));
        make.bottom.mas_equalTo(view_yinhang.mas_top).offset(-KAutoHDiv2(7));
        make.centerX.mas_equalTo(view_yinhang);
    }];
    // 萝卜
    UIView *view_luobo = [UIView new];
    view_luobo.backgroundColor = UIColorFromHexString(@"ffc562", 1);
    [_bgView4 addSubview:view_luobo];
    [view_luobo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(label_luobo.mas_top).offset(-KAutoHDiv2(17));
        make.centerX.mas_equalTo(label_luobo);
        make.width.mas_equalTo(KAutoHDiv2(38));
        make.height.mas_equalTo(KAutoHDiv2(0));
    }];
    UILabel *label_luoboN = [UILabel new];
    [label_luoboN setText:@"" textColor:UIColorFromHexString(@"666666", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView4 addSubview:label_luoboN];
    [label_luoboN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(22));
        make.bottom.mas_equalTo(view_luobo.mas_top).offset(-KAutoHDiv2(7));
        make.centerX.mas_equalTo(view_luobo);
    }];
    // 宝宝
    UIView *view_baobao = [UIView new];
    view_baobao.backgroundColor = UIColorFromHexString(@"ffbea1", 1);
    [_bgView4 addSubview:view_baobao];
    [view_baobao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(label_baobao.mas_top).offset(-KAutoHDiv2(17));
        make.centerX.mas_equalTo(label_baobao);
        make.width.mas_equalTo(KAutoHDiv2(38));
        make.height.mas_equalTo(0);
    }];
    UILabel *label_baobaoN = [UILabel new];
    [label_baobaoN setText:@"" textColor:UIColorFromHexString(@"666666", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(22) weight:UIFontWeightLight]];
    [_bgView4 addSubview:label_baobaoN];
    [label_baobaoN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KAutoHDiv2(22));
        make.bottom.mas_equalTo(view_baobao.mas_top).offset(-KAutoHDiv2(7));
        make.centerX.mas_equalTo(view_baobao);
    }];
    
    _view_bank = view_yinhang;
    _view_luobo = view_luobo;
    _view_baobao = view_baobao;
    
    _label_bank = label_yinhangN;
    _label_luobo = label_luoboN;
    _label_baobao = label_baobaoN;
}

- (void)changeViewHeightWithNum1:(double)num1
                            num2:(double)num2
                            num3:(double)num3
{
    double maxH = KAutoHDiv2(162);
    double arr[3] = {num1, num2, num3};
    NSArray *viewArr = @[_view_bank, _view_luobo, _view_baobao];
    int maxI = 0;
    for (int i = 0; i < viewArr.count; i++) {
        maxI = arr[maxI] > arr[i] ? maxI : i;
    }
    for (int i = 0; i < viewArr.count; i++) {
        UIView *view = viewArr[i];
        double h_i = maxH * arr[i] / arr[maxI];
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            if (maxI == i) {
                make.height.mas_equalTo(maxH);
            } else {
                make.height.mas_equalTo(h_i);
            }
        }];
        
    }
}

- (UIView *)whiteView
{
    if (_whiteView == nil) {
        UIView *view = [UIView new];
        _whiteView = view;
        [self.view addSubview:view];
        view.backgroundColor = [UIColor whiteColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
    return _whiteView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
