//
//  LBCalcDetailItem.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCalcDetailItem.h"

#define kTheColor [UIColor colorWithWhite:0.192 alpha:1.000]

@implementation LBCalcDetailItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILongPressGestureRecognizer *longPre = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressLong:)];
        longPre.minimumPressDuration = 0.0;
        [self addGestureRecognizer:longPre];
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageV = imageV;
        imageV.layer.cornerRadius = 4;
        [self addSubview:imageV];
//        imageV.backgroundColor = kTheColor;
        
//        imageV.image = [UIImage imageNamed:@"bg_calculatorItem_nor"];
//        self.normalImage = [UIImage imageNamed:@"bg_calculatorItem_nor"];
//        self.highLightImage = [UIImage imageNamed:@"bg_calculatorItem_sel"];
//        imageV.layer.shadowColor = [UIColor blackColor].CGColor;
//        imageV.layer.shadowRadius = 4;
//        imageV.layer.shadowOffset = CGSizeMake(0, 2);
//        imageV.layer.shadowOpacity = 1;
//        imageV.layer.shadowRadius = 4;
        self.normalImage = [UIImage imageNamed:@"bg_calcDetail_itemNor"];
        self.highLightImage = [UIImage imageNamed:@"bg_calcDetail_itemSele"];
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:label];
        label.textColor = kDeepColor;
        label.text = @"";
        label.font = [UIFont systemFontOfSize:24];
        label.textAlignment = NSTextAlignmentCenter;
        _label = label;
    }
    return self;
}

- (void)pressLong:(UILongPressGestureRecognizer *)longPre
{
    if (longPre.state == UIGestureRecognizerStateBegan) {
        _imageV.image = self.highLightImage;
//        _imageV.backgroundColor = [kTheColor colorWithAlphaComponent:0.7];
    }
    if (longPre.state == UIGestureRecognizerStateEnded) {
        _imageV.image = self.normalImage;
//        _imageV.backgroundColor = kTheColor;
        if (self.detailBlock) {
            self.detailBlock(self.title);
        }
    }
}

- (void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
    _imageV.image = normalImage;
}
- (void)setHighLightImage:(UIImage *)highLightImage
{
    _highLightImage = highLightImage;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _label.text = title;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    _label.font = font;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
