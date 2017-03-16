//
//  LBMoneyBillDetailVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMoneyBillDetailVC.h"
#import "LBMoneyBillHeaderView.h"
#import "LBMoneyBillDetailSecondView.h"
#import "PSSSegmentControl.h"
#import "LBChanPinDetail.h"
#import "LBXiangMuShenHe.h"
#import "LBJiaoYiJiLu.h"
#import "LBLiJiJiaRuVC.h"
#import "LBGoodsModel.h"
#import <UIImageView+AFNetworking.h>

@interface LBMoneyBillDetailVC () <UIScrollViewDelegate>

@property (nonatomic, strong) LBMoneyBillHeaderView *headerView;
@property (nonatomic, strong) LBMoneyBillDetailSecondView *progressView;
@property (nonatomic, strong) PSSSegmentControl *segment;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btn_LiJiJiaRu;
@property (nonatomic, assign) BOOL isScroll;

@property (nonatomic, strong) LBChanPinDetail *chanPinDetailView;
@property (nonatomic, strong) LBXiangMuShenHe *xiangMuShenHeView;
@property (nonatomic, strong) LBJiaoYiJiLu *jiaoYiJiLuView;

@property (nonatomic, strong) LBGoodsModel *goodModel;

@property (nonatomic, strong) LBUserModel *userModel;

@property (nonatomic, strong) NSString *imgUrl;

@property (nonatomic, assign) BOOL isXinShou;

@end

@implementation LBMoneyBillDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [LBUserModel updateUserWithUserModel:^{
        self.userModel = [LBUserModel getInPhone];
        if (self.userModel.userType != 0 && self.isNewHand == YES) { // 非新手不让点
            self.isXinShou = YES;
        }
    }];
    
    [self setUpData];
    if (self.userModel.userType != 0 && self.isNewHand == YES) { // 非新手不让点
        self.isXinShou = YES;
    }
    
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self setUpData];
        kLog(@"商品详情页面网来啦 = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ")
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userModel = [LBUserModel getInPhone];
    self.btn_LiJiJiaRu.layer.cornerRadius = 5;
    self.btn_LiJiJiaRu.backgroundColor = kNavBarColor;
    self.view.backgroundColor = kBackgroundColor;
    [self addHeaderViewInThis];
    [self addProgressViewInThis];
    [self addSegmentView];
    [self addScrollViewInThis];
    [self firstHide];
}
- (void)firstHide
{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = YES;
    }];
}
- (void)firstShow
{
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.hidden = NO;
    }];
}
- (void)setUpData
{
//    if (self.userModel == nil) {
//        return;
//    }
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_chanPinXiangQing];
    
    NSDictionary *param;
    if (self.gcId == 0 || self.gcId == 13) {
        param = @{
                @"goodId":@(0)
                };
    } else {
        param = @{
                @"goodId":@(self.goodId)
                };
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dict[@"success"] boolValue]) {
            NSDictionary *rows = dict[@"rows"];
            if (rows) {
                NSDictionary *good = rows[@"good"];
                LBGoodsModel *model = [LBGoodsModel mj_objectWithKeyValues:good];
                self.goodModel = model;
                self.gcId = model.gcId;
                if (self.userModel.userType != 0 && model.gcId == 11) {
                    self.isXinShou = YES;
                }
                self.imgUrl = rows[@"imgUrl"];
                [self shuaXinViewWithBuyflg1:model.buyflg1];
                [self firstShow];
            }
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)shuaXinViewWithBuyflg1:(int)buyflg1
{
    // 更新头
    self.headerView.label_licaiqixian.text = [NSString stringWithFormat:@"%ld", (long)self.goodModel.investTime];
    self.headerView.label_nianHuaShouYe.text = [NSString stringWithFormat:@"%.2lf", self.goodModel.proceeds];
    self.headerView.label_qiTouJinE.text = kStringFormat(@"%ld", self.goodModel.investUnit);
    self.headerView.label_bank.text = self.goodModel.bankName;
    self.headerView.label_ketoujine.text = [NSString stringWithFormat:@"%d", (int)self.goodModel.surplusMoney];

    
    if (self.goodModel.surplusMoney == 0) {
        self.btn_LiJiJiaRu.userInteractionEnabled = NO;
        self.btn_LiJiJiaRu.backgroundColor = [UIColor lightGrayColor];
        self.btn_LiJiJiaRu.titleLabel.text = @"抢光";
        [self.btn_LiJiJiaRu setTitle:@"抢光" forState:UIControlStateNormal];
    }
    

    // 更新购买金额百分比
    [self.headerView drawCircleWithPercent:(self.goodModel.buyMoney - self.goodModel.surplusMoney) * 1.0 / self.goodModel.buyMoney];
    
    // 刷新进度条
    self.progressView.timeArr = @[self.goodModel.onLineTime ? self.goodModel.onLineTime : self.goodModel.createTime  , self.goodModel.valuesTime, self.goodModel.valueTime, self.goodModel.valuedTime];
    
    if (self.goodModel.buyflg1 == 1) {
        self.btn_LiJiJiaRu.backgroundColor = [UIColor lightGrayColor];
        self.btn_LiJiJiaRu.userInteractionEnabled = NO;
        self.btn_LiJiJiaRu.titleLabel.text = @"已还款";
        [self.btn_LiJiJiaRu setTitle:@"已还款" forState:UIControlStateNormal];
    } else if (self.goodModel.buyflg1 == 2) {
        if (self.gcId != 0 && self.gcId != 13) {
            [self.headerView drawCircleWithPercent:1.0];
            self.btn_LiJiJiaRu.userInteractionEnabled = NO;
            self.btn_LiJiJiaRu.titleLabel.text = @"还款中";
            [self.btn_LiJiJiaRu setTitle:@"还款中" forState:UIControlStateNormal];
            self.btn_LiJiJiaRu.backgroundColor = [UIColor lightGrayColor];
        }
    } else if (self.goodModel.buyflg1 == 3) {
            self.btn_LiJiJiaRu.userInteractionEnabled = NO;
            self.btn_LiJiJiaRu.backgroundColor = [UIColor lightGrayColor];
            [self.headerView drawCircleWithPercent:1.0];
            self.headerView.label_ketoujine.text = @"0";
            self.btn_LiJiJiaRu.titleLabel.text = @"抢光";
            [self.btn_LiJiJiaRu setTitle:@"抢光" forState:UIControlStateNormal];
    } else if (self.goodModel.buyflg1 == 4) {
        
    } else {
        self.btn_LiJiJiaRu.userInteractionEnabled = NO;
        self.btn_LiJiJiaRu.backgroundColor = [UIColor lightGrayColor];
        [self.headerView drawCircleWithPercent:1.0];
        self.headerView.label_ketoujine.text = @"0";
        self.btn_LiJiJiaRu.titleLabel.text = @"无法购买";
        [self.btn_LiJiJiaRu setTitle:@"无法购买" forState:UIControlStateNormal];
    }
    
    if ([self compareDateWithNow:self.goodModel.valuedTime]) { // 还款日
        self.progressView.progressStyle = LBProgressFinished;
        if (self.gcId != 0 && self.gcId != 13) {
            [self.headerView drawCircleWithPercent:1.0];
        }
    } else if ([self compareDateWithNow:self.goodModel.valueTime]) { // 结息
        self.progressView.progressStyle = LBProgressJieXiRi;
        [self.progressView setLineColorWithStartTime:self.goodModel.valueTime endTime:self.goodModel.valuedTime style:LBProgressJieXiRi];

    } else if ([self compareDateWithNow:self.goodModel.valuesTime]) { // 起息
        self.progressView.progressStyle = LBProgressQiXiRi;
        [self.progressView setLineColorWithStartTime:self.goodModel.valuesTime endTime:self.goodModel.valueTime style:LBProgressQiXiRi];
    } else if ([self compareDateWithNow:[self.goodModel.createTime substringToIndex:10]]) {
        self.progressView.progressStyle = LBProgressFaShouRi;
        [self.progressView setLineColorWithStartTime:[self.goodModel.createTime substringToIndex:10] endTime:self.goodModel.valuesTime style:LBProgressFaShouRi];
    } else {
        
    }
    
    if (self.gcId == 10) {
        NSString *string_1 = self.goodModel.payLabel;
        NSString *string_2 = @"到期本息自动返回至账户";
        NSString *string_3 = self.goodModel.valuesTime;
        NSString *string_4 = self.goodModel.valueTime;
        NSArray *array = nil;
        array = @[string_1, string_2, string_3, string_4];
        self.chanPinDetailView.dataArray = array;
        [self.chanPinDetailView refreshThisView];
    }
    
    
//    [self.xiangMuShenHeView.imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_HOSTImage, self.imgUrl]] placeholderImage:[UIImage imageNamed:@"image_placeHolder"]];
//    self.xiangMuShenHeView.imageUrl = [NSString stringWithFormat:@"%@%@", URL_HOSTImage, self.imgUrl];
    
    self.chanPinDetailView.imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_HOSTImage, self.imgUrl]];
    
    self.jiaoYiJiLuView.goodId = self.goodModel.goodId;
    [self.jiaoYiJiLuView refreshHeader];
}


// 添加头部
- (void)addHeaderViewInThis
{
    self.headerView = [LBMoneyBillHeaderView instanceWithFrame:CGRectMake(0, 64 - kJian64, 400, KAutoHDiv2(450))];
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        if (kIPHONE_5s) { // 5s
//            make.top.mas_equalTo(40 - kJian64);
//            make.height.mas_equalTo(200);
//        } else {
//            make.top.mas_equalTo(64 - kJian64);
//            make.height.mas_equalTo(225);
//        }
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoHDiv2(450));
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    if (_gcId == GCID_DINGTOU) {
        self.headerView.label_bank.textColor = [UIColor clearColor];
    } else {
        self.headerView.label_bank.textColor = UIColorFromHexString(@"ffdbd7", 1);
    }
}

// 添加进度条
- (void)addProgressViewInThis
{
    self.progressView = [[LBMoneyBillDetailSecondView alloc] initWithFrame:CGRectMake(0, self.headerView.bottom + 10, kScreenWidth, 55)];
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.gcId != 5) {
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(0);
            make.top.mas_equalTo(self.headerView.mas_bottom).offset(0);
            make.left.mas_equalTo(self.view);
            self.progressView.hidden = YES;
        } else {
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(55);
            make.top.mas_equalTo(self.headerView.mas_bottom).offset(10);
            make.left.mas_equalTo(self.view);
        }
    }];
}
// 添加segment
- (void)addSegmentView
{
//    if (self.gcId == 5) {
//        self.segment = [[PSSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) titleArray:@[@"产品详情", @"项目审核", @"交易记录"]];
//    } else {
//        self.segment = [[PSSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) titleArray:@[@"产品详情", @"产品特点", @"交易记录"]];
//    }
    self.segment = [[PSSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) titleArray:@[@"详细信息", @"交易记录"]];
    [self.view addSubview:self.segment];
    self.segment.selectedColor = [UIColor blackColor];
    self.segment.lineWidth = 55;
    self.segment.labelFont = [UIFont pingfangWithFloat:KAutoHDiv2(30) weight:UIFontWeightLight];
    self.segment.lineColor = kNavBarColor;
    self.segment.bottomLineColor = kLineColor;
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        if (self.gcId == 0 || self.gcId == 13) {
            make.top.mas_equalTo(self.progressView.mas_bottom).offset(0);
        } else {
            make.top.mas_equalTo(self.progressView.mas_bottom).offset(10);
        }
        make.height.mas_equalTo(40);
    }];
    __weak typeof(self) weakSelf = self;
    [self.segment setButtonBlock:^(NSInteger index) {
        _isScroll = YES;
        [weakSelf.scrollView setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
    }];
}
// -添加产品详情, 项目审核, 交易记录 2.2.5 之前
// -添加产品详情 + 交易记录 2.2.6
- (void)addScrollViewInThis
{
    UIScrollView *scrollView = [UIScrollView new];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.scrollEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.segment.mas_bottom);
        make.bottom.mas_equalTo(self.btn_LiJiJiaRu.mas_top).offset(-15);
        make.width.mas_equalTo(kScreenWidth);
    }];
    
    // -产品详情
    LBChanPinDetail *detailView = [[LBChanPinDetail alloc] initWithGCID:self.gcId];
    [scrollView addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.height.and.left.mas_equalTo(scrollView);
        make.width.mas_equalTo(kScreenWidth);
    }];
    self.chanPinDetailView = detailView;
    
    // 交易记录
    LBJiaoYiJiLu *tradeView = [LBJiaoYiJiLu new];
    [scrollView addSubview:tradeView];
    [tradeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(detailView.mas_right);
        make.top.mas_equalTo(scrollView).offset(-1);
        make.height.mas_equalTo(scrollView);
        make.width.mas_equalTo(kScreenWidth);
    }];
    self.jiaoYiJiLuView = tradeView;
    
    [scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(tradeView);
    }];
    
}
// 点击立即加入
- (IBAction)clickButton:(id)sender {
    
    if (self.isXinShou) {
        LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:@"仅限新手，请查看其他理财产品"];
        [alert show];
        return;
    }
    
    if (self.userModel == nil || [self.userModel isKindOfClass:[NSNull class]]) {
        [LBLoginViewController login];
        return;
    }
    LBLiJiJiaRuVC *viewC = [LBLiJiJiaRuVC new];
    viewC.goodModel = self.goodModel;
    viewC.gcId = self.gcId;
    [self.navigationController pushViewController:viewC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isScroll) {
        return;
    }
    if (scrollView.contentOffset.x < kScreenWidth / 2) {
        self.segment.selectedIndex = 0;
    } else if (scrollView.contentOffset.x < kScreenWidth * 3 / 2) {
        self.segment.selectedIndex = 1;
    } else {
        self.segment.selectedIndex = 2;
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.isScroll = NO;
}


// -小于当前时间, return YES
- (BOOL)compareDateWithNow:(NSString *)dateOne
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:dateOne];
    NSTimeInterval timeInt = [date timeIntervalSince1970];
    NSTimeInterval timeCount = timeInt;
    
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowTimeCount = [nowDate timeIntervalSince1970];
    if (timeCount < nowTimeCount) {
        return YES;
    } else {
        return NO;
    }
    return YES;
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
