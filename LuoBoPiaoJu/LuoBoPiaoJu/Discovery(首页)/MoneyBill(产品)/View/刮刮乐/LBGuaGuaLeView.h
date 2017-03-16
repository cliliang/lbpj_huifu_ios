//
//  LBGuaGuaLeView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYScratchCardView.h"

@class HYScratchCardView;
@interface LBGuaGuaLeView : UIView

@property (nonatomic, strong) HYScratchCardView *guagualeV;

+ (instancetype)showWithtitle:(NSString *)title content:(NSString *)content;

@end
