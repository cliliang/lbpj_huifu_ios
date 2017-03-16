//
//  LBTabbar.m
//  BaLuoBoLiCai
//
//  Created by 庞仕山 on 16/5/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBTabbar.h"

@implementation LBTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar"]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        
        if ([view isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
            for (UIView *imgV in view.subviews) {
                if ([imgV isKindOfClass:[UIImageView class]] && imgV.bounds.size.height <= 1) {
                    imgV.backgroundColor = kLineColor;
                }
            }
        }
//        int i = 1;
//        NSDictionary *colorDic = @{
//                                   @"1":[UIColor blackColor],
//                                   @"2":[UIColor yellowColor],
//                                   @"3":[UIColor greenColor],
//                                   @"4":[UIColor blueColor],
//                                   };
//        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            view.backgroundColor = colorDic[[NSString stringWithFormat:@"%d", i]];
//            i++;
//        }
    }
}

+ (void)initialize
{
    [super initialize];
    UITabBarItem *appearance = [UITabBarItem appearance];
    // 富文本设置文本大小和颜色
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRGBString:@"7a7a83"], NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:kNavBarColor, NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
