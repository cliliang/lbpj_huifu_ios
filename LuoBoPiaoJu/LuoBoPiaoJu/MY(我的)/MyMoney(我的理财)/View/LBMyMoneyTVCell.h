//
//  LBMyMoneyTVCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCell @"LBMyMoneyTVCell"
#define kCellHeight (68 + 1 + 10 + 35 + 22 + 29 + 26*2) * 1.0 / 2



#define kLabelTop 15
#define kChangeH (kLabelTop + 13)

@interface LBMyMoneyTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_color;
@property (weak, nonatomic) IBOutlet UILabel *label_title;

@property (nonatomic, strong) UILabel *label_benJin;
@property (nonatomic, strong) UILabel *label_benJinMoney;

@property (nonatomic, strong) UILabel *label_daiShouBenXi;
@property (nonatomic, strong) UILabel *label_daiShouBenJinMoney;


@property (weak, nonatomic) IBOutlet UIView *view_bg;

@property (nonatomic, strong) LBOrderModel *model;

@end
