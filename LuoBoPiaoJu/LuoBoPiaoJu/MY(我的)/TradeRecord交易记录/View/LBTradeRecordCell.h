//
//  LBTradeRecordCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBTradeRecordModel.h"

@interface LBTradeRecordCell : UITableViewCell

@property (nonatomic, strong) LBTradeRecordModel *model;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
