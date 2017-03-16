//
//  LBShuHuiCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCell @"LBShuHuiCell"
#define kCellHeight 105

@interface LBShuHuiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_leijishouyiNum;
@property (weak, nonatomic) IBOutlet UILabel *label_chicangbenjin;
@property (weak, nonatomic) IBOutlet UIButton *btn_shuhui;

@property (nonatomic, strong) LBOrderModel *model;

@end
