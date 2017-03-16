//
//  LBCalcDetailItem.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBClickDetailItemBlock)(NSString *str);

@interface LBCalcDetailItem : UIView

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *highLightImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIFont *font;

@property (nonatomic, copy) LBClickDetailItemBlock detailBlock;
- (void)setDetailBlock:(LBClickDetailItemBlock)detailBlock;

@end
