//
//  LBLiJiThirdView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  买入金额, 金额全选, view封装

#import <UIKit/UIKit.h>

typedef void(^LBButtonBlock)(void);
typedef void(^LBTextFieldBlock)(NSString *numString);

@interface LBLiJiThirdView : UIView

@property (weak, nonatomic) IBOutlet UITextField *tf_mairujine; // 买入金额数值
@property (weak, nonatomic) IBOutlet UIButton *btn_jinEquanxuan; // 金额全选button

@property (nonatomic, assign) CGFloat allMoney;

@property (nonatomic, copy) LBButtonBlock buttonBlock;
- (void)setButtonBlock:(LBButtonBlock)buttonBlock;

@property (nonatomic, copy) LBTextFieldBlock textFieldBlock;
- (void)setTextFieldBlock:(LBTextFieldBlock)textFieldBlock;

+ (instancetype)createNibView;

@end
