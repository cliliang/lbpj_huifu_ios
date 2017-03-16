//
//  LBLiJiFirstView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  投资金额, 预计收益, 横条封装

#import "LBLiJiFirstView.h"

@interface LBLiJiFirstView ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_yuJiShouYiTitle;


@end

@implementation LBLiJiFirstView

+ (instancetype)createNibView
{
    LBLiJiFirstView *firstV = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBLiJiFirstView class]) owner:nil options:nil] firstObject];
    return firstV;
}

//+ (instancetype)createTheView
//{
//    LBLiJiFirstView *theView = [LBLiJiFirstView]
//    
//    // 投资金额label
//    UILabel *label1 = [UILabel new];
//    [self formmattingLabel:label1 highLight:YES];
//    
//    
//    
//    
//    
//    return nil;
//}

+ (void)formmattingLabel:(UILabel *)label highLight:(BOOL)highLight
{
    label.textColor = highLight ? kNavBarColor : kDeepColor;
    label.font = [UIFont pingfangWithFloat:15 weight:UIFontWeightLight];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    CGFloat fontSize = 13;
    if (kIPHONE_5s) {
        self.right_yuJiShouYiTitle.constant = 100;
        fontSize = 12;
    } else {
        self.right_yuJiShouYiTitle.constant = 110;
    }
    
    self.label_touzijine.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    self.label_touzijinE_title.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    self.label_yujishouyi.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    self.label_yujishouyi_title.font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
    // 开始是 80
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
