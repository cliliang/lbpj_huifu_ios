//
//  LBGongGaoView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  没用

#import <UIKit/UIKit.h>

typedef void(^LBButtonBlock)(void);

@interface LBGongGaoView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                  buttonBlock:(LBButtonBlock)buttonBlock;

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) LBButtonBlock buttonBlock;
- (void)setButtonBlock:(LBButtonBlock)buttonBlock;

@end
