//
//  LBExperMoneyVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/22.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBExperMoneyVC.h"
#import "LBExperMoneyModel.h"

@interface LBExperMoneyVC ()

@property (weak, nonatomic) IBOutlet UIButton *btn_lijijiaru;

@property (weak, nonatomic) IBOutlet UILabel *label_tian;
@property (weak, nonatomic) IBOutlet UILabel *label_yuan;
@property (weak, nonatomic) IBOutlet UILabel *label_baifenhao;


@property (weak, nonatomic) IBOutlet UILabel *label_nianhuashouyiNum;
@property (weak, nonatomic) IBOutlet UILabel *label_licaiqixianNum;
@property (weak, nonatomic) IBOutlet UILabel *label_touzijineNum;

@property (nonatomic, strong) LBExperMoneyModel *model;

@end

@implementation LBExperMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kBackgroundColor;
    [self.btn_lijijiaru becomeCircleWithR:4];
    self.btn_lijijiaru.backgroundColor = kNavBarColor;
    self.label_nianhuashouyiNum.text = @"";
    self.label_licaiqixianNum.text = @"";
    self.label_touzijineNum.text = @"";
    [self addImages];
    [self hideThisView];
    [self setUpData];
    
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self setUpData];
    }];

}
- (void)setUpData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBHTTPObject POST_experienceMoneyDetailSuccess:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([NSObject nullOrNilWithObjc:dict]) {
            return ;
        }
        LBExperMoneyModel *model = [LBExperMoneyModel mj_objectWithKeyValues:dict[@"rows"]];
        _model = model;
        [self refreshUI];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
// 添加图片方法
- (void)addImages
{
    // 1.背景图
    UIImageView *imageV1 = [[UIImageView alloc] init];
    imageV1.image = [UIImage imageNamed:@"image_tiyanjin_bg"];
    [self.view addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64 - kJian64);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(_label_licaiqixianNum.mas_top).offset(-KAutoHDiv2(35 + 46));
    }];
    // 2.送8888
    CGFloat top1 = 78;
    CGFloat width1 = 614;
    CGFloat height1 = 610;
    if (kIPHONE_5s) {
        top1 = 60;
        width1 = width1 * 0.9;
        height1 = height1 * 0.9;
    }
    UIImageView *imageV2 = [UIImageView new];
    imageV2.image = [UIImage imageNamed:@"image_tiyanjin_song8888"];
    [self.view addSubview:imageV2];
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV1).offset(KAutoHDiv2(top1));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(KAutoHDiv2(width1));
        make.height.mas_equalTo(KAutoHDiv2(height1));
    }];
    // 3.文字
    UIImageView *imageV3 = [UIImageView new];
    imageV3.image = [UIImage imageNamed:@"image_tiyanjin_wenzi"];
    [self.view addSubview:imageV3];
    [imageV3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV2.mas_bottom).offset(KAutoHDiv2(54));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(KAutoWDiv2(325));
        make.height.mas_equalTo(KAutoWDiv2(40));
    }];
    // 4.新手体验
    UIImageView *imageV4 = [UIImageView new];
    imageV4.image = [UIImage imageNamed:@"image_tiyanjin_xinshoutiyan"];
    [self.view addSubview:imageV4];
    [imageV4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(imageV1.mas_bottom);
        make.width.mas_equalTo(KAutoWDiv2(165));
        make.height.mas_equalTo(KAutoWDiv2(70));
    }];
}
- (void)refreshUI
{
    if (_model) {
        self.label_nianhuashouyiNum.text = kStringFormat(@"%.2f", _model.proceeds);
        self.label_licaiqixianNum.text = kIntString(_model.investTime);
        self.label_touzijineNum.text = kIntString(_model.goodMoney);
        if (kUserModel) {
            self.btn_lijijiaru.backgroundColor = _model.goodFlg ? [UIColor lightGrayColor] : kNavBarColor;
            self.btn_lijijiaru.userInteractionEnabled = !_model.goodFlg;
            NSString *btnTitle = _model.goodFlg ? @"立即加入" : @"立即加入";
            [self.btn_lijijiaru setTitle:btnTitle forState:UIControlStateNormal];
        }
        [self showThisView];
    }
}

// 立即加入
- (IBAction)clickBtn:(id)sender {
    if (kUserModel == nil) {
        [LBLoginViewController login];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBHTTPObject POST_buyExperienceMoneySuccess:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        kLog(@"%@", dict);
        [[LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:dict[@"message"]] show];
        if ([dict[@"success"] boolValue]) {
            [self.btn_lijijiaru setTitle:@"立即加入" forState:UIControlStateNormal];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)hideThisView
{
    for (UIView *subView in self.view.subviews) {
        subView.hidden = YES;
    }
}
- (void)showThisView
{
    for (UIView *subView in self.view.subviews) {
        subView.hidden = NO;
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end
