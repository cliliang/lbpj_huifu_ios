//
//  LBSignInNewView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBSignInNewView.h"

@implementation LBSignInNewView

+ (void)showWithMessage:(NSString *)message
{
    LBSignInNewView *signView = [[LBSignInNewView alloc] init];
    [kWindow addSubview:signView];
    [signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(kWindow);
    }];
    signView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    
    // 背景
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    [signView addSubview:view1];
    [view1 becomeCircleWithR:4];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(signView);
        make.width.mas_equalTo(KAutoWDiv2(534));
        make.height.mas_equalTo(KAutoWDiv2(308));
    }];
    
    // 已签到
    UILabel *label1 = [UILabel new];
    [label1 setText:@"已签到" textColor:[UIColor colorWithRGBString:@"ffca2a"] font:kPingFangFont(KAutoWDiv2(40))];
    [view1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view1).offset(KAutoWDiv2(22));
        make.centerX.mas_equalTo(view1);
        make.height.mas_equalTo(KAutoWDiv2(40));
    }];
    
    // image
    UIImageView *imageV = [UIImageView new];
    imageV.image = [UIImage imageNamed:@"icon_qiandao"];
    [view1 addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(KAutoWDiv2(18));
        make.centerX.mas_equalTo(view1);
        make.width.mas_equalTo(KAutoWDiv2(212));
        make.height.mas_equalTo(KAutoWDiv2(131));
    }];
    
    // 积分+10
    UILabel *label2 = [[UILabel alloc] init];
    [label2 setText:[NSString stringWithFormat:@"%@%@", @"积分+", message] textColor:kNavBarColor font:kPingFangFont(KAutoWDiv2(30))];
    [view1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).offset(KAutoWDiv2(11));
        make.centerX.mas_equalTo(view1);
        make.height.mas_equalTo(KAutoWDiv2(30));
    }];
    
    // 每日签到送10积分
    UILabel *label3 = [UILabel new];
    [label3 setText:[NSString stringWithFormat:@"每日签到送%@积分", message] textColor:kLightColor font:kPingFangFont(KAutoWDiv2(22))];
    [view1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view1.mas_bottom).offset(-KAutoWDiv2(22));
        make.centerX.mas_equalTo(view1);
        make.height.mas_equalTo(KAutoWDiv2(22));
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (signView) {
            [signView removeFromSuperview];
        }
    });
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
