//
//  LBYanZhengMaView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ButtonBlock)(void);
@interface LBYanZhengMaView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) ButtonBlock buttonBlock;
- (void)setButtonBlock:(ButtonBlock)buttonBlock;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeH:(NSString *)placeH;

@end
