//
//  LBYesOrNoAlert.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBButtonBlock)(void);

@interface LBYesOrNoAlert : UIView

@property (nonatomic, copy) LBButtonBlock sureButtonBlock;
@property (nonatomic, copy) LBButtonBlock noButtonBlock;

+ (instancetype)alertWithMessage:(NSString *)message
                       sureBlock:(LBButtonBlock)sureBlock;

- (void)show;

- (void)setSureButtonBlock:(LBButtonBlock)sureButtonBlock;
- (void)setNoButtonBlock:(LBButtonBlock)noButtonBlock;

@end
