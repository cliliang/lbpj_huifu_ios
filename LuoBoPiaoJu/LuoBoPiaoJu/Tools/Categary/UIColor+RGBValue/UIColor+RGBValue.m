//
//  UIColor+RGBValue.m
//  PSSTest
//
//  Created by 庞仕山 on 16/4/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "UIColor+RGBValue.h"

@implementation UIColor (RGBValue)

+ (UIColor *)colorWithRGBString:(NSString *)rgbColorString withAlpha:(CGFloat)alpha
{
    if (rgbColorString.length < 6) {
        return nil;
    }
    unsigned long red = strtoul([[rgbColorString substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16);
    unsigned long green = strtoul([[rgbColorString substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16);
    unsigned long blue = strtoul([[rgbColorString substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16);
    
    return [UIColor colorWithRed:red / 256.0 green:green / 256.0 blue:blue / 256.0 alpha:alpha];
}

+ (UIColor *)colorWithRGBString:(NSString *)rgbColorString
{
    if (rgbColorString.length < 6) {
        return nil;
    }
    unsigned long red = strtoul([[rgbColorString substringWithRange:NSMakeRange(0, 2)] UTF8String], 0, 16);
    unsigned long green = strtoul([[rgbColorString substringWithRange:NSMakeRange(2, 2)] UTF8String], 0, 16);
    unsigned long blue = strtoul([[rgbColorString substringWithRange:NSMakeRange(4, 2)] UTF8String], 0, 16);
    
    return [UIColor colorWithRed:red / 256.0 green:green / 256.0 blue:blue / 256.0 alpha:1];
}

@end
