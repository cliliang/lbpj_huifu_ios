//
//  LBLiJiRulerCVCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/28.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellId @"LBLiJiRulerCVCell"

// 每条线相隔20, 长的20, 短的15, item宽度100
@interface LBLiJiRulerCVCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label_num1;
@property (nonatomic, strong) UILabel *label_num2;

@end
