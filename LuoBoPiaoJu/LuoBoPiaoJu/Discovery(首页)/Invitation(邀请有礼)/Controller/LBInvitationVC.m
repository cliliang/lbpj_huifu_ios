//
//  LBInvitationVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBInvitationVC.h"
#import "LBInviteRecordView.h"
#import <UMSocial.h>
#import "LBInvitedRecordModel.h"
#import "LBFenXiangLineView.h"
#import "LBFenXiangPageView.h"

#define kUMAppKey @"5770e3d2e0f55a4a67000d81"

@interface LBInvitationVC ()<UMSocialUIDelegate>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation LBInvitationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kBackgroundColor;
//    [self addSomeViews];
    [self setUpData];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self setUpData];
    }];
}
- (void)setUpData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBHTTPObject POST_searchAllInvitedListSuccess:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
        if ([NSObject nullOrNilWithObjc:dict]) {
            return;
        }
        NSArray *rows = dict[@"rows"];
        NSArray *arr = [LBInvitedRecordModel mj_objectArrayWithKeyValuesArray:rows];
        _dataArray = arr;
        [self addSomeViews];
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:NO];
    }];
}
- (void)addSomeViews
{
    LBUserModel *userModel = kUserModel;
    
    // 背景白块
    UIView *whiteV = [[UIView alloc] init];
    [self.view addSubview:whiteV];
//    whiteV.backgroundColor = [UIColor whiteColor];
    [whiteV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kAutoH(64 + div_2(350)));
    }];
    UIImageView *imageV_bg = [[UIImageView alloc] init];
//    imageV_bg.backgroundColor = [UIColor whiteColor];
    [whiteV addSubview:imageV_bg];
    [imageV_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(whiteV);
    }];
    
    // 累计赚取
    UILabel *label1 = [[UILabel alloc] init];
    [self setlabelPropertyWithLabel:label1 Text:@"累计赚取" textColor:kDeepColor fontFloat:div_2(30)];
    [whiteV addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(whiteV).mas_offset(kAutoH(64 - kJian64 + div_2(77)));
        make.centerX.mas_equalTo(whiteV);
        make.height.mas_equalTo(div_2(30));
    }];
    // 两条线
    UIView *view_line1 = [[UIView alloc] init];
    view_line1.backgroundColor = kLineColor;
    [whiteV addSubview:view_line1];
    [view_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(label1);
        make.right.mas_equalTo(label1.mas_left).mas_offset(-10);
        make.left.mas_equalTo(kAutoW(50));
    }];
    UIView *view_line2 = [[UIView alloc] init];
    view_line2.backgroundColor = kLineColor;
    [whiteV addSubview:view_line2];
    [view_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(label1);
        make.left.mas_equalTo(label1.mas_right).offset(10);
        make.right.mas_equalTo(kAutoW(-50));
    }];
    
    // 累计赚取-金额
    UILabel *label2 = [UILabel new];
    NSInteger allMoney = 0;
    for (LBInvitedRecordModel *model in self.dataArray) {
        allMoney += model.couponMoney;
    }
    NSString *string2 = [NSString stringWithFormat:@"%ld", (long)allMoney];
    [self setlabelPropertyWithLabel:label2 Text:string2 textColor:kNavBarColor fontFloat:div_2(66)];
    [whiteV addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).mas_offset(kAutoH(div_2(48)));
        make.centerX.mas_equalTo(whiteV);
        make.height.mas_equalTo(div_2(66));
    }];
    // 元
    UILabel *label_yuan = [UILabel new];
    [self setlabelPropertyWithLabel:label_yuan Text:@"元" textColor:kDeepColor fontFloat:div_2(22)];
    [whiteV addSubview:label_yuan];
    [label_yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label2.mas_right);
        make.bottom.mas_equalTo(label2).offset(-3);
        make.height.mas_equalTo(div_2(22));
    }];
    // 累计邀请n人
    UILabel *label_leiji = [UILabel new];
    [self setlabelPropertyWithLabel:label_leiji Text:[NSString stringWithFormat:@"累计邀请%ld人>>", (unsigned long)self.dataArray.count] textColor:kDeepColor fontFloat:div_2(22)];
    [whiteV addSubview:label_leiji];
    [label_leiji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).mas_offset(kAutoH(div_2(48)));
        make.centerX.mas_equalTo(whiteV);
        make.height.mas_equalTo(div_2(22));
    }];
    [label_leiji setFont:[UIFont systemFontOfSize:div_2(22) weight:UIFontWeightLight]];
    
    UIView *tapView = [[UIView alloc] init];
    [whiteV addSubview:tapView];
    [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_leiji).offset(-10);
        make.left.mas_equalTo(label_leiji).offset(-10);
        make.right.mas_equalTo(label_leiji).offset(10);
        make.bottom.mas_equalTo(label_leiji).offset(10);
    }];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickInviteHeader)];
    imageV_bg.userInteractionEnabled = YES;
    label_leiji.userInteractionEnabled = YES;
    [tapView addGestureRecognizer:tapGes];
    
    // 邀请balabalabala...
    UILabel *label_blbl = [[UILabel alloc] init];
    [self setlabelPropertyWithLabel:label_blbl Text:@"邀请好友来理财吧，到期银行兑付本息。" textColor:kDeepColor fontFloat:div_2(26)];
    [label_blbl setFont:[UIFont systemFontOfSize:div_2(26) weight:UIFontWeightLight]];
    [self.view addSubview:label_blbl];
    [label_blbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_leiji.mas_bottom).offset(KAutoHDiv2(65));
        make.centerX.mas_equalTo(self.view);
    }];
    UILabel *label_blbl2 = [[UILabel alloc] init];
    [self setlabelPropertyWithLabel:label_blbl2 Text:@"萝卜票据，天生安全！" textColor:kDeepColor fontFloat:div_2(26)];
    [label_blbl2 setFont:[UIFont systemFontOfSize:div_2(26) weight:UIFontWeightLight]];
    [self.view addSubview:label_blbl2];
    [label_blbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_blbl.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view).offset(50);
        make.right.mas_equalTo(self.view).offset(-50);
    }];
    
    // 邀请各送10元现金
    UILabel *label_10yuan = [[UILabel alloc] init];
    [label_10yuan setText:[NSString stringWithFormat:@"邀请各送%d元现金", 20] textColor:[UIColor colorWithRGBString:@"ff583a"] font:[UIFont systemFontOfSize:18]];
    [self.view addSubview:label_10yuan];
    [label_10yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_blbl2.mas_bottom).offset(KAutoHDiv2(60));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(18);
    }];
    
    // 添加图片
    UIImageView *imageV = [[UIImageView alloc] init];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_10yuan.mas_bottom).offset(KAutoHDiv2(60));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(KAutoWDiv2(326));
        make.height.mas_equalTo(KAutoHDiv2(211));
    }];
    imageV.image = [UIImage imageNamed:@"image_yaoqingyouli"];
    

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor whiteColor] highColor:[UIColor whiteColor] fontSize:17 target:self action:@selector(clickInvite) forControlEvents:UIControlEventTouchUpInside title:@"立即邀请"];
    button.backgroundColor = kNavBarColor;
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(-div_2(30));
        make.left.mas_equalTo(self.view).offset(kAutoW(40));
        make.right.mas_equalTo(self.view).offset(-kAutoW(40));
        make.height.mas_equalTo(40);
    }];
    [button becomeCircleWithR:4];
    
    // 补加
    UIView *view111 = [[UIView alloc] init];
    view111.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view111];
    [self.view sendSubviewToBack:view111];
    [view111 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-70);
    }];
    
    // 添加我的邀请码
    UIView *view01 = [[UIView alloc] init];
    [self.view addSubview:view01];
    
    UILabel *label_yaoqingma = [UILabel new];
    [label_yaoqingma setText:kStringFormat(@"我的邀请码: %@", userModel.inviteCode) textColor:kDeepColor font:[UIFont systemFontOfSize:18 weight:UIFontWeightLight]];
    [view01 addSubview:label_yaoqingma];
    
    UIButton *btn_fuzhi = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_fuzhi setTitle:@"复制" forState:UIControlStateNormal];
    [btn_fuzhi.titleLabel setFont:[UIFont systemFontOfSize:12 weight:UIFontWeightLight]];
    [btn_fuzhi setTitleColor:kNavBarColor forState:UIControlStateNormal];
    btn_fuzhi.layer.cornerRadius = 4;
    btn_fuzhi.layer.borderWidth = 0.5;
    btn_fuzhi.layer.borderColor = kNavBarColor.CGColor;
    [btn_fuzhi addTarget:self action:@selector(clickCopyBtn) forControlEvents:UIControlEventTouchUpInside];
    [view01 addSubview:btn_fuzhi];
    
    [label_yaoqingma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(18);
        make.right.mas_equalTo(btn_fuzhi.mas_left).offset(-KAutoWDiv2(20));
    }];
    [btn_fuzhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kDiv2(92));
        make.height.mas_equalTo(kDiv2(48));
        make.centerY.mas_equalTo(label_yaoqingma);
    }];
    [view01 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(btn_fuzhi);
        make.left.mas_equalTo(label_yaoqingma);
        make.centerX.mas_equalTo(self.view);
        CGFloat top = 110;
        if (kIPHONE_5s) {
            top = 60;
        }
        make.top.mas_equalTo(imageV.mas_bottom).offset(KAutoHDiv2(top));
    }];
    
}
- (void)clickCopyBtn
{
    LBUserModel *userModel = kUserModel;
    UIPasteboard *pastB = [UIPasteboard generalPasteboard];
    pastB.string = kStringFormat(@"%@", userModel.inviteCode);
    [[PSSToast shareToast] showMessage:@"复制成功"];
}
- (void)clickInviteHeader
{
    LBInviteRecordView *view = [[LBInviteRecordView alloc] init];
    view.dataArray = _dataArray;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
// 立即邀请
- (void)clickInvite
{
    /*
     NSString *urls = nil;
     if (kUserModel.inviteCode) {
     urls = [NSString stringWithFormat:@"%@%@%@", URL_HOST, @"website/register.html?inviteCode=", kUserModel.inviteCode];
     NSLog(@"%@", kUserModel.inviteCode);
     NSLog(@"%@", urls);
     } else {
     urls = [NSString stringWithFormat:@"%@%@", URL_HOST, @"website/register.html"];
     }
     [UMSocialData defaultData].extConfig.title = @"和好友一起来理财！20元现金红包";
     
     [UMSocialData defaultData].extConfig.tencentData.urlResource.url = urls;
     [UMSocialData defaultData].extConfig.wechatSessionData.url = urls;
     [UMSocialData defaultData].extConfig.wechatTimelineData.url = urls;
     [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
     
     [UMSocialSnsService presentSnsIconSheetView:self
     appKey:kUMAppKey
     shareText:@"萝卜票据 银行兑付 天生安全 邀请好友一起来理财各得20元现金红包。"
     shareImage:[UIImage imageNamed:@"iocn_share"]
     shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
     delegate:self];
     */
    
    NSString *urls = nil;
    LBUserModel *userModel = kUserModel;
    if (userModel.inviteCode) {
        urls = [NSString stringWithFormat:@"%@%@%@", URL_HOST, @"website/toInvite.html?inviteCode=", userModel.inviteCode];
    } else {
        urls = [NSString stringWithFormat:@"%@%@", URL_HOST, @"website/toInvite.html"];
    }
    [LBFenXiangPageView shareUrl:urls title:@"20元现金红包，和好友一起来理财！" content:@"萝卜票据 银行兑付 天生安全 邀请好友一起来理财各得20元现金红包。"]; // 下面代码替换为此条代码
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = urls;
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = urls;
//    [UMSocialData defaultData].extConfig.title = @"20元现金红包，和好友一起来理财！";
//    NSString *content = @"萝卜票据 银行兑付 天生安全 邀请好友一起来理财各得20元现金红包。";
//    
//    LBFenXiangLineView *fenxiangView = [LBFenXiangLineView creatInView:self.view height:div_2(38 + 120 + 37 + 30 + 27)];
//    [fenxiangView setClickLeftBlock:^{ // 微信
//        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession] content:content image:[UIImage imageNamed:@"iocn_share"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
//            
//        }];
//    }];
//    [fenxiangView setClickRightBlock:^{ // 朋友圈
//        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:[UIImage imageNamed:@"iocn_share"] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response) {
//            
//        }];
//    }];
}
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        // 分享成功
        kLog(@"PSS-分享成功");
    }
}

- (void)setlabelPropertyWithLabel:(UILabel *)label
                             Text:(NSString *)text
                        textColor:(UIColor *)textColor
                        fontFloat:(CGFloat)fontFloat
{
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontFloat];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
//    label.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
