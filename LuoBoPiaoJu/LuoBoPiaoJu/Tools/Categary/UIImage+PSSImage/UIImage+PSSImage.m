//
//  UIImage+PSSImage.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "UIImage+PSSImage.h"

@implementation UIImage (PSSImage)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
