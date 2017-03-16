//
//  LBLiJiThirdView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  买入金额, 金额全选, view封装

#import "LBLiJiThirdView.h"

@interface LBLiJiThirdView () <UITextFieldDelegate>

@end

@implementation LBLiJiThirdView

+ (instancetype)createNibView
{
    LBLiJiThirdView *thirdV = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBLiJiThirdView class]) owner:nil options:nil] firstObject];
    thirdV.tf_mairujine.delegate = thirdV;
    thirdV.tf_mairujine.keyboardType = UIKeyboardTypeNumberPad;
    return thirdV;
}

// 点击金额全选
- (IBAction)clickJinEQuanXuanBtn:(id)sender {
    if (self.buttonBlock) {
        self.buttonBlock();
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (self.textFieldBlock) {
        NSString *text = textField.text;
        if (string.length == 0 || string == nil) {
            if (text.length == 0) {
                return YES;
            }
            NSString *numString = [text substringToIndex:text.length - 1];
            if (numString.length == 0 || numString == nil) {
                self.textFieldBlock(@"0");
            } else {
                self.textFieldBlock(numString);
            }
        } else {
            NSString *numString = [NSString stringWithFormat:@"%@%@", text, string];
            CGFloat floatN = [numString floatValue];
            if (floatN >= self.allMoney) {
                self.textFieldBlock([NSString stringWithFormat:@"%d", (int)self.allMoney]);
                textField.text = [NSString stringWithFormat:@"%d", (int)self.allMoney];
                return NO;
            } else {
                self.textFieldBlock(numString);
            }
            
        }
    }
    return YES;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
