//
//  LBJiaoYeDetailVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"

@interface LBJiaoYeDetailVC : LBViewController

@property (weak, nonatomic) IBOutlet UILabel *label_zhuangTai_zi;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_zhuangtai;
@property (weak, nonatomic) IBOutlet UILabel *label_yujishouyiNum;
@property (weak, nonatomic) IBOutlet UILabel *label_goumaijinENum;
@property (weak, nonatomic) IBOutlet UILabel *label_yujihuankuanNum;
@property (weak, nonatomic) IBOutlet UILabel *label_yujihuankuan;
@property (weak, nonatomic) IBOutlet UILabel *label_nianhuashouyiNum;

@property (weak, nonatomic) IBOutlet UILabel *label_huankuanTime;
@property (weak, nonatomic) IBOutlet UILabel *label_chengjiaoTime;

@property (weak, nonatomic) IBOutlet UILabel *label_yujishouyi;
@property (weak, nonatomic) IBOutlet UILabel *label_goumaijinE;
@property (weak, nonatomic) IBOutlet UILabel *label_nianhuashouyi;
@property (weak, nonatomic) IBOutlet UILabel *label_chengJiaoTime_title;
@property (weak, nonatomic) IBOutlet UILabel *label_huanKuanriqi_title;

@property (weak, nonatomic) IBOutlet UIView *view_benJin;
@property (weak, nonatomic) IBOutlet UIView *view_shouYi;

@property (nonatomic, strong) LBOrderModel *orderModel;


@property (nonatomic, strong) NSString *yuJiShouYi; // 预计收益
@property (nonatomic, strong) NSString *yuJiHuanKuan; // 预计还款
@property (nonatomic, strong) NSString *gouMaiJinE; // 购买金额
@property (nonatomic, strong) NSString *nianHuaShouYi; // 年化收益

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *huanKuanTime; // 还款日期
@property (nonatomic, strong) NSString *chengJiaoTime; // 成交时间
@property (nonatomic, strong) NSString *statusString;

@end
