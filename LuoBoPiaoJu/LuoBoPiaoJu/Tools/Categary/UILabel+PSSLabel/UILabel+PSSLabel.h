//
//  UILabel+PSSLabel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (PSSLabel)

- (void)changeTextColor:(UIColor *)color range:(NSRange)range;
- (void)changeTextColor:(UIColor *)color footLength:(CGFloat)footLength;
- (void)changeLineDistance:(CGFloat)line;
- (void)changeFont:(UIFont *)font;

- (void)setText:(NSString *)text
      textColor:(UIColor *)textColor
           font:(UIFont *)font;

- (void)appendingStr:(NSString *)str; // 拼接一个字符串
- (void)deleteLastOneString; // 删除一个字符
- (void)deleteAllText; // 置@""
- (void)pingFangFont:(CGFloat)fontSize; // 苹方字体

- (void)hongBaoMiaoShuTitle; // 红包描述-标题格式
- (void)hongBaoMiaoShuTitleWithNum:(NSInteger)num; // 红包描述-标题格式-标题字数
- (void)hongBaoMiaoShuText; // 红包描述-正文格式

- (void)fuLiZhongXinDescription; // 福利中心描述样式

@end
