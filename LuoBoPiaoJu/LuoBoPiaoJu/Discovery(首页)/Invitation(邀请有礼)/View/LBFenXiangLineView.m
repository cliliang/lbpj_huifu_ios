//
//  LBFenXiangLineView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/22.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFenXiangLineView.h"
#import <UIKit/UIKit.h>

@interface LBFenXiangLineView ()

@property (nonatomic, strong) UIView  *backView;

@end

@implementation LBFenXiangLineView

+ (instancetype)creatInView:(UIView *)view height:(CGFloat)height
{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
    
    LBFenXiangLineView *fenxingView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBFenXiangLineView class]) owner:nil options:nil] firstObject];
    fenxingView.backView = backView;
    [backView addSubview:fenxingView];
    [fenxingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(backView);
        make.height.mas_equalTo(height);
    }];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:fenxingView action:@selector(tapToRemove)];
    [backView addGestureRecognizer:tapGes];
    
    return fenxingView;
}

- (void)tapToRemove
{
    [self removeFromSuperview];
    [_backView removeFromSuperview];
}

- (IBAction)btn_clickLeft:(id)sender {
    if (self.clickLeftBlock) {
        self.clickLeftBlock();
    }
    [self removeFromSuperview];
    [_backView removeFromSuperview];
}
- (IBAction)btn_clickRight:(id)sender {
    if (self.clickRightBlock) {
        self.clickRightBlock();
    }
    [self removeFromSuperview];
    [_backView removeFromSuperview];
}


@end






