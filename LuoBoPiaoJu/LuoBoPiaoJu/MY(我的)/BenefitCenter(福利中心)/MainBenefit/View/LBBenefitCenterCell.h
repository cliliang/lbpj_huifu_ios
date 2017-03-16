//
//  LBBenefitCenterCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBenefitModel.h"
#import "LBBebefitRecordModel.h"

@interface LBBenefitCenterCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageV1;
@property (nonatomic, strong) UIImageView *imageV2;

@property (nonatomic, strong) LBBenefitModel *benefitModel;
@property (nonatomic, strong) LBBebefitRecordModel *benefitRecModel;

@property (nonatomic, assign) BOOL space; // 是否有分界线

@end
