//
//  LBFeedBackSuccessVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFeedBackSuccessVC.h"

@interface LBFeedBackSuccessVC ()

@end

@implementation LBFeedBackSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navcTitle = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    // 图
    UIImageView *imageV = [UIImageView new];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(KAutoHDiv2(128));
        make.centerX.mas_equalTo(self.view);
    }];
    imageV.image = [UIImage imageNamed:@"image_feedBack"];
    
    // 成功
    UILabel *label1 = [UILabel new];
    [self.view addSubview:label1];
    [label1 setText:@"反馈成功" textColor:kDeepColor font:[UIFont pingfangWithFloat:kDiv2(36) weight:UIFontWeightLight]];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV.mas_bottom).offset(KAutoHDiv2(57));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(kDiv2(36));
    }];
    
    // 描述
    UILabel *label2 = [UILabel new];
    [self.view addSubview:label2];
    [label2 setText:@"感谢您对萝卜票据的关注与支持, 我们会认真处理您的反馈, 尽快修复和完善相关功能。" textColor:kLightColor font:[UIFont pingfangWithFloat:kDiv2(26) weight:UIFontWeightLight]];
    label2.numberOfLines = 0;
    label2.textAlignment = NSTextAlignmentCenter;
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(KAutoHDiv2(41));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_lessThanOrEqualTo(kAutoW(260));
    }];
    [label2 changeLineDistance:5];
    [label2 changeFont:[UIFont pingfangWithFloat:kDiv2(26) weight:UIFontWeightLight]];
    [label2 changeTextColor:kLightColor footLength:label2.text.length];
}
- (void)baseReturn
{
    NSArray *array = self.navigationController.viewControllers;
    LBViewController *toVC = array[array.count - 3];
    [self.navigationController popToViewController:toVC animated:YES];
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
