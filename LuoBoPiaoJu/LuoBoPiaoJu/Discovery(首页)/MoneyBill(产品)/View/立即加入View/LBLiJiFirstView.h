//
//  LBLiJiFirstView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  投资金额, 预计收益, 横条封装

#import <UIKit/UIKit.h>

@interface LBLiJiFirstView : UIView

@property (weak, nonatomic) IBOutlet UILabel *label_touzijine;
@property (weak, nonatomic) IBOutlet UILabel *label_yujishouyi;
@property (weak, nonatomic) IBOutlet UILabel *label_touzijinE_title;
@property (weak, nonatomic) IBOutlet UILabel *label_yujishouyi_title;

+ (instancetype)createNibView;

@end
