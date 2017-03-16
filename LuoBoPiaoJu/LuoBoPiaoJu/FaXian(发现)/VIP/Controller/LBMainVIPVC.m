//
//  LBMainVIPVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMainVIPVC.h"
#import "LBVipKindsView.h"
#import "LBVipPrivilegeView.h"
#import "LBGetHongBaoView.h"
#import "LBHongBaoModel.h"

@interface LBMainVIPVC ()
{
    LBUserModel *userModel;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LBVipKindsView *vipKindsView;
@property (nonatomic, strong) NSArray *vipArray;
@property (nonatomic, strong) NSArray *upArray; // 升级条件
@property (nonatomic, strong) NSMutableArray *hongBaoDataArr;

@property (nonatomic, assign) NSInteger vipIndex;

@end

@implementation LBMainVIPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"会员特权";
    userModel = kUserModel;
    self.view.backgroundColor = [UIColor whiteColor];
    [self uploadData];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [_scrollView removeFromSuperview];
        _scrollView = nil;
        [self uploadData];
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (userModel == nil) {
        [self addScrollViewInThis];
    }
}
- (void)uploadData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBHTTPObject POST_getHongBaoListSuccess:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (![NSObject nullOrNilWithObjc:dict]) {
            NSArray *rows = dict[@"rows"];
            self.hongBaoDataArr = [LBHongBaoModel mj_objectArrayWithKeyValuesArray:rows];
            [self addScrollViewInThis];
        }
    } failure:^(NSError * _Nonnull error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}
- (void)addScrollViewInThis
{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64 - kJian64);
        make.bottom.left.right.mas_equalTo(self.view);
    }];
    _scrollView = scrollView;
//    scrollView.showsVerticalScrollIndicator = NO;
    
    // 会员种类
    LBVipKindsView *kindsV = [[LBVipKindsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KAutoHDiv2(200))];
    [scrollView addSubview:kindsV];
    [kindsV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(scrollView);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KAutoHDiv2(200));
    }];
    
    // 成长条件
    UIView *backView_1 = [[UIView alloc] init];
    [scrollView addSubview:backView_1];
    [backView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kindsV.mas_bottom);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth + 4);
        make.height.mas_equalTo(kDiv2(66));
    }];
    backView_1.layer.borderWidth = 0.5;
    backView_1.layer.borderColor = kLineColor.CGColor;
    backView_1.backgroundColor = [UIColor whiteColor];
    UILabel *label_chengzhang = [[UILabel alloc] init];
    [backView_1 addSubview:label_chengzhang];
    [label_chengzhang setText:self.upArray[0] textColor:kDeepColor font:[UIFont systemFontOfSize:13]];
    [label_chengzhang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(backView_1);
    }];
    
    // 特权礼遇
    UILabel *label_tequan = [[UILabel alloc] init];
    [scrollView addSubview:label_tequan];
    [label_tequan setText:@"特权礼遇" textColor:kNavBarColor font:[UIFont systemFontOfSize:15]];
    [label_tequan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(backView_1.mas_bottom).offset(kDiv2(40));
    }];
    LBVipPrivilegeView *privView = [[LBVipPrivilegeView alloc] init];
    [scrollView addSubview:privView];
    [privView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView_1.mas_bottom).offset(div_2(80));
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(div_2(360));
    }];
    NSArray *dataArr = @[@"本金红包", @"惊喜红包", @"生日红包", @"特权活动", @"专属客服", @"双倍积分", @"专属礼物"];
    privView.dataArr = dataArr;
    privView.boolArr = self.vipArray[0];
    [privView reloadDataBlocksView];
    
    // 特权红包领取
    CGFloat hbCellH = kDiv2(220);
    NSInteger hongBaoLine = self.hongBaoDataArr ? (self.hongBaoDataArr.count - 1) / 3 + 1 : 0; // 有数据就计算，没数据给0
    UILabel *label_getHongbao = [[UILabel alloc] init];
    label_getHongbao.hidden = hongBaoLine ? NO : YES; // 有数据显示，没数据不显示
    
    LBGetHongBaoView *getHongBaoView = [[LBGetHongBaoView alloc] init];
    if (userModel != nil) {
        [label_getHongbao setText:@"特权红包领取" textColor:kNavBarColor font:[UIFont systemFontOfSize:15]];
        [scrollView addSubview:label_getHongbao];
        [label_getHongbao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(privView.mas_bottom).offset(kDiv2(40));
            make.left.mas_equalTo(label_tequan);
        }];
        [scrollView addSubview:getHongBaoView];
        [getHongBaoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(privView.mas_bottom).offset(kDiv2(80));
            double jiange = hongBaoLine ? 1 : 0; // 线条
            make.height.mas_equalTo(hongBaoLine * hbCellH + jiange);
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view);
        }];
        getHongBaoView.dataArray = self.hongBaoDataArr;
        if (userModel == nil) {
            label_getHongbao.hidden = YES;
            getHongBaoView.hidden = YES;
        }
    }

    // 特权说明
    UILabel *label_shuoming = [[UILabel alloc] init];
    [scrollView addSubview:label_shuoming];
    [label_shuoming setText:@"特权说明" textColor:kDeepColor font:[UIFont systemFontOfSize:15]];
    CGFloat shuomingCenterY = userModel ? hongBaoLine * hbCellH + kDiv2(80) : 0;
    shuomingCenterY = hongBaoLine ? shuomingCenterY : 0; // 有数据不变，没数据给0
    [label_shuoming mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(privView.mas_bottom).offset(shuomingCenterY + 20);
        make.left.mas_equalTo(self.view).offset(15);
    }];
    
    // 特权说明文本
    // 1.本金红包
    UILabel *label_benjinhongbao = [[UILabel alloc] init];
    label_benjinhongbao.text = @"本金红包: 本金红包300元";
    [scrollView addSubview:label_benjinhongbao];
    [label_benjinhongbao hongBaoMiaoShuTitle];
    [label_benjinhongbao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(privView.mas_bottom).offset(div_2(80 + 30) - 2 + shuomingCenterY);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    // 2.惊喜红包
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.text = @"惊喜红包: 定期为您赠送惊喜红包 200至1000元本金红包请注意查看通知和福利中红包有效期。";
    [scrollView addSubview:label_2];
    [label_2 hongBaoMiaoShuTitle];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_benjinhongbao.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    // 3.生日红包
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.text = @"生日红包: 在您生日当天赠送本金红包\r\n铜牌会员 100元\r\n银牌会员 300元\r\n金牌会员 500元\r\n钻石会员 800元\r\n金钻会员1000元";
    [scrollView addSubview:label_3];
    [label_3 hongBaoMiaoShuTitle];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_2.mas_bottom).offset(12);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    // 4.特权活动
    UILabel *label_4 = [[UILabel alloc] init];
    label_4.text = @"特权活动: 会定期推出特权会员活动，限专属会员参加。活动形式不限于理财投资";
    [scrollView addSubview:label_4];
    [label_4 hongBaoMiaoShuTitle];
    [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_3.mas_bottom).offset(12);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    // 5.专属客服
    UILabel *label_5 = [[UILabel alloc] init];
    label_5.text = @"专属客服: 微信、电话、专人快速响应式服务。";
    [scrollView addSubview:label_5];
    [label_5 hongBaoMiaoShuTitle];
    [label_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_4.mas_bottom).offset(12);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    // 6.双倍积分
    UILabel *label_6 = [[UILabel alloc] init];
    label_6.text = @"双倍积分: 签到积分双倍奖励。其他活动双倍奖励注意查看活动规则。";
    [scrollView addSubview:label_6];
    [label_6 hongBaoMiaoShuTitle];
    [label_6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_5.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    // 7.专属礼物
    UILabel *label_7 = [[UILabel alloc] init];
    label_7.text = @"专属礼物: 重大节日或周年庆，送您专属礼物。";
    [scrollView addSubview:label_7];
    [label_7 hongBaoMiaoShuTitle];
    [label_7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_6.mas_bottom).offset(12);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    // 8.会员特权规则
    UILabel *label_8 = [[UILabel alloc] init];
    label_8.text = @"会员特权规则:\r\n1. 会员特权身份是以账户总资产金额为准，总资产金额低于或高于特权要求标准会员身份将自动降级、升级。\r\n2. 会员特权身份不能转增和延期。\r\n3. 本金红包不能直接用于提现，限用于投资使用，本金红包收益可提现。";
    [scrollView addSubview:label_8];
    [label_8 hongBaoMiaoShuTitle];
    [label_8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_7.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
    }];
    
    // 特权说明外边框
    UIView *borderView = [[UIView alloc] init];
    borderView.layer.borderWidth = 0.5;
    borderView.layer.borderColor = kLineColor.CGColor;
    [scrollView addSubview:borderView];
    [borderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_benjinhongbao.mas_top).offset(-12);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.bottom.mas_equalTo(label_8).offset(12);
    }];
    
    [scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(borderView).offset(20);
    }];
    
    // 初始化
    NSInteger resultVip = [NSObject vipWithMoney:kUserModel.countMoney];
    kindsV.myVipGrade = resultVip;
    if (resultVip < 10) {
        label_chengzhang.text = self.upArray[resultVip];
        privView.boolArr = self.vipArray[resultVip];
        [privView reloadDataBlocksView];
    }
    
    // 各种回调方法
    [kindsV setSelectedBlock:^(NSInteger index) {
        privView.boolArr = self.vipArray[index];
        [privView reloadDataBlocksView];
        _vipIndex = index;
        label_chengzhang.text = self.upArray[index];
    }];
    [privView setVipPrivBlock:^(NSInteger index) {
        if ([self.vipArray[_vipIndex][index] boolValue]) {
            kLog(@"%@", dataArr[index]);
        }
    }];
    
    __weak typeof(getHongBaoView) weakHBView = getHongBaoView;
    [getHongBaoView setClickBlock:^(NSInteger index) {
        LBHongBaoModel *model = self.hongBaoDataArr[index];
        if (model.gtype == 0) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [LBHTTPObject POST_getHongBaoMoneyWithVID:model.vid Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([dict[@"success"] boolValue] == YES) {
                    [[LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:dict[@"message"]] show];
                    model.gtype = 1;
                    [weakHBView.collectionView reloadData];
                }
            } failure:^(NSError * _Nonnull error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];
        }
    }];
    
    if ([[PSSUserDefaultsTool getValueWithKey:kHuiYuanTeQuanFirst] boolValue]) {
        [LBFunctionRemindView showWithImageName:@"image_huiyuantixi"];
        [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:NO] WithKey:kHuiYuanTeQuanFirst];
    }
}

- (NSArray *)vipArray
{
    if (_vipArray == nil) {
        _vipArray = @[
                      @[@0, @0, @0, @0, @0, @0, @0],
                      @[@1, @0, @1, @0, @0, @0, @0],
                      @[@0, @1, @1, @1, @0, @0, @0],
                      @[@0, @1, @1, @1, @0, @1, @0],
                      @[@0, @1, @1, @1, @1, @1, @1],
                      @[@0, @1, @1, @1, @1, @1, @1]
                      ];
    }
    return _vipArray;
}
- (NSArray *)upArray
{
    if (_upArray == nil) {
        _upArray = @[@"成长条件: 完成注册", @"成长条件: 完成实名、银行卡绑定", @"成长条件: 账户总资产金额5000元-30000元", @"成长条件: 账户总资产金额3万-20万", @"成长条件: 账户总资产金额20万-100万", @"成长条件: 账户总资产金额100万以上"];
    }
    return _upArray;
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
