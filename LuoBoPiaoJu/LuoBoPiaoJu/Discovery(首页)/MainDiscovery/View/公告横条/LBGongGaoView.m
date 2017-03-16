//
//  LBGongGaoView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  没用

#import "LBGongGaoView.h"

@implementation LBGongGaoView

- (instancetype)initWithFrame:(CGRect)frame
                  buttonBlock:(LBButtonBlock)buttonBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        button.frame = self.bounds;
        [self addSubview:button];
        
        //
        CGFloat x_image = 17;
        CGFloat hw_image = 12;
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(x_image, (frame.size.height - hw_image) / 2, hw_image, hw_image)];
        _imageV.backgroundColor = [UIColor grayColor];
        [self addSubview:_imageV];
        
        //
        CGFloat x_label = _imageV.right + 12;
        CGFloat y_label = _imageV.top;
        CGFloat w_label = kScreenWidth - x_label - x_image;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x_label, y_label, w_label, hw_image)];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.text = @"公告";
        [self addSubview:_titleLabel];
        
        _buttonBlock = buttonBlock;
    }
    return self;
}

- (void)clickButton
{
    if (_buttonBlock) {
        _buttonBlock();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
