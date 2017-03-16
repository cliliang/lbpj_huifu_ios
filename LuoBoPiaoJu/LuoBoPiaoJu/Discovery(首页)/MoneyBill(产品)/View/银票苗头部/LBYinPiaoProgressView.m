//
//  LBYinPiaoProgressView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/12/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBYinPiaoProgressView.h"

@interface LBYinPiaoProgressView ()

@property (nonatomic, strong) UIImageView *imageV_progress;
@property (nonatomic, strong) UIImageView *imageV_point;
@property (nonatomic, strong) UIImageView *imageV_sign;
@property (nonatomic, strong) UILabel *label_baiFenBi;

@end

@implementation LBYinPiaoProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromHexString(@"ff8d78", 1);
        UIImageView *imageV_jianBian = [UIImageView new];
        [self addSubview:imageV_jianBian];
        [imageV_jianBian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(KAutoHDiv2(0));
            make.right.mas_equalTo(self.mas_left).offset(0);
        }];
        
        UIImageView *imageV_point = [[UIImageView alloc] init];
        [self addSubview:imageV_point];
        [imageV_point mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(imageV_jianBian.mas_right);
            make.centerY.mas_equalTo(self);
            make.width.height.mas_equalTo(KAutoHDiv2(28));
        }];
        
        UIImageView *imageV_sign = [UIImageView new];
        [self addSubview:imageV_sign];
        [imageV_sign mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imageV_point.mas_centerX);
            make.bottom.mas_equalTo(imageV_point.mas_top).offset(KAutoHDiv2(-2));
            make.width.mas_equalTo(KAutoHDiv2(60));
            make.height.mas_equalTo(KAutoHDiv2(30));
        }];
        
        UILabel *label_baiFenBi = [UILabel new];
        [label_baiFenBi setText:@"0%" textColor:kNavBarColor font:[UIFont pingfangWithFloat:KAutoHDiv2(20) weight:UIFontWeightLight]];
        [self addSubview:label_baiFenBi];
        [label_baiFenBi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(imageV_sign);
        }];
        
        imageV_jianBian.image = [UIImage imageNamed:@"image_YinPiaoMiaoProgress_pro"];
        imageV_point.image = [UIImage imageNamed:@"image_YinPiaoMiaoProgress_point"];
        imageV_sign.image = [UIImage imageNamed:@"image_YinPiaoMiaoProgress_sign"];
        
        _imageV_sign = imageV_sign;
        _imageV_progress = imageV_jianBian;
        _imageV_point = imageV_point;
        _label_baiFenBi = label_baiFenBi;
    }
    return self;
}
- (void)setProgress:(double)progress
{
    if (progress >= 1) {
        _progress = 1;
    } else if (progress <= 0) {
        _progress = 0;
    } else {
        _progress = progress;
    }
    double imgW = KAutoHDiv2(177);
    double distance = _progress * kYinPiaoProgressWid;
    double width = distance > imgW ? imgW : distance;
    [_imageV_progress mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_left).offset(distance);
        make.width.mas_equalTo(width);
    }];
    _label_baiFenBi.text = kStringFormat(@"%ld%%", (NSInteger)(progress * 100));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
