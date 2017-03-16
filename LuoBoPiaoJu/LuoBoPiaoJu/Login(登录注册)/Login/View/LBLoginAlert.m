//
//  LBLoginAlert.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBLoginAlert.h"

@interface LBLoginAlert ()

@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_message;
@property (weak, nonatomic) IBOutlet UIButton *btn_Yes;
@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@end

@implementation LBLoginAlert

+ (LBLoginAlert *)instanceLoginAlertWithTitle:(NSString *)title
                                      message:(NSString *)message
{
    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"LBLoginAlert" owner:nil options:nil];
    LBLoginAlert *loginAlert = [nibView firstObject];
    loginAlert.btn_Yes.layer.cornerRadius = 5;
    loginAlert.label_title.text = title;
    loginAlert.label_message.text = message;
    loginAlert.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    loginAlert.frame = [UIScreen mainScreen].bounds;
    loginAlert.label_title.numberOfLines = 0;
    loginAlert.label_message.numberOfLines = 0;
    loginAlert.imageV.layer.cornerRadius = 5;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kLineColor;
    [loginAlert.imageV addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(loginAlert.imageV);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(loginAlert.imageV).offset(-44);
    }];
    
//    [loginAlert.btn_Yes mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.and.right.mas_equalTo(loginAlert.imageV);
//        make.centerX.mas_equalTo(loginAlert.imageV);
//        make.centerY.mas_equalTo(loginAlert.imageV.mas_bottom).offset(-22);
//    }];
    
    return loginAlert;
}

- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}

- (IBAction)clickYesButton:(id)sender {
    if (self.yesBlock) {
        self.yesBlock();
    }
    [self removeFromSuperview];
}

+ (void)showErrorWithString1:(NSString *)str1 str2:(NSString *)str2 VC:(UIViewController *)vc
{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:str1 message:str2 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:action];
    [vc presentViewController:alertC animated:YES completion:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
