//
//  LBAccountSecurityCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  账户安全cell

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LBLinePositionBottom,
    LBLinePositionTop,
} LBLinePosition;

@interface LBAccountSecurityCell : UITableViewCell

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *label_title;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *label_info; // 是否认证等
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *img_sign; // 图标

@property (nonatomic, assign) LBLinePosition linePosition;
@property (nonatomic, strong) UIView *lineView;

@end
