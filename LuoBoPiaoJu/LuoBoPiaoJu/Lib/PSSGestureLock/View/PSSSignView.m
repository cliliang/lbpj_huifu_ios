//
//  PSSSignView.m
//  PSSGestureLock
//
//  Created by 庞仕山 on 16/7/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSSignView.h"

@implementation PSSSignView

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (int i = 0; i < 9; i++) {
            UIImageView *imageV = [[UIImageView alloc] init];
            [self addSubview:imageV];
            imageV.image = [UIImage imageNamed:@"gesture_sign_normal"];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 8;
    CGFloat h = w;
    CGFloat margin = (self.width - 3 * w) / 2;
    for (int i = 0; i < 9; i++) {
        x = 0 + (i % 3) * (w + margin);
        y = 0 + (i / 3) * (h + margin);
        UIImageView *imageView = (UIImageView *)self.subviews[i];
        imageView.frame = CGRectMake(x, y, w, h);
    }
}

- (void)showWithString:(NSString *)string
{
    for (UIImageView *imageV in self.subviews) {
        imageV.image = [UIImage imageNamed:@"gesture_sign_normal"];
    }
    if (string == nil || string.length == 0) {
        return;
    }
    for (int i = 0; i < string.length; i++) {
        NSString *numStr = [string substringWithRange:NSMakeRange(i, 1)];
        if (![@"123456789" containsString:numStr]) {
            return;
        }
        int index = [numStr intValue] - 1;
        UIImageView *imageV = (UIImageView *)self.subviews[index];
        imageV.image = [UIImage imageNamed:@"gesture_sign_selected"];
    }
}

@end








