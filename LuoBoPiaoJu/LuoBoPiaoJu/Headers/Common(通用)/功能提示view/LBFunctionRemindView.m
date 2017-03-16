//
//  LBFunctionRemindView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFunctionRemindView.h"

@implementation LBFunctionRemindView

+ (void)showWithImageName:(NSString *)imageName
{
    LBFunctionRemindView *funView = [[LBFunctionRemindView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [kWindow addSubview:funView];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:funView.bounds];
    [funView addSubview:imageV];
    
    if (kIPHONE_5s) {
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_5", imageName]];
    } else if (kIPHONE_6s) {
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_6", imageName]];
    } else if (kIPHONE_6P) {
        imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_6p", imageName]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
