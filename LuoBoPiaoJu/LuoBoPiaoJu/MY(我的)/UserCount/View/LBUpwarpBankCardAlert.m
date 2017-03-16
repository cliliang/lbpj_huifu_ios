//
//  LBUpwarpBankCardAlert.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/7.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBUpwarpBankCardAlert.h"
#import <UIKit/UIKit.h>

@interface LBUpwarpBankCardAlert ()

@property (nonatomic, strong) NSString *huifuAccount;

@end

@implementation LBUpwarpBankCardAlert

+ (void)showAlertWithSure:(LBButtonBlock)sure
                     quit:(LBButtonBlock)quit
             huifuAccount:(NSString *)huifuAccount
{
    LBUpwarpBankCardAlert *alert = [[LBUpwarpBankCardAlert alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [kWindow addSubview:alert];
    alert.huifuAccount = huifuAccount;
    alert.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    alert.sureBlock = sure;
    alert.quitBlock = quit;
    // 弹窗背景view
    UIView *view = [[UIView alloc] init];
    [alert addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(alert);
        make.width.mas_equalTo(div_2(493));
        make.height.mas_equalTo(div_2(400));
    }];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 4;
    
    // 添加图片(复制)
    UIImageView *imageView = [[UIImageView alloc] init];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view);
        make.right.mas_equalTo(view);
    }];
    imageView.image = [UIImage imageNamed:@"image_bankCark_fuzhi"];
    
    // label_汇付账号账号标题
    UILabel *label_huifuTitle = [[UILabel alloc] init];
    [view addSubview:label_huifuTitle];
    label_huifuTitle.font = [UIFont systemFontOfSize:13];
    label_huifuTitle.textColor = kDeepColor;
    label_huifuTitle.text = @"汇付账号";
    [label_huifuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(div_2(38));
//        make.left.mas_equalTo(view).offset(div_2(86));
        make.height.mas_equalTo(13);
    }];
    
    UILabel *label_huifuNum = [[UILabel alloc] init];
    [view addSubview:label_huifuNum];
    label_huifuNum.font = [UIFont systemFontOfSize:13];
    label_huifuNum.textColor = kDeepColor;
    label_huifuNum.text = huifuAccount;
    [label_huifuNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_huifuTitle.mas_bottom).offset(12);
//        make.left.mas_equalTo(view).offset(43);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(12);
        make.left.mas_equalTo(label_huifuTitle);
    }];
    
    // label_汇付天下解绑地址
    UILabel *label_addr = [[UILabel alloc] init];
    [view addSubview:label_addr];
    label_addr.font = [UIFont systemFontOfSize:11];
    label_addr.textColor = kLightColor;
    label_addr.text = @"汇付天下解绑地址";
    [label_addr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_huifuNum.mas_bottom).offset(10);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(11);
    }];
    
    // label_网络 -- https://c.chinapnr.com/p2puser/
    UILabel *label_url = [[UILabel alloc] init];
    [view addSubview:label_url];
    label_url.font = [UIFont systemFontOfSize:11];
    label_url.textColor = kLightColor;
    label_url.text = @"https://c.chinapnr.com/p2puser/";
    [label_url mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_addr.mas_bottom).offset(10);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(11);
    }];
    
    // label_消息 您确定解绑吗? 请慎重考虑
    UILabel *label_message = [[UILabel alloc] init];
    [view addSubview:label_message];
    label_message.font = [UIFont systemFontOfSize:13];
    label_message.textColor = kDeepColor;
    label_message.text = @"您确定解绑吗? 请慎重考虑";
    [label_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_url).offset(24);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(13);
    }];
    
    // 横线
    UIView *view_hengXian = [[UIView alloc] init];
    view_hengXian.backgroundColor = kBackgroundColor;
    [view addSubview:view_hengXian];
    [view_hengXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(view);
        make.bottom.mas_equalTo(view).offset(-50);
        make.height.mas_equalTo(1);
    }];
    // 竖线
    UIView *view_shuXian = [[UIView alloc] init];
    view_shuXian.backgroundColor = kBackgroundColor;
    [view addSubview:view_shuXian];
    [view_shuXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view_hengXian.mas_bottom);
        make.bottom.and.centerX.mas_equalTo(view);
        make.width.mas_equalTo(1);
    }];
    
    // 确定按钮
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom normalColor:kDeepColor highColor:kDeepColor target:alert action:@selector(clickSureButton) forControlEvents:UIControlEventTouchUpInside title:@"确定"];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.mas_equalTo(view);
        make.top.mas_equalTo(view_hengXian.mas_bottom);
        make.left.mas_equalTo(view_shuXian.mas_right);
    }];
    
    // 取消按钮
    UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeCustom normalColor:kDeepColor highColor:kDeepColor target:alert action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside title:@"取消"];
    quitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:quitButton];
    [quitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.mas_equalTo(view);
        make.top.mas_equalTo(view_hengXian.mas_bottom);
        make.right.mas_equalTo(view_shuXian.mas_left);
    }];
    
    
    
}

- (void)clickSureButton
{
    if (self.sureBlock) {
        self.sureBlock();
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.huifuAccount];
    [self removeFromSuperview];
}
- (void)clickQuitButton
{
    if (self.quitBlock) {
        self.quitBlock();
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
