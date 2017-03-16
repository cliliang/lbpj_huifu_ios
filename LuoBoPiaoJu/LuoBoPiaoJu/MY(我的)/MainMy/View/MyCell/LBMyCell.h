//
//  LBMyCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBMyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *topLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UIImageView *imageV_ass;

@property (nonatomic, strong) UIView *messSignV; // 小红点
@property (nonatomic, strong) UILabel *messLabel; // 条数
@property (nonatomic, assign) NSInteger redCount; // 条数设置

@end
