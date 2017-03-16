//
//  LBCalcDetailVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCalcDetailVC.h"
#import "LBCalcDetailItem.h"
#import "LBFenXiangPageView.h"
#import <UMSocial.h>
#define kUMAppKey @"5770e3d2e0f55a4a67000d81"

typedef enum : NSUInteger {
    LBWhichLabelFirst,
    LBWhichLabelSecond,
} LBWhichLabel;

@interface LBCalcDetailVC () <UMSocialUIDelegate>

@property (nonatomic, strong) UILabel *label_FirNum;
@property (nonatomic, strong) UILabel *label_SecNum;
@property (nonatomic, strong) UILabel *label_SecCalc;
@property (nonatomic, strong) UILabel *label_Thi;

@property (nonatomic, assign) LBWhichLabel whichLabel;

@property (nonatomic, strong) UIFont *font;

@end

@implementation LBCalcDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"计算器";
    if (self.money == nil || [self.money doubleValue] == 0 || [self.money isEqualToString:@""]) {
        self.whichLabel = LBWhichLabelFirst;
        self.money = @"";
    } else {
       self.whichLabel = LBWhichLabelSecond;
    }
    
    [self addOneSection];
    [self addTwoSection];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"分享" titleColor:[UIColor whiteColor] highColor:[UIColor whiteColor] target:self action:@selector(clickRightBtn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickRightBtn
{
    if ([self.label_Thi.text doubleValue] == 0) {
        [self alertShowString:@"无计算结果"];
        return;
    }
    [LBFenXiangPageView shareText:self.label_Thi.text];
}
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.responseCode == UMSResponseCodeSuccess) {
        // 分享成功
    }
}

- (void)addOneSection
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"bg_calcDetail_1"];
    [imageV becomeCircleWithR:4];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64 + KAutoHDiv2(33) - kJian64);
        make.left.mas_equalTo(self.view).offset(KAutoWDiv2(30));
        make.right.mas_equalTo(self.view).offset(-KAutoWDiv2(30));
        make.height.mas_equalTo(KAutoHDiv2(382));
    }];
    
    // 1
    UILabel *label_1 = [UILabel new];
    [label_1 setText:self.money textColor:kDeepColor font:self.font];
    [imageV addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageV).offset(-KAutoWDiv2(60));
        make.centerY.mas_equalTo(imageV).offset(-KAutoHDiv2(127));
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithRGBString:@"d9d9d9"];
    [imageV addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV).offset(KAutoHDiv2(127));
        make.left.mas_equalTo(imageV).offset(KAutoWDiv2(30));
        make.right.mas_equalTo(imageV).offset(-KAutoWDiv2(30));
        make.height.mas_equalTo(0.5);
    }];
    
    // 2
    UILabel *label_num2 = [UILabel new];
    [label_num2 setText:@"" textColor:kDeepColor font:self.font];
    [imageV addSubview:label_num2];
    [label_num2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageV).offset(-KAutoWDiv2(60));
        make.centerY.mas_equalTo(imageV);
    }];
    UILabel *label_calc2 = [UILabel new];
    [label_calc2 setText:@"" textColor:kDeepColor font:self.font];
    [imageV addSubview:label_calc2];
    [label_calc2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(label_num2.mas_left);
        make.centerY.mas_equalTo(imageV);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithRGBString:@"d9d9d9"];
    [imageV addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV).offset(KAutoHDiv2(127 * 2));
        make.left.mas_equalTo(imageV).offset(KAutoWDiv2(30));
        make.right.mas_equalTo(imageV).offset(-KAutoWDiv2(30));
        make.height.mas_equalTo(0.5);
    }];
    
    // 3
    UILabel *label_num3 = [UILabel new];
    [label_num3 setText:@"" textColor:kDeepColor font:self.font];
    [imageV addSubview:label_num3];
    [label_num3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageV).offset(-KAutoWDiv2(60));
        make.centerY.mas_equalTo(imageV).offset(KAutoHDiv2(127));
//        make.left.mas_equalTo(imageV).offset(-KAutoWDiv2(60));
//        make.height.mas_equalTo(20);
    }];
    label_num3.textAlignment = NSTextAlignmentRight;
    
    self.label_FirNum = label_1;
    self.label_SecNum = label_num2;
    self.label_SecCalc = label_calc2;
    self.label_Thi = label_num3;
    
    imageV.userInteractionEnabled = YES;
    label_num3.userInteractionEnabled = YES;
    // 添加长按
    UILongPressGestureRecognizer *longPre = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyResultNum:)];
    longPre.minimumPressDuration = 0.5;
    [label_num3 addGestureRecognizer:longPre];
    
    label_1.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPre1 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyResultNum1:)];
    longPre.minimumPressDuration = 0.5;
    [label_1 addGestureRecognizer:longPre1];
    
    label_num2.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPre2 = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyResultNum2:)];
    longPre.minimumPressDuration = 0.5;
    [label_num2 addGestureRecognizer:longPre2];

}
- (void)copyResultNum:(UILongPressGestureRecognizer *)longPre
{
    if (longPre.state == 1) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"复制成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertC dismissViewControllerAnimated:YES completion:nil];
        });
        UIPasteboard *pasB = [UIPasteboard generalPasteboard];
        pasB.string = self.label_Thi.text;
    }
}
- (void)copyResultNum1:(UILongPressGestureRecognizer *)longPre
{
    if (longPre.state == 1) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"复制成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertC dismissViewControllerAnimated:YES completion:nil];
        });
        UIPasteboard *pasB = [UIPasteboard generalPasteboard];
        pasB.string = self.label_FirNum.text;
    }
}
- (void)copyResultNum2:(UILongPressGestureRecognizer *)longPre
{
    if (longPre.state == 1) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"复制成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertC animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertC dismissViewControllerAnimated:YES completion:nil];
        });
        UIPasteboard *pasB = [UIPasteboard generalPasteboard];
        pasB.string = self.label_SecNum.text;
    }
}


- (void)addTwoSection
{
    double y_org = 64 + KAutoHDiv2(33 + 382 + 24) - kJian64;
    double x_org = KAutoWDiv2(30);
    
    double itemW = KAutoWDiv2(157);
    double itemH = KAutoHDiv2(133);
    
    double spacingW = KAutoWDiv2(21);
    double spacingH = KAutoHDiv2(21);
    
//    double zuoYou = KAutoWDiv2(30);
//    double xia = KAutoHDiv2(33);
    
    for (int i = 0; i < 18; i++) {
        if (i < 2) {
            double width = KAutoWDiv2(328);
            double height = KAutoHDiv2(106);
            LBCalcDetailItem *itemV = [[LBCalcDetailItem alloc] initWithFrame:CGRectMake(x_org + i * (width + KAutoWDiv2(34)), y_org, width, height)];
            itemV.font = self.font;
            itemV.label.textColor = [UIColor whiteColor];
            [self.view addSubview:itemV];
            if (i == 0) {
                itemV.title = @"AC";
                [itemV setDetailBlock:^(NSString *str) {
                    [self clickDeleteAll];
                }];
            } else {
                itemV.title = @"<-";
                [itemV setDetailBlock:^(NSString *str) {
                    [self clickDeleteOne];
                }];
            }
            itemV.normalImage = [UIImage imageNamed:@"bg_calcDetail_nor"];
            itemV.highLightImage = [UIImage imageNamed:@"bg_calcDetail_sele"];
            continue;
        }
        int j = i - 2;
        int row = j / 4; // 行
        int line = j % 4; // 列
        double y = y_org + KAutoHDiv2(106 + 24);
        LBCalcDetailItem *itemV = [[LBCalcDetailItem alloc] initWithFrame:CGRectMake(x_org + line * (itemW + spacingW), y + row * (itemH + spacingH), itemW, itemH)];
        [self.view addSubview:itemV];
        if ([self theNum:i containFirNum:2 second:4] || [self theNum:i containFirNum:6 second:8] || [self theNum:i containFirNum:10 second:12] || [self theNum:i containFirNum:14 second:15]) {
            
            if (j == 12) { // 0
                itemV.title = @"0";
            } else if (j == 13) {
                itemV.title = @".";
            } else {
                itemV.title = [NSString stringWithFormat:@"%d", j + 7 + (j/4) * (-7)];
            }
            [itemV setDetailBlock:^(NSString *str) {
                [self clickNumber:str];
            }];
        } else {
            if (j == 14) { // =
                itemV.title = @"=";
                [itemV setDetailBlock:^(NSString *str) {
                    [self clickEqualTo];
                }];
            } else { // + - × ÷
                switch (j) {
                    case 3: {
                        itemV.title = @"÷";
                        break;
                    }
                    case 7: {
                        itemV.title = @"×";
                        break;
                    }
                    case 11: {
                        itemV.title = @"-";
                        break;
                    }
                    case 15: {
                        itemV.title = @"+";
                        break;
                    }
                    default:
                        break;
                }
                [itemV setDetailBlock:^(NSString *str) {
                    [self clickCalculate:str];
                }];
            }
            
        }
    }
}

- (void)clickNumber:(NSString *)num // 点击数字
{
    kLog(@"%@", num);
    if (self.whichLabel == LBWhichLabelFirst) {
        [self.label_FirNum appendingStr:num];
    } else {
        [self.label_SecNum appendingStr:num];
        if (self.label_Thi.text.length != 0) {
            self.label_FirNum.text = self.label_Thi.text;
            self.label_Thi.text = @"";
            self.label_SecNum.text = num;
            self.label_SecCalc.text = @"";
        }
    }
}
- (void)clickCalculate:(NSString *)operator // + - × ÷
{
    kLog(@"%@", operator);
    self.label_SecCalc.text = operator;
    self.whichLabel = LBWhichLabelSecond;
    if (self.label_Thi.text.length != 0) {
        self.label_FirNum.text = self.label_Thi.text;
        self.label_Thi.text = @"";
        self.label_SecNum.text = @"";
    }
    if (self.label_FirNum.text.length == 0) {
        self.label_FirNum.text = @"0";
    }
}
- (void)clickEqualTo // 等于
{
    NSString *fuhao = self.label_SecCalc.text;
    NSString *firNum = self.label_FirNum.text;
    NSString *secNum = self.label_SecNum.text;
    if (firNum.length == 0) {
        firNum = @"0";
    }
    if (secNum.length == 0) {
        secNum = @"0";
    }
    if (self.label_SecCalc.text.length == 0) {
        [self alertShowString:@"请输入运算符"];
        return;
    }
    if ([self.label_SecCalc.text isEqualToString:@"÷"] && [self.label_SecNum.text doubleValue] == 0) {
        [self alertShowString:@"分母不能为0"];
        return;
    }
    if ([fuhao isEqualToString:@"+"]) {
        double result = [firNum doubleValue] + [secNum doubleValue];
        self.label_Thi.text = [NSString stringWithFormat:@"%.2lf", result];
    } else if ([fuhao isEqualToString:@"-"]) {
        double result = [firNum doubleValue] - [secNum doubleValue];
        self.label_Thi.text = [NSString stringWithFormat:@"%.2lf", result];
    } else if ([fuhao isEqualToString:@"×"]) {
        double result = [firNum doubleValue] * [secNum doubleValue];
        self.label_Thi.text = [NSString stringWithFormat:@"%.2lf", result];
    } else if ([fuhao isEqualToString:@"÷"]) {
        double result = [firNum doubleValue] / [secNum doubleValue];
        self.label_Thi.text = [NSString stringWithFormat:@"%.2lf", result];
    }
}

- (void)alertShowString:(NSString *)str
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertC addAction:action];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)clickDeleteAll
{
    kLog(@"delete all");
    self.whichLabel = LBWhichLabelFirst;
    self.label_FirNum.text = @"";
    self.label_SecCalc.text = @"";
    self.label_SecNum.text = @"";
    self.label_Thi.text = @"";
}
- (void)clickDeleteOne
{
    kLog(@"delete one");
    if (self.whichLabel == LBWhichLabelFirst) {
        [self.label_FirNum deleteLastOneString];
    } else {
        if (self.label_Thi.text.length != 0) {
            self.label_FirNum.text = self.label_Thi.text;
            self.label_SecNum.text = @"";
            self.label_SecCalc.text = @"";
            self.label_Thi.text = @"";
        } else {
            [self.label_SecNum deleteLastOneString];
        }
    }
}

// 是否在两数之间, 包含两数
- (BOOL)theNum:(int)num containFirNum:(int)firN second:(int)secN
{
    if (num >= firN && num <= secN) {
        return YES;
    }
    return NO;
}

- (UIFont *)font
{
    if (_font == nil) {
        _font = [UIFont fontWithName:@"PingFangSC-Regular"size:24];
        if (_font == nil) {
            _font = [UIFont systemFontOfSize:24 weight:UIFontWeightLight];
        }
    }
    return _font;
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
