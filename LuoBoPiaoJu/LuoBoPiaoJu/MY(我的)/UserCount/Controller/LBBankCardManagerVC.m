//
//  LBBankCardManagerVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBBankCardManagerVC.h"
#import "LBBankCardListVC.h"
#import "LBUpwarpBankCardAlert.h"

@interface LBBankCardManagerVC ()

@property (nonatomic, strong) LBUserModel *userModel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_bankCard;

@property (nonatomic, strong) UILabel *label_content;
@property (nonatomic, strong) UILabel *label_title;

@property (nonatomic, assign) int isJieBang;

@end

@implementation LBBankCardManagerVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:nil];
//    self.userModel = [LBUserModel getInPhone];
//    if (self.userModel.bankCard || self.userModel.bankCard.length) {
//        self.isHaveCard = YES;
//        [self updateUI];
//    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBUserModel updateUserWithUserModel:^{
        self.userModel = [LBUserModel getInPhone];
        [self jieBangYesOrNotSetUpData];
        if (self.userModel.bankCard || self.userModel.bankCard.length) {
            self.isHaveCard = YES;
            [self updateUI];
        } else {
            self.isHaveCard = NO;
            [self updateUI];
        }
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_back.layer.cornerRadius = 4;
    self.view_back.backgroundColor = kNavBarColor;
    self.imageView_bankCard.image = [UIImage imageNamed:@"bg_bankCard"];
    
    self.btn_cardTitle.userInteractionEnabled = YES;
    self.label_yinHangKa.hidden = YES;
    self.label_name.hidden = YES;
    self.btn_jieBang.hidden = YES;
    self.btn_jieBang.userInteractionEnabled = NO;
    self.btn_cardTitle.hidden = YES;
    
    [self addWenXinTiShi];
}
// 添加银行卡
- (IBAction)clickCardTitle:(id)sender {
    
    if (!self.userModel.isAutonym) {
        LBWebViewController *webView = [LBWebViewController new];
        webView.webViewStyle = LBWebViewControllerStyleRenZheng;
        [self.navigationController pushViewController:webView animated:YES];
    } else {
        LBWebViewController *webView = [LBWebViewController new];
        webView.webViewStyle = LBWebViewControllerStyleBindingCard;
        [self.navigationController pushViewController:webView animated:YES];
    }
}
// -解绑
- (IBAction)clickJieBangButton:(id)sender {
    
//    LBLoginAlert *alert = [LBLoginAlert instanceLoginAlertWithTitle:@"去官网解绑吧" message:@""];
//    [alert show];
    if (self.userModel == nil) {
        return;
    }
    if (_isJieBang != 1) {
        [[LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:@"您还有未到期的产品, 无法解绑银行卡"] show];
        return;
    }
//    LBWebViewController *webVC = [LBWebViewController new];
//    webVC.webViewStyle = LBWebViewControllerStyleJieBang;
//    [self.navigationController pushViewController:webVC animated:YES];
    [LBUpwarpBankCardAlert showAlertWithSure:^{
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"汇付官网解绑"]];
    } quit:^{
        
    } huifuAccount:self.userModel.countName];
}

// 添加温馨提示
- (void)addWenXinTiShi
{
    UILabel *label_title = [[UILabel alloc] init];
    label_title.font = [UIFont systemFontOfSize:13];
    label_title.text = @"温馨提示:";
    label_title.textColor = kLightColor;
    [self.view addSubview:label_title];
    
    UILabel *label_content = [[UILabel alloc] init];
    label_content.numberOfLines = 0;
    label_title.font = [UIFont systemFontOfSize:13];
    NSString *str_con = @"由于我们实行单卡进出, 所以如果您解绑您现在的银行卡, 由于这个银行卡购买的产品到期后资金将不能退还到您的银行卡, 请产品到期本金收益退回之后再进行解绑";
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str_con];
//    NSParagraphStyleAttributeName
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 8.0;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, str_con.length)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, str_con.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:kLightColor range:NSMakeRange(0, str_con.length)];
    label_content.attributedText = attrStr;
    [self.view addSubview:label_content];
    
    CGFloat left = 60;
    CGFloat right = 60;
    if (kIPHONE_5s) {
        left = 25;
        right = 15;
    }
    
    [label_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(left);
        make.bottom.mas_equalTo(self.view).offset(-60);
        make.right.mas_equalTo(self.view).offset(-right);
    }];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(label_content.mas_top).offset(-8);
        make.left.mas_equalTo(label_content);
    }];
    
    self.label_content = label_content;
    self.label_title = label_title;
    label_title.hidden = YES;
    label_content.hidden = YES;
}

- (void)updateUI
{
    if (_isHaveCard) {
        self.btn_cardTitle.userInteractionEnabled = NO;
        self.label_yinHangKa.hidden = NO;
        self.label_name.hidden = NO;
        self.btn_jieBang.hidden = NO;
        self.btn_jieBang.userInteractionEnabled = YES;
        
        self.label_content.hidden = NO;
        self.label_title.hidden = NO;
        
        self.btn_cardTitle.userInteractionEnabled = NO;
        NSString *labelString = @"";
        NSString *name = self.userModel.userName;
        for (int i = 0; i < name.length; i++) {
            if (i == name.length - 1) {
                labelString = [labelString stringByAppendingString:[name substringWithRange:NSMakeRange(name.length - 1, 1)]];
            } else {
                labelString = [labelString stringByAppendingString:@"*"];
            }
        }
        
        NSString *string = [NSString stringWithFormat:@"%@************%@", [[LBUserModel getSecretBankCard] substringToIndex:4], [[LBUserModel getSecretBankCard] substringFromIndex:[LBUserModel getSecretBankCard].length - 3]];
        [self.btn_cardTitle setTitle:string  forState:UIControlStateNormal];
        self.btn_cardTitle.hidden = NO;
        
        self.label_yinHangKa.text = self.userModel.bankCardName;
//        self.btn_cardTitle.titleLabel.text = @"中国银行";
//        [self.btn_cardTitle setTitle:@"中国银行" forState:UIControlStateNormal];
        self.label_name.text = labelString;
        self.btn_jieBang.userInteractionEnabled = YES;
        self.label_name.hidden = NO;
        self.btn_jieBang.hidden = NO;
    } else {
        self.btn_cardTitle.titleLabel.text = @"+ 添加银行卡";
        [self.btn_cardTitle setTitle:@"+ 添加银行卡" forState:UIControlStateNormal];
        self.btn_cardTitle.hidden = NO;
    }
}

- (void)jieBangYesOrNotSetUpData
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_searchBankCard];
    if (self.userModel == nil) {
        return;
    }
    [HTTPTools POSTWithUrl:string parameter:@{@"userId":@(self.userModel.userId), @"token":self.userModel.token} progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([dict[@"success"] boolValue]) {
            _isJieBang = [dict[@"flg"] intValue];
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

// 点击查看银行卡列表
- (IBAction)clickCardList:(id)sender {
    LBBankCardListVC *listVC = [LBBankCardListVC new];
    [self.navigationController pushViewController:listVC animated:YES];
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
