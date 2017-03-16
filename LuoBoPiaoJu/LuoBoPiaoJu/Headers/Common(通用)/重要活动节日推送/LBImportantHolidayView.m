//
//  LBImportantHolidayView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBImportantHolidayView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LBImportantHolidayView

+ (instancetype)showWithImgUrl:(NSString *)imgUrl success:(LBSuccessVoidBlock)success
{
    LBImportantHolidayView *theView = [LBImportantHolidayView new];
    theView.successBlock = success;
    theView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [kWindow addSubview:theView];
    [theView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(kWindow);
    }];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [theView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(theView);
        make.width.mas_equalTo(KAutoWDiv2(500));
        make.height.mas_equalTo(KAutoWDiv2(634));
    }];
    imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *succTap = [[UITapGestureRecognizer alloc] initWithTarget:theView action:@selector(successGo)];
    [imageV addGestureRecognizer:succTap];
    [imageV sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    
    UIImageView *cancelImg = [[UIImageView alloc] init];
    [theView addSubview:cancelImg];
    [cancelImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).offset(15);
        make.centerX.mas_equalTo(theView);
        make.width.mas_equalTo(KAutoWDiv2(70));
        make.height.mas_equalTo(KAutoWDiv2(70));
    }];
    cancelImg.image = [UIImage imageNamed:@"icon_yaoqingyouli_quxiao"];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:theView action:@selector(removeThisView)];
    [cancelImg addGestureRecognizer:tapGes];
    cancelImg.userInteractionEnabled = YES;
    return theView;
}

- (void)removeThisView
{
    [self removeFromSuperview];
}
- (void)successGo
{
    if (self.successBlock) {
        self.successBlock();
    }
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
