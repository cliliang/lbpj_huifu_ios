//
//  LBTopUpViewController.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBTopUpViewController.h"

@interface LBTopUpViewController () <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_Btn;

@property (weak, nonatomic) IBOutlet UILabel *label_yuE;
@property (weak, nonatomic) IBOutlet UILabel *label_card;
@property (weak, nonatomic) IBOutlet UITextField *tf_money;
@property (weak, nonatomic) IBOutlet UIButton *btn_topUp;
@property (nonatomic, strong) LBUserModel *userModel;
@property (weak, nonatomic) IBOutlet UILabel *label_card_title;
@property (weak, nonatomic) IBOutlet UILabel *label_congZhiMoney;

@end

@implementation LBTopUpViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.btn_topUp.titleLabel.text = self.buttonTitle;
    [self.btn_topUp setTitle:self.buttonTitle forState:UIControlStateNormal];
    self.tf_money.text = @"";
    [self changeBtnColor:NO];
    [LBUserModel updateUserWithUserModel:^{
        self.userModel = [LBUserModel getInPhone];
        self.label_yuE.text = [NSString stringWithFormat:@"%.2lf", [LBUserModel getInPhone].enAbleMoney];
        NSString *cardStr = self.userModel.bankCard;
        self.label_card.text = cardStr ? [NSString stringWithFormat:@"%@(尾号%@)", self.userModel.bankCardName, [self.userModel.bankCard substringFromIndex:cardStr.length - 4]] : @"";
    }];
    
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userModel = [LBUserModel getInPhone];
    NSString *cardStr = self.userModel.bankCard;
    self.label_card.text = cardStr ? [NSString stringWithFormat:@"%@(尾号%@)", self.userModel.bankCardName, [self.userModel.bankCard substringFromIndex:cardStr.length - 4]] : @"";
    self.btn_topUp.layer.cornerRadius = 5;
    self.btn_topUp.backgroundColor = kNavBarColor;
    self.tf_money.keyboardType = UIKeyboardTypeDecimalPad;
    self.label_yuE.text = [NSString stringWithFormat:@"%.2lf", [LBUserModel getInPhone].enAbleMoney];
    
    if ([self.buttonTitle isEqualToString:@"提现"]) {
        self.label_card_title.text = @"提现银行卡";
        self.label_congZhiMoney.text = @"提现金额";
    } else {
        self.label_card_title.text = @"充值银行卡";
        self.label_congZhiMoney.text = @"充值金额";
    }
    [self awakeFromNib];
}



// 点击充值/提现
- (IBAction)clickTopUpButton:(id)sender {
    if (_tf_money.text.length == 0 || _tf_money.text == nil) {
        [[PSSToast shareToast] showMessage:@"请输入金额"];
        return;
    }
    LBWebViewController *viewC = [LBWebViewController new];
    viewC.money = [self.tf_money.text doubleValue];
    if ([self.buttonTitle isEqualToString:@"提现"]) {
        if (self.userModel != nil && (self.userModel.bankCard == nil || self.userModel.bankCard.length == 0)) {
            viewC.webViewStyle = LBWebViewControllerStyleBindingCard;
        } else {
            viewC.webViewStyle = LBWebViewControllerStyleTiXian;
        }
    } else {
        viewC.webViewStyle = LBWebViewControllerStyleChongZhi;
    }
    [self.navigationController pushViewController:viewC animated:YES];
}

// 输入钱数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *numberStr = [NSString stringWithFormat:@"%@%@", textField.text, string];
    if ([self.buttonTitle isEqualToString:@"充值"]) {
        if ([numberStr doubleValue] > 999999.99 && string.length >= 1) {
            return NO;
        }
    } else {
        if (numberStr.doubleValue > self.label_yuE.text.doubleValue) {
            textField.text = self.label_yuE.text;
            return NO;
        }
    }
    
    NSArray *arr = [numberStr componentsSeparatedByString:@"."];
    if (arr.count > 2) {
        return NO;
    } else if (arr.count == 2 && [arr[1] length] > 2) {
        return NO;
    }
    if (textField.text.length == 0) {
        if ([string isEqualToString:@"."]) {
            textField.text = @"0.";
            return NO;
        }
    }
    if (textField.text.length == 1 && [textField.text isEqualToString:@"0"] && ![string isEqualToString:@"."]) {
        textField.text = string;
        return NO;
    }
    
    if (textField.text.length < 2) {
        if (textField.text.length < 1 && string.length > 0) {
            [self changeBtnColor:YES];
        }
        if (textField.text.length == 1 && string.length == 0) {
            [self changeBtnColor:NO];
        }
    }
    return YES;
}

- (void)changeBtnColor:(BOOL)animate
{
    self.btn_topUp.userInteractionEnabled = animate;
    self.btn_topUp.backgroundColor = animate ? kNavBarColor : [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    if ([_buttonTitle isEqualToString:@"提现"]) {
        self.top_Btn.constant = 22 + 13;
        UILabel *label = [UILabel new];
        [self.view addSubview:label];
        [label setText:@"提现需扣除2元手续费(由第三方收取)" textColor:kLightColor font:[UIFont systemFontOfSize:13 weight:UIFontWeightLight]];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.btn_topUp.mas_top).offset(-11);
            make.height.mas_equalTo(13);
        }];
    }
}

@end















