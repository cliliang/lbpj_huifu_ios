//
//  LBJiaoYeDetailVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBJiaoYeDetailVC.h"
#import "LBNumberTimer.h"

@interface LBJiaoYeDetailVC ()

@property (weak, nonatomic) IBOutlet UIView *view_shuLine; // 竖线
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftNum; // iPhone5适配可能会用到
@property (nonatomic, assign) BOOL goAnimation;
@property (weak, nonatomic) IBOutlet UIView *bgView_3;
@property (weak, nonatomic) IBOutlet UIView *view_hengLine; // 横线

@end

@implementation LBJiaoYeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"交易详情";
    self.view.backgroundColor = kBackgroundColor;
    
    // 颜色
    self.label_title.textColor = kDeepColor;
    self.label_zhuangtai.textColor = kNavBarColor;
    self.label_zhuangTai_zi.textColor = kColor_707070;
    self.label_yujihuankuanNum.textColor = kDeepColor;
    self.label_yujihuankuan.textColor = kLightColor;
    self.label_yujishouyiNum.textColor = kDeepColor;
    self.label_yujishouyi.textColor = kLightColor;
    self.label_goumaijinENum.textColor = kDeepColor;
    self.label_goumaijinE.textColor = kLightColor;
    self.label_nianhuashouyiNum.textColor = kDeepColor;
    self.label_nianhuashouyi.textColor = kLightColor;
    self.label_huankuanTime.textColor = kDeepColor;
    self.label_huanKuanriqi_title.textColor = kLightColor;
    self.label_chengjiaoTime.textColor = kDeepColor;
    self.label_chengJiaoTime_title.textColor = kLightColor;
    self.view_hengLine.backgroundColor = kLineColor;
    self.view_benJin.backgroundColor = kNavBarColor;
    self.view_shouYi.backgroundColor = [UIColor colorWithRGBString:@"ff9582"];
    
    self.label_title.text = self.name;
    self.label_zhuangtai.text = self.statusString;
//    self.label_yujishouyiNum.text = self.yuJiShouYi; // 预计收益
//    self.label_goumaijinENum.text = self.gouMaiJinE; // 购买金额
//    self.label_yujihuankuanNum.text = self.yuJiHuanKuan; // 预计还款
    self.label_yujishouyiNum.text = @"0.00"; // 预计收益
    self.label_goumaijinENum.text = @"0.00"; // 购买金额
    self.label_yujihuankuanNum.text = @"0.00"; // 预计还款
    self.label_nianhuashouyiNum.text = self.nianHuaShouYi;
    self.label_huankuanTime.text = self.huanKuanTime;
    self.label_chengjiaoTime.text = self.chengJiaoTime;
//    if (kScreenWidth == 320) { // iPhone5
//        [self.label_yujishouyiNum mas_updateConstraints:^(MASConstraintMaker *make) {
////            make.left.mas_equalTo(self.view).offset(40);
//            make.centerX.mas_equalTo(self.view.mas_left).offset(63);
//        }];
//    }
    [self.label_yujishouyiNum mas_updateConstraints:^(MASConstraintMaker *make) {
        if (kIPHONE_5s) {
            make.centerX.mas_equalTo(self.view.mas_left).offset(65);
        } else {
            make.centerX.mas_equalTo(self.view.mas_left).offset(86);
        }
    }];
    
    if (self.orderModel.gcId == 13) { // 快赚
        self.label_huanKuanriqi_title.alpha = 0;
        self.label_huankuanTime.alpha = 0;
        self.view_shuLine.alpha = 0;
        [self.label_chengJiaoTime_title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgView_3).offset(- kScreenWidth / 2 + 26);
        }];
        self.label_yujishouyi.text = @"预计30天收益";
    } else {
        [self.label_chengJiaoTime_title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.bgView_3).offset(-67);
        }];
    }
    [self.label_chengjiaoTime mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.label_chengJiaoTime_title.mas_centerX);
    }];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.goAnimation == NO) {
        
        
        CGFloat firstTime = 2;
        CGFloat secondTime = 1;
        
        // 文字动画
        LBNumberTimer *oneTimer = [[LBNumberTimer alloc] init];
        [oneTimer setNumberBlock:^(CGFloat itemNum) {
            NSString *numStr = [NSString stringWithFormat:@"%d", (int)itemNum];
            self.label_goumaijinENum.text = numStr;
            self.label_yujihuankuanNum.text = numStr;
        }];
        [oneTimer fireWithStartNum:0 floatNum:[self.gouMaiJinE floatValue] time:firstTime count:50];
        
        
        // 矩形位移
        self.view_benJin.frame = CGRectMake(self.view_benJin.left, self.view_benJin.bottom, self.view_benJin.width, 1);
        self.view_shouYi.hidden = YES;
        [UIView animateWithDuration:firstTime animations:^{
            self.view_benJin.frame = CGRectMake(self.view_benJin.left, self.view_benJin.bottom - 120, self.view_benJin.width, 120);
        } completion:^(BOOL finished) {
            self.view_shouYi.frame = CGRectMake(self.view_shouYi.left, self.view_shouYi.bottom, self.view_shouYi.width, 1);
            self.view_shouYi.hidden = NO;
            [UIView animateWithDuration:secondTime animations:^{
                self.view_shouYi.frame = CGRectMake(self.view_shouYi.left, self.view_shouYi.bottom - 20, self.view_shouYi.width, 20);
            }];
            
            // 数字2次动画
            LBNumberTimer *oneTimer = [[LBNumberTimer alloc] init];
            [oneTimer setNumberBlock:^(CGFloat itemNum) {
                NSString *numStr_1 = [NSString stringWithFormat:@"%.2lf", itemNum];
                NSString *numStr_2 = [NSString stringWithFormat:@"%.2lf", itemNum + [self.gouMaiJinE floatValue]];
                self.label_yujishouyiNum.text = numStr_1;
                self.label_yujihuankuanNum.text = numStr_2;
            }];
            [oneTimer fireWithStartNum:0 floatNum:[self.yuJiShouYi floatValue] time:secondTime count:20];
            
            // 文字2次位移
            [self.label_yujihuankuan mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.view_shouYi.mas_top).offset(-13);
            }];
            [self animationMoveWithView:self.label_yujihuankuan height:20 time:secondTime];
            [self animationMoveWithView:self.label_yujihuankuanNum height:20 time:secondTime];
        }];
        
        // 文字位移
        [self.label_yujihuankuan mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view_shouYi.mas_top).offset(7);
        }];
        [self animationMoveWithView:self.label_yujihuankuan height:120 time:firstTime];
        [self animationMoveWithView:self.label_yujihuankuanNum height:120 time:firstTime];
        
        self.goAnimation = YES;
    }
}

- (void)animationMoveWithView:(UIView *)view height:(CGFloat)height time:(CGFloat)time
{
    CGRect frame = view.frame;
    view.frame = CGRectMake(view.left, view.top + height, view.width, view.height);
    
    [UIView animateWithDuration:time animations:^{
        view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
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
