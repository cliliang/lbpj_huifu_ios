//
//  UIFont+PSSFont.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "UIFont+PSSFont.h"

@implementation UIFont (PSSFont)

+ (UIFont *)pingfangWithFloat:(CGFloat)fontSize weight:(CGFloat)weight
{
    NSString *fontName = weight == UIFontWeightLight ? @"PingFangSC-Light" : @"PingFangSC-Regular";
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (font == nil) {
        font = [UIFont systemFontOfSize:fontSize weight:weight];
    }
    return font;
}

@end
