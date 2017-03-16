//
//  LBYesOrNoAlert.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBYesOrNoAlert.h"

#define kCornerRadios 5

@interface LBYesOrNoAlert ()

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) UILabel *messLabel;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation LBYesOrNoAlert

+ (instancetype)alertWithMessage:(NSString *)message
                       sureBlock:(LBButtonBlock)sureBlock
{
    LBYesOrNoAlert *alert = [[LBYesOrNoAlert alloc] initWithFrame:[UIScreen mainScreen].bounds];
    alert.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    alert.message = message;
    alert.sureButtonBlock = sureBlock;
    return alert;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加图片
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.backgroundColor = [UIColor whiteColor];
        imageV.userInteractionEnabled = YES;
        imageV.layer.masksToBounds = YES;
        imageV.layer.cornerRadius = kCornerRadios;
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(div_2(493));
            make.height.mas_equalTo(div_2(240));
            make.center.mas_equalTo(self);
        }];
        
        // 1
        UIView *view_1 = [[UIView alloc] init];
        view_1.backgroundColor = [UIColor whiteColor];
        view_1.layer.cornerRadius = kCornerRadios;
        [imageV addSubview:view_1];
        [view_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.left.and.right.mas_equalTo(imageV);
            make.bottom.mas_equalTo(imageV.mas_bottom).offset(-51);
        }];
        
        // 添加文本
        UILabel *messageLabel = [[UILabel alloc] init];
        [view_1 addSubview:messageLabel];
        messageLabel.textColor = kDeepColor;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont systemFontOfSize:15];
        messageLabel.numberOfLines = 0;
        _messLabel = messageLabel;
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view_1).offset(15);
            make.right.mas_equalTo(view_1).offset(-15);
            make.center.mas_equalTo(view_1);
        }];
        
        // 横线
        UIView *hengLineView = [[UIView alloc] init];
        hengLineView.backgroundColor = kLineColor;
        [imageV addSubview:hengLineView];
        [hengLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(imageV);
            make.top.mas_equalTo(view_1.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        // 竖线
        UIView *shuLineView = [[UIView alloc] init];
        shuLineView.backgroundColor = kLineColor;
        [imageV addSubview:shuLineView];
        [shuLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(hengLineView.mas_bottom);
            make.bottom.mas_equalTo(imageV);
            make.width.mas_equalTo(1);
            make.centerX.mas_equalTo(imageV);
        }];
        
        // 确定按钮
        UIButton *button_QueDing = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor colorWithRGBString:@"ff6e54"] highColor:[UIColor colorWithRGBString:@"ff6e54"] target:self action:@selector(clickSureButton:) forControlEvents:UIControlEventTouchUpInside title:@"确认"];
        [imageV addSubview:button_QueDing];
        [button_QueDing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(hengLineView.mas_bottom);
            make.left.mas_equalTo(shuLineView.mas_right);
            make.bottom.mas_equalTo(imageV.bottom);
            make.right.mas_equalTo(imageV.right);
        }];
        button_QueDing.layer.cornerRadius = kCornerRadios;
        button_QueDing.titleLabel.font = [UIFont systemFontOfSize:18];
        
        // 取消按钮
        UIButton *button_QuXiao = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor colorWithRGBString:@"3fa7d5"] highColor:[UIColor colorWithRGBString:@"3fa7d5"] target:self action:@selector(clickCancelButton:) forControlEvents:UIControlEventTouchUpInside title:@"取消"];
        [imageV addSubview:button_QuXiao];
        [button_QuXiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.bottom.mas_equalTo(imageV);
            make.top.mas_equalTo(hengLineView.mas_bottom);
            make.right.mas_equalTo(shuLineView.mas_left);
        }];
        button_QuXiao.layer.cornerRadius = kCornerRadios;
        button_QuXiao.titleLabel.font = [UIFont systemFontOfSize:18];
        
    }
    return self;
}


- (IBAction)clickSureButton:(id)sender {
    if (self.sureButtonBlock) {
        self.sureButtonBlock();
    }
    [self removeFromSuperview];
}
- (IBAction)clickCancelButton:(id)sender {
    if (self.noButtonBlock) {
        self.noButtonBlock();
    }
    [self removeFromSuperview];
}
- (void)show
{
    [[UIApplication sharedApplication].delegate.window addSubview:self];
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    _messLabel.text = message;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
