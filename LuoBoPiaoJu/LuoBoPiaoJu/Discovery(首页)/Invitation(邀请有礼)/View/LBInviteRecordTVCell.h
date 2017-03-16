//
//  LBInviteRecordTVCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/10.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBInvitedRecordModel.h"

#define kCellID @"LBInviteRecordTVCell"

@interface LBInviteRecordTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_user;

@property (weak, nonatomic) IBOutlet UILabel *label_jiangLiMoney;
@property (weak, nonatomic) IBOutlet UILabel *label_time;

@property (nonatomic, strong) LBInvitedRecordModel *model;

@end
