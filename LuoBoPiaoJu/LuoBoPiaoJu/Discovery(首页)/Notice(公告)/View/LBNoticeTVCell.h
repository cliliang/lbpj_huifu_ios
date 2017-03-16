//
//  LBNoticeTVCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBGongGaoModel.h"

#define kCell @"LBNoticeTVCell"
#define kCellHeight 100

@interface LBNoticeTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (nonatomic, strong) LBGongGaoModel *model;

@end
