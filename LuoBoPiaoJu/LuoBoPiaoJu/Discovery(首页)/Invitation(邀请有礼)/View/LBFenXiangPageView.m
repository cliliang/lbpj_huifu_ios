//
//  LBFenXiangPageView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/2.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFenXiangPageView.h"
#import "LBFenXiangLineView.h"
#import <UMSocial.h>
@interface LBFenXiangPageView () <UMSocialUIDelegate>

@end

@implementation LBFenXiangPageView

+ (void)shareUrl:(NSString *)url title:(NSString *)title content:(NSString *)content
{
    LBFenXiangPageView *theView = [LBFenXiangPageView new];
    theView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [kWindow addSubview:theView];
    [theView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(kWindow);
    }];
    
    LBFenXiangLineView *lineView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBFenXiangLineView class]) owner:nil options:nil] firstObject];
    [theView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(theView);
        make.height.mas_equalTo(div_2(38 + 120 + 37 + 30 + 27));
    }];
    
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    [UMSocialData defaultData].extConfig.title = title;
    
    [lineView setClickLeftBlock:^{
        [theView removeFromSuperview];
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:content image:[UIImage imageNamed:@"iocn_share"] location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
            
        }];
    }];
    [lineView setClickRightBlock:^{
        [theView removeFromSuperview];
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:[UIImage imageNamed:@"iocn_share"] location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
            
        }];
    }];
}

+ (void)shareText:(NSString *)text
{
    LBFenXiangPageView *theView = [LBFenXiangPageView new];
    theView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [kWindow addSubview:theView];
    [theView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(kWindow);
    }];
    
    LBFenXiangLineView *lineView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBFenXiangLineView class]) owner:nil options:nil] firstObject];
    [theView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(theView);
        make.height.mas_equalTo(div_2(38 + 120 + 37 + 30 + 27));
    }];
    
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = nil;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = nil;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeText;
    
    [lineView setClickLeftBlock:^{
        [theView removeFromSuperview];
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:text image:[UIImage imageNamed:@"iocn_share"] location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
            
        }];
    }];
    [lineView setClickRightBlock:^{
        [theView removeFromSuperview];
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:text image:[UIImage imageNamed:@"iocn_share"] location:nil urlResource:nil presentedController:nil completion:^(UMSocialResponseEntity *response) {
            
        }];
    }];
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
