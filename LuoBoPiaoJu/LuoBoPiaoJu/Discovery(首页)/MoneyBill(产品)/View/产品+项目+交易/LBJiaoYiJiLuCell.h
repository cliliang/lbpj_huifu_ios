//
//  LBJiaoYiJiLuCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellHeight 40
#define kCell @"LBJiaoYiJiLuCell"

@interface LBJiaoYiJiLuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_dingdanbianhaoNum;
@property (weak, nonatomic) IBOutlet UILabel *label_money;
@property (weak, nonatomic) IBOutlet UILabel *label_xiadanTime;

@property (nonatomic, strong) LBOrderModel *model;

@end







