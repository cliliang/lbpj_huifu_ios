//
//  UILabel+PSSLabel.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "UILabel+PSSLabel.h"

@implementation UILabel (PSSLabel)

- (void)changeTextColor:(UIColor *)color range:(NSRange)range
{
    NSString *str = self.text;
    if (range.length + range.location < str.length + 1) {
        NSMutableAttributedString *attrStr = [self.attributedText mutableCopy];
        if (self.attributedText == nil) {
            attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        }
        [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        self.attributedText = attrStr;
    }
}
- (void)changeTextColor:(UIColor *)color footLength:(CGFloat)footLength
{
    NSString *str = self.text;
    [self changeTextColor:color range:NSMakeRange(str.length - footLength, footLength)];
}
- (void)changeFont:(UIFont *)font
{
    NSString *str = self.text;
    if (str == nil) {
        return;
    }
    NSMutableAttributedString *attrStr = [self.attributedText mutableCopy];
    if (self.attributedText == nil) {
        attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    }
    [attrStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    self.attributedText = attrStr;
}
- (void)changeLineDistance:(CGFloat)line
{
    NSString *str = self.text;
    if (str == nil) {
        return;
    }
    NSMutableAttributedString *attrStr = [self.attributedText mutableCopy];
    if (self.attributedText == nil) {
        attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:line];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, str.length)];
    self.attributedText = attrStr;
}

- (void)setText:(NSString *)text
      textColor:(UIColor *)textColor
           font:(UIFont *)font
{
    self.text = text;
    self.textColor = textColor;
    self.font = font;
}

- (void)appendingStr:(NSString *)str
{
    NSString *labelText = self.text ? self.text : @"";
    
    if (![str isEqualToString:@"."] && [labelText isEqualToString:@"0"]) {
        return;
    }
    if ([str isEqualToString:@"."] && [labelText containsString:@"."]) {
        return;
    }
    if ([str isEqualToString:@"."] && labelText.length == 0) {
        self.text = @"0.";
        return;
    }
    NSString *resultS = [labelText stringByAppendingString:str];
    self.text = resultS;
}
- (void)deleteLastOneString
{
    NSString *labelText = self.text ? self.text : @"";
    if (labelText.length > 1) {
        NSString *resultS = [labelText substringToIndex:labelText.length - 1];
        self.text = resultS;
    } else {
        self.text = @"";
    }
}
- (void)deleteAllText
{
    self.text = @"";
}
- (void)pingFangFont:(CGFloat)fontSize
{
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    if (font == nil) {
//        font = [UIFont systemFontOfSize:fontSize weight:UIFontWeightLight];
        font = [UIFont systemFontOfSize:fontSize];
    }
    self.font = font;
}

- (void)hongBaoMiaoShuTitle // 红包描述-标题格式
{
    self.numberOfLines = 0;
    NSString *labelStr = self.text;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:labelStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kDeepColor range:NSMakeRange(0, 6)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kLightColor range:NSMakeRange(6, labelStr.length - 6)];
    NSMutableParagraphStyle *paraSty = [[NSMutableParagraphStyle alloc] init];
    [paraSty setLineSpacing:7];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paraSty range:NSMakeRange(0, labelStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, labelStr.length)];
    self.attributedText = attrStr;
}
- (void)hongBaoMiaoShuTitleWithNum:(NSInteger)num // 红包描述-标题格式-标题字数
{
    self.numberOfLines = 0;
    NSString *labelStr = self.text;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:labelStr];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kDeepColor range:NSMakeRange(0, num)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kLightColor range:NSMakeRange(num, labelStr.length - num)];
    NSMutableParagraphStyle *paraSty = [[NSMutableParagraphStyle alloc] init];
    [paraSty setLineSpacing:7];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paraSty range:NSMakeRange(0, labelStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, labelStr.length)];
    self.attributedText = attrStr;
}

- (void)hongBaoMiaoShuText // 红包描述-正文格式
{
    self.numberOfLines = 0;
    NSString *labelStr = self.text;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:labelStr];
    NSMutableParagraphStyle *paraSty = [[NSMutableParagraphStyle alloc] init];
    [paraSty setLineSpacing:10];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paraSty range:NSMakeRange(0, labelStr.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kLightColor range:NSMakeRange(0, labelStr.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, labelStr.length)];
    self.attributedText = attrStr;
}
- (void)fuLiZhongXinDescription // 福利中心描述样式
{
    [self changeLineDistance:10];
    [self changeTextColor:kNavBarColor footLength:15];
}


@end
