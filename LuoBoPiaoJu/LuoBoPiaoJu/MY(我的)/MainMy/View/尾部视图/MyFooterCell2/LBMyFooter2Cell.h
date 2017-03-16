//
//  LBMyFooter2Cell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/30.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCell2Height (47 + 65)
#define kCell2_ID @"cell2_id"

@interface LBMyFooter2Cell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, assign) BOOL havingLine;
@property (nonatomic, assign) BOOL bottomLine;

@end
