//
//  LBUpwarpBankCardAlert.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/7.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBButtonBlock)(void);

@interface LBUpwarpBankCardAlert : UIView

@property (nonatomic, copy) LBButtonBlock sureBlock;
@property (nonatomic, copy) LBButtonBlock quitBlock;
- (void)setSureBlock:(LBButtonBlock)sureBlock;
- (void)setQuitBlock:(LBButtonBlock)quitBlock;

+ (void)showAlertWithSure:(LBButtonBlock)sure
                     quit:(LBButtonBlock)quit
             huifuAccount:(NSString *)huifuAccount;

@end
