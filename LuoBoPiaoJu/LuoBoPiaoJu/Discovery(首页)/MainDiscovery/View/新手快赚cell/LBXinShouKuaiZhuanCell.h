//
//  LBXinShouKuaiZhuanCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSSCircleProgressView.h"

#define kCell @"XinShouKuaiZhuanCell"
#define kCellHright 260.0 / 2

#define kCellHeight_6P 260.0 / 2

@interface LBXinShouKuaiZhuanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_nianHuaShouYe;
@property (nonatomic, strong) UILabel *label_time;
//@property (weak, nonatomic) IBOutlet UIImageView *img_1;
//@property (weak, nonatomic) IBOutlet UIImageView *img_2;
@property (weak, nonatomic) IBOutlet UILabel *label_bankCardName;
/**
 *  销售进度label
 */
//@property (weak, nonatomic) IBOutlet UILabel *label_centerNumber;
@property (nonatomic, strong) UILabel *label_centerNumber; // 剩余百分比 & 剩余钱数 & 圆圈中间的数字
@property (nonatomic, strong) UILabel *label_shengYu; // -剩余(元)
@property (nonatomic, strong) UILabel *label_qiangGuang; // 抢光

@property (nonatomic, strong) LBGoodsModel *goodModel;

- (void)animationWithTime:(CGFloat)time;

- (NSString *)stringWithTimeCount:(NSInteger)timeCount;


@end
