//
//  LBFeedBackVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFeedBackVC.h"
#import "LBFeedBackSuccessVC.h"

@interface LBFeedBackVC () <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView_shuru;
@property (weak, nonatomic) IBOutlet UILabel *label_placeHolder;
/**
 *  联系方式下边的白条
 */
@property (weak, nonatomic) IBOutlet UIView *view_white;
@property (weak, nonatomic) IBOutlet UILabel *label_lianxifangshi;
@property (weak, nonatomic) IBOutlet UITextField *tf_lianxifangshiNum;
@property (weak, nonatomic) IBOutlet UILabel *label_feiBiXuan;
@property (weak, nonatomic) IBOutlet UIView *view_collectionBack; // collectionView底下的白条
@property (weak, nonatomic) IBOutlet UILabel *label_ziShuXianZhi; // 字数限制
@property (weak, nonatomic) IBOutlet UIButton *btn_tiJiao;

@property (nonatomic, strong) LBUserModel *userModel;

@property (nonatomic, strong) NSString *nowString; // 记录字符串

@end

@implementation LBFeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kBackgroundColor;
    self.userModel = [LBUserModel getInPhone];
    self.navigationItem.title = @"意见反馈";
    
    [self setFuWenBen];
    self.label_lianxifangshi.textColor = kDeepColor;
    self.label_feiBiXuan.textColor = kLightColor;
    self.btn_tiJiao.backgroundColor = kNavBarColor;
    self.btn_tiJiao.layer.cornerRadius = 5;
//    self.view_collectionBack.hidden = YES;
    
    [self addKefudianhua];
}
// 添加客服电话
- (void)addKefudianhua
{
    UILabel *label1 = [UILabel new];
    [self.view addSubview:label1];
    [label1 setText:@"客服热线:400-825-8626" textColor:kColor_707070 font:[UIFont pingfangWithFloat:kDiv2(30) weight:UIFontWeightLight]];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(KAutoHDiv2(1163 - 128));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(kDiv2(30));
    }];
    label1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickKeFuDianHua)];
    [label1 addGestureRecognizer:tapGes];
    
    UILabel *label2 = [UILabel new];
    [self.view addSubview:label2];
    [label2 setText:@"(周一至周五 9:30-18:00)" textColor:kColor_707070 font:[UIFont pingfangWithFloat:kDiv2(22) weight:UIFontWeightLight]];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(KAutoHDiv2(28));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(kDiv2(22));
    }];
}

- (void)clickKeFuDianHua
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"客服电话" message:@"400-825-8626" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-825-8626"]];
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertC addAction:action_1];
    [alertC addAction:action_2];
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.label_placeHolder.hidden = YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text == nil || textView.text.length == 0) {
        self.label_placeHolder.hidden = NO;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString *string = textView.text;
    if (self.nowString != nil && string.length > 200) {
        string = self.nowString;
        textView.text = string;
    }
    kLog(@"%@", string);
    self.nowString = string;
//    textView.text = string;
//    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:string];
//    [abs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, string.length)];
//    [abs addAttribute:NSForegroundColorAttributeName value:kDeepColor range:NSMakeRange(0, string.length)];
//    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
//    para.lineSpacing = 10;
//    [abs addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, string.length)];
//    textView.attributedText = abs;
    self.label_ziShuXianZhi.text = [NSString stringWithFormat:@"%d/200", (int)textView.text.length];
}



// 富文本行间距
- (void)setFuWenBen
{
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:self.label_placeHolder.text];
    [abs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, self.label_placeHolder.text.length)];
    [abs addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRGBString:@"929292"] range:NSMakeRange(0, self.label_placeHolder.text.length)];
    NSMutableParagraphStyle *para = [[NSMutableParagraphStyle alloc] init];
    para.lineSpacing = 10;
    [abs addAttribute:NSParagraphStyleAttributeName value:para range:NSMakeRange(0, self.label_placeHolder.text.length)];
    self.label_placeHolder.attributedText = abs;
    [self.view bringSubviewToFront:self.label_placeHolder];
}
// 点击提交
- (IBAction)clickTiJiaoButton:(id)sender {
    if (self.textView_shuru.text.length >= 5) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *urlString = [URL_HOST stringByAppendingString:url_shangChuanTuCao];
        NSDictionary *param = @{
                                @"uId":@(self.userModel.userId),
                                @"descContent":self.textView_shuru.text,
                                @"contactWay":self.tf_lianxifangshiNum.text
                                };
        [HTTPTools POSTWithUrl:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nullable formData) {
        
        } progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([NSObject nullOrNilWithObjc:dict]) {
                [self commitFailuer];
                return ;
            }
            
            if ([dict[@"message"] isKindOfClass:[NSNull class]] || dict[@"message"] == nil) {
                [self commitFailuer];
                return;
            }
            [[PSSToast shareToast] showMessage:dict[@"message"]];
            if ([dict[@"success"] boolValue]) {
                [self.navigationController pushViewController:[LBFeedBackSuccessVC new] animated:YES];
            }
            
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    } else {
        [[PSSToast shareToast] showMessage:@"内容至少5个字"];
    }
}

- (void)commitFailuer
{
    [[PSSToast shareToast] showMessage:@"上传失败"];
//    [[LBLoginAlert instanceLoginAlertWithTitle:@"" message:@"上传失败"] show];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length != 0 && textField.text.length >= 40) {
        return NO;
    }
    return YES;
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
