//
//  LBFaXianTVCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBFaXianNewsModel.h"

#define kCell @"LBFaXianTVCell"

@interface LBFaXianTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_data;
@property (weak, nonatomic) IBOutlet UILabel *label_content;

@property (nonatomic, strong) LBFaXianNewsModel *model;

@end
