//
//  LBMyMoneyCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBMyMoneyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *view_Color;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_retio;
@property (weak, nonatomic) IBOutlet UILabel *label_money;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_centerNum;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_money;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_imageV;

@end
