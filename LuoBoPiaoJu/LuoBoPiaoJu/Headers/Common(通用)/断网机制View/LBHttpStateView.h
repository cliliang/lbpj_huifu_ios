//
//  LBHttpStateView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/7.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBButtonBlock)(void);

@interface LBHttpStateView : UIView

//@property (nonatomic, copy) LBButtonBlock buttonBlock;
//- (void)setButtonBlock:(LBButtonBlock)buttonBlock;

+ (LBHttpStateView *)httpStatusWithView:(UIView *)view
              refreshBlock:(LBButtonBlock)refreshBlock;
    

@end
