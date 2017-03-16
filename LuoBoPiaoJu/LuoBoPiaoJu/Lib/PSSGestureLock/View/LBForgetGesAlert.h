//
//  LBForgetGesAlert.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/7/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBClickYesBlock)(NSString * password);

@interface LBForgetGesAlert : UIView

@property (nonatomic, copy) LBClickYesBlock yesBlock;
- (void)setYesBlock:(LBClickYesBlock)yesBlock;

+ (void)showWithYesBlock:(LBClickYesBlock)yesBlock;

@end
