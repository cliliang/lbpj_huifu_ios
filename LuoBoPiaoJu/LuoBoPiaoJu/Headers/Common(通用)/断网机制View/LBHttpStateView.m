//
//  LBHttpStateView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/7.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBHttpStateView.h"

@implementation LBHttpStateView

+ (LBHttpStateView *)httpStatusWithView:(UIView *)view
              refreshBlock:(LBButtonBlock)refreshBlock
{
    
    LBHttpStateView *stateView = [[LBHttpStateView alloc] init];
    stateView.backgroundColor = kBackgroundColor;
//    stateView.buttonBlock = refreshBlock;
    __block BOOL networkComing = YES;
    [HTTPTools AFNetworkStatusReachable:^{
        [stateView removeFromSuperview];
        [LBTimeHeart shareTime].networking = YES;
        if (networkComing == NO) {
            if (refreshBlock) {
                refreshBlock();
            }
        }        
    } notReachable:^{
        [LBTimeHeart shareTime].networking = NO;
        networkComing = NO;
        [view addSubview:stateView];
        [stateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(view);
        }];
        
        // 图片
        UIImageView *imageView = [[UIImageView alloc] init];
        [stateView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(div_2(312));
            make.centerX.mas_equalTo(stateView);
        }];
        imageView.image = [UIImage imageNamed:@"image_noInternet"];
        
        // 网络不给力
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:24];
        label.textColor = kLightColor;
        [stateView addSubview:label];
        label.text = @"网络不给力";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView.mas_bottom).offset(div_2(68));
            make.centerX.mas_equalTo(stateView);
            make.height.mas_equalTo(24);
        }];
        
        // 重新加载
        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom normalColor:kLightColor highColor:kLightColor target:stateView action:@selector(clickRefreshButton) forControlEvents:UIControlEventTouchUpInside title:@"重新加载"];
        refreshBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [stateView addSubview:refreshBtn];
        refreshBtn.layer.cornerRadius = 4;
        refreshBtn.layer.borderWidth = 0.5;
        refreshBtn.layer.borderColor = kLightColor.CGColor;
        [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label.mas_bottom).offset(div_2(45));
            make.centerX.mas_equalTo(stateView);
            make.width.mas_equalTo(div_2(339));
            make.height.mas_equalTo(div_2(70));
        }];
        
        [view bringSubviewToFront:stateView];
    }];
    return stateView;
}

- (void)clickRefreshButton
{
//    if (self.buttonBlock) {
//        self.buttonBlock();
//    }
//    [self removeFromSuperview];
    [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:kWindow animated:YES];
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
