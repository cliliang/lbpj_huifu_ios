//
//  LBSignInView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBSignInView.h"

@interface LBSignInView ()

@property (nonatomic, strong) UIButton *btn;

@end

@implementation LBSignInView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 三个圆
        UIImageView *imageV = [[UIImageView alloc] init];
        [self addSubview:imageV];
//        imageV.backgroundColor = [UIColor orangeColor];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self).offset(10);
            make.left.mas_equalTo(15);
            make.width.and.height.mas_equalTo(18);
        }];
        imageV.image = [UIImage imageNamed:@"icon_faxian111_sign1"];
        
        // 积分btn
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:button1];
        button1.backgroundColor = [UIColor clearColor];
        [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageV).offset(-10);
            make.top.mas_equalTo(imageV).offset(-10);
            make.bottom.mas_equalTo(imageV).offset(10);
            make.right.mas_equalTo(imageV).offset(70);
        }];
        [button1 addTarget:self action:@selector(clickJiFenBtn) forControlEvents:UIControlEventTouchUpInside];
        
        // 积分
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        label.textColor = kNavBarColor;
        label.font = [UIFont systemFontOfSize:11 weight:UIFontWeightLight];
        label.text = @"6积分";
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageV.mas_right).offset(div_2(15));
            make.centerY.mas_equalTo(imageV);
        }];
        _label_jiFen = label;
        
        UIImageView *image_2 = [[UIImageView alloc] init];
        [self addSubview:image_2];
        [image_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageV);
            make.left.mas_equalTo(self).offset(div_2(289));
            make.width.and.height.mas_equalTo(div_2(70));
        }];
        image_2.image = [UIImage imageNamed:@"icon_faxian111_sign2"];
        
        UIImageView *image_3 = [[UIImageView alloc] init];
        [self addSubview:image_3];
        image_3.backgroundColor = [UIColor whiteColor];
        [image_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageV);
            make.left.mas_equalTo(image_2.mas_right).offset(div_2(15));
            make.height.mas_equalTo(div_2(57 * 0.8));
            make.width.mas_equalTo(kDiv2(66 * 0.8));
        }];
        [imageV  becomeCircleWithR:18.0 / 2];
        [image_2 becomeCircleWithR:35.0 / 2];
//        [image_3 becomeCircleWithR:18.0 / 2];
        _myVipImgV = image_3;
        // VIP
        UILabel *label2 = [[UILabel alloc] init];
        [self addSubview:label2];
        [self setlabelPropertyWithLabel:label2 Text:@"VIP" textColor:kNavBarColor fontFloat:12];
        label2.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(image_3.mas_right).offset(div_2(15));
            make.centerY.mas_equalTo(imageV);
        }];
        
        // 签到按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom normalColor:kNavBarColor highColor:kNavBarColor fontSize:12 target:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside title:@"签到"];
        button.titleLabel.text = @"签到";
        [self addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
//        button.layer.borderWidth = 0.5;
//        button.layer.borderColor = kNavBarColor.CGColor;
        [button becomeCircleWithR:4];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageV);
//            make.width.mas_equalTo(div_2(92));
            make.height.mas_equalTo(div_2(48));
            make.right.mas_equalTo(self.mas_right).offset(div_2(-31));
        }];
        _btn = button;
    }
    return self;
}

- (void)clickJiFenBtn
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)clickBtn:(UIButton *)btn
{
    if (self.clickBtnBlock) {
        self.clickBtnBlock(btn);
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

- (void)setSignBtnTitle:(NSString *)signBtnTitle
{
    _signBtnTitle = signBtnTitle;
    _btn.titleLabel.text = signBtnTitle;
    [_btn setTitle:signBtnTitle forState:UIControlStateNormal];
//    _btn.layer.borderColor = [signBtnTitle isEqualToString:@"已签到"] ? [UIColor whiteColor].CGColor : kNavBarColor.CGColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
