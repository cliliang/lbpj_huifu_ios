//
//  LBLuoBoToJiFenView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/11/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBLuoBoToJiFenView.h"

@interface LBLuoBoToJiFenView ()

@property (nonatomic, strong) UILabel *label_1; // -是否将****萝卜比
@property (nonatomic, strong) UILabel *label_2; // -兑换为****积分
@property (nonatomic, strong) UILabel *label_3; // -恭喜你
@property (nonatomic, strong) UILabel *label_4; // -兑换成功

@property (nonatomic, strong) UIButton *duiHuanBtn;

@end

@implementation LBLuoBoToJiFenView

+ (void)luoBoBiToJiFen:(NSString *)jifen luoBoBi:(NSString *)luoBoBi success:(LBSuccessVoidBlock)success
{
    LBLuoBoToJiFenView *theView = [LBLuoBoToJiFenView new];
    theView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    UIWindow *window = kWindow;
    [window addSubview:theView];
    [theView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(window);
    }];
    
    theView.success = success;
    
    // -白
    UIView *whiteView = [UIView new];
    whiteView.backgroundColor = [UIColor whiteColor];
    [theView addSubview:whiteView];
    whiteView.layer.cornerRadius = 4;
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(window);
        make.width.mas_equalTo(KAutoWDiv2(500));
        make.height.mas_equalTo(KAutoHDiv2(550));
    }];
    // -x
    UIImageView *imageV_x = [UIImageView new];
    [theView addSubview:imageV_x];
    imageV_x.userInteractionEnabled = YES;
    imageV_x.image = [UIImage imageNamed:@"icon_yaoqingyouli_quxiao"];
    [imageV_x mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(whiteView.mas_bottom).offset(KAutoHDiv2(70));
        make.centerX.mas_equalTo(whiteView);
        make.width.height.mas_equalTo(KAutoWDiv2(70));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:theView action:@selector(clickCancel)];
    [imageV_x addGestureRecognizer:tap];
    
    // -图
    UIImageView *imageV = [UIImageView new];
    [whiteView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"faxian_luobobiTojifen"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(whiteView);
        make.top.mas_equalTo(whiteView).offset(KAutoHDiv2(64));
        make.width.mas_equalTo(KAutoWDiv2(300));
        make.height.mas_equalTo(KAutoHDiv2(200));
    }];
    
    NSString *string1 = kStringFormat(@"是否将%@萝卜币", luoBoBi);
    NSString *string2 = kStringFormat(@"兑换为%@积分", jifen);
    NSString *string3 = @"恭喜您";
    NSString *string4 = @"兑换成功!";
    
    UILabel *label1 = [UILabel new];
    theView.label_1 = label1;
    [theView addSubview:label1];
    
    UILabel *label2 = [UILabel new];
    theView.label_2 = label2;
    [theView addSubview:label2];

    UILabel *label3 = [UILabel new];
    theView.label_3 = label3;
    [theView addSubview:label3];

    UILabel *label4 = [UILabel new];
    theView.label_4 = label4;
    [theView addSubview:label4];
    
    [label1 setText:string1 textColor:kDeepColor font:[UIFont systemFontOfSize:15 weight:UIFontWeightLight]];
    [label2 setText:string2 textColor:kDeepColor font:[UIFont systemFontOfSize:15 weight:UIFontWeightLight]];
    [label3 setText:string3 textColor:kNavBarColor font:[UIFont systemFontOfSize:18 weight:UIFontWeightLight]];
    [label4 setText:string4 textColor:kNavBarColor font:[UIFont systemFontOfSize:18 weight:UIFontWeightLight]];
    
    [label1 changeTextColor:kNavBarColor range:NSMakeRange(3, label1.text.length - 6)];
    [label2 changeTextColor:kNavBarColor range:NSMakeRange(3, label2.text.length - 5)];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(whiteView);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(imageV.mas_bottom).offset(KAutoHDiv2(38));
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(KAutoHDiv2(30));
        make.centerX.mas_equalTo(label1);
        make.height.mas_equalTo(15);
    }];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(imageV.mas_bottom).offset(KAutoHDiv2(57));
        make.centerX.mas_equalTo(imageV);
    }];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.top.mas_equalTo(label3.mas_bottom).offset(KAutoHDiv2(30));
        make.centerX.mas_equalTo(imageV);
    }];
    label3.hidden = YES;
    label4.hidden = YES;
    
    UIButton *duihuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [whiteView addSubview:duihuanBtn];
    [duihuanBtn setTitle:@"兑换" forState:UIControlStateNormal];
    [duihuanBtn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightLight]];
    duihuanBtn.backgroundColor = kNavBarColor;
    duihuanBtn.layer.cornerRadius = 4;
    [duihuanBtn addTarget:theView action:@selector(clickDuiHuanBtn) forControlEvents:UIControlEventTouchUpInside];
    [duihuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).offset(KAutoHDiv2(45));
        make.centerX.mas_equalTo(whiteView);
        make.width.mas_equalTo(KAutoWDiv2(364));
        make.height.mas_equalTo(KAutoHDiv2(80));
    }];
    theView.duiHuanBtn = duihuanBtn;
    
}
- (void)clickDuiHuanBtn
{
    [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    [LBHTTPObject POST_exchangeLuoboBi:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:kWindow animated:YES];
        if ([NSObject nullOrNilWithObjc:dict]) {
            [[PSSToast shareToast] showMessage:@"兑换失败"];
            return ;
        }
        if ([dict[@"success"] boolValue]) {
            _label_1.hidden = YES;
            _label_2.hidden = YES;
            _duiHuanBtn.hidden = YES;
            _label_3.hidden = NO;
            _label_4.hidden = NO;
            if (_success) {
                _success();
            }
        } else {
            [[PSSToast shareToast] showMessage:dict[@"message"]];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:kWindow animated:YES];
        [[PSSToast shareToast] showMessage:@"兑换失败"];
    }];
    
}
- (void)clickCancel
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
