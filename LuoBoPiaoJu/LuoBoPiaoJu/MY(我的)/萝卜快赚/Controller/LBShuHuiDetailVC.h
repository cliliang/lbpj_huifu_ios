//
//  LBShuHuiDetailVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"

@interface LBShuHuiDetailVC : LBViewController

@property (weak, nonatomic) IBOutlet UILabel *label_shuhuijinENum;
@property (weak, nonatomic) IBOutlet UILabel *label_daozhangTime;
@property (weak, nonatomic) IBOutlet UIButton *btn_fanhui;
@property (weak, nonatomic) IBOutlet UIButton *btn_Jixu;

@property (nonatomic, strong) LBOrderModel *orderModel;

@end
