//
//  LBSignEverydayVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBSignEverydayVC.h"
#import "LBSignRecordView.h"

@interface LBSignEverydayVC ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) LBSignRecordView *signRecordView;
@property (nonatomic, strong) UISwitch *openSwitch;

@property (nonatomic, strong) UILabel *signLabel;
@property (nonatomic, strong) UIImageView *signImageV;
@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, strong) NSMutableDictionary *recordDict;

@end

@implementation LBSignEverydayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navcTitle = @"每日签到";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBHTTPObject POST_getSignRecordWithDate:@"" Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (![NSObject nullOrNilWithObjc:dict] && ![NSObject nullOrNilWithObjc:dict[@"rows"]]) {
            NSArray *rowsArr = dict[@"rows"];
            for (NSDictionary *recordD in rowsArr) {
                if ([NSObject nullOrNilWithObjc:recordD[@"createTime"]]) {
                    continue;
                }
                [self.recordDict setValue:@(YES) forKey:recordD[@"createTime"]];
            }
        }
        [self addSomeView];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self addSomeView];
    }];
    
    
}

- (void)addSomeView
{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    LBUserModel *userModel = kUserModel;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    _scrollView = scrollView;
    
    // 头部背景
    UIImageView *imageV = [UIImageView new];
    [scrollView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kDiv2(260));
    }];
    imageV.image = [UIImage imageNamed:@"bg_everydaySign_header"];
    
    // 签到背景圈
    UIImageView *signImgV = [UIImageView new];
    [imageV addSubview:signImgV];
    [signImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV).offset(kDiv2(18));
        make.centerX.mas_equalTo(imageV);
        make.width.height.mas_equalTo(kDiv2(150));
    }];
    signImgV.image = [UIImage imageNamed:@"icon_everydaySign_unsigned"];
    _signImageV = signImgV;
    
    // 签到label
    UILabel *signLabel = [UILabel new];
    [signImgV addSubview:signLabel];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(signImgV);
    }];
    _signLabel = signLabel;
    [signLabel setText:@"签到" textColor:kNavBarColor font:[UIFont pingfangWithFloat:kDiv2(30) weight:UIFontWeightRegular]];
    
    // 积分label
    UILabel *jifenLabel = [UILabel new];
    [imageV addSubview:jifenLabel];
    [jifenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(imageV).offset(-kDiv2(36));
        make.centerX.mas_equalTo(imageV);
        make.height.mas_equalTo(kDiv2(30));
    }];
    _scoreLabel = jifenLabel;
    [jifenLabel setText:[NSString stringWithFormat:@"已获积分: %@", userModel.userScore] textColor:[UIColor whiteColor] font:[UIFont pingfangWithFloat:kDiv2(30) weight:UIFontWeightLight]];
    
    // 添加签到记录View
    LBSignRecordView *signRecoreView = [LBSignRecordView new];
    [scrollView addSubview:signRecoreView];
    _signRecordView = signRecoreView;
    [signRecoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kDiv2(49 + 39 + 59 + 50) + KAutoHDiv2(390 + 80) - 10);
    }];
    signRecoreView.nowDate = [NSDate date];
    signRecoreView.recordDict = self.recordDict;
    [signRecoreView loadTheSubviews];
    
    
    // 线
    UIView *lineView1 = [UIView new];
    [scrollView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signRecoreView.mas_bottom);
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    lineView1.backgroundColor = [UIColor colorWithRGBString:@"e7e7e7"];
    
    UIView *lineView2 = [UIView new];
    [scrollView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView1.mas_bottom).offset(kDiv2(100));
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    lineView2.backgroundColor = [UIColor colorWithRGBString:@"e7e7e7"];
    
    //  每日提醒label
    UILabel *warningLabel = [UILabel new];
    [scrollView addSubview:warningLabel];
    [warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(kDiv2(30));
        make.centerY.mas_equalTo(lineView1.mas_bottom).offset(kDiv2(50));
    }];
    [warningLabel setText:@"每日提醒我签到" textColor:kDeepColor font:[UIFont pingfangWithFloat:kDiv2(30) weight:UIFontWeightLight]];
    
    // 开关
    UISwitch *openSwitch = [UISwitch new];
    [scrollView addSubview:openSwitch];
    [openSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-kDiv2(30));
        make.centerY.mas_equalTo(warningLabel);
    }];
    openSwitch.on = userModel.isOpenSignIn;
    
    [openSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(lineView2);
    }];
    
    // 是否签到过
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowTimeInt = [nowDate timeIntervalSince1970];
    NSTimeInterval twoTimeInt = [userModel.getScoreTime doubleValue];
    BOOL b1 = [NSDate compareOneDayTimeInt1:nowTimeInt timeInt2:twoTimeInt / 1000 + 100]; // 当前时间 = 上次签到时间
    signImgV.image = b1 ? [UIImage imageNamed:@"icon_everydaySign_signed"] : [UIImage imageNamed:@"icon_everydaySign_unsigned"];
    signLabel.text = b1 ? @"已签到" : @"签到";
}

- (void)switchValueChanged:(UISwitch *)swi
{
    [LBHTTPObject POST_setSignInAlertState:swi.on Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        kLog(@"签到提醒 -- 成功");
    } failure:^(NSError * _Nonnull error) {
        kLog(@"签到提醒 -- 失败");
    }];
}

- (NSMutableDictionary *)recordDict
{
    if (_recordDict == nil) {
        _recordDict = [NSMutableDictionary dictionary];
    }
    return _recordDict;
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








