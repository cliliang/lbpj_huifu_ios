//
//  UIColor+RGBValue.h
//  PSSTest
//
//  Created by 庞仕山 on 16/4/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGBValue)

+ (UIColor *)colorWithRGBString:(NSString *)rgbColorString withAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithRGBString:(NSString *)rgbColorString;

@end
