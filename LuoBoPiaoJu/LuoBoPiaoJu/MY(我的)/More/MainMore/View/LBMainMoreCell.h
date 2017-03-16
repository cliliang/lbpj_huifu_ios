//
//  LBMainMoreCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/3.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCell @"LBMainMoreCell"

@interface LBMainMoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *imageV_ass;
@property (weak, nonatomic) IBOutlet UILabel *label_banbenInfo;

@end
