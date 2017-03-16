//
//  LBBankCardManagerVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"

@interface LBBankCardManagerVC : LBViewController

@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_yinHangKa;

@property (weak, nonatomic) IBOutlet UIButton *btn_jieBang;
@property (weak, nonatomic) IBOutlet UIButton *btn_cardTitle;

@property (nonatomic, assign) BOOL isHaveCard;

@end
