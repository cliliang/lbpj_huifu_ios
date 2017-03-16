//
//  LBKuaiZhuanProgressView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/12/22.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBKuaiZhuanProgressView.h"
#import "LBKZMaskingView.h"

@interface LBKuaiZhuanProgressView ()

@property (nonatomic, strong) LBKZMaskingView *maskingView;

@end

@implementation LBKuaiZhuanProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _bgImageV = imageView;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        imageView.image = [UIImage imageNamed:@"bg_kuaiZhuanProgress"];
        
        LBKZMaskingView *maskingV = [[LBKZMaskingView alloc] init];
        [self addSubview:maskingV];
        maskingV.backgroundColor = [UIColor clearColor];
        _maskingView = maskingV;
        [maskingV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).offset(-1);
            make.right.mas_equalTo(self).offset(1);
            make.top.bottom.mas_equalTo(self);
        }];
        
        UIImageView *pointerImgV = [UIImageView new];
        [self addSubview:pointerImgV];
        _pointerImgV = pointerImgV;
        pointerImgV.image = [UIImage imageNamed:@"kuaiZhuan_pointer"];
        [pointerImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(KAutoHDiv2(46));
            make.height.mas_equalTo(KAutoHDiv2(64));
            make.bottom.mas_equalTo(self.mas_centerY).offset(KAutoHDiv2(5));
            make.left.mas_equalTo(self).offset(0);
        }];
    }
    return self;
}

- (void)setProgress:(double)progress
{
    double r = KAutoHDiv2(20) / 2;
    double wid = KAutoHDiv2(660);
    double x;
    double adjust = KAutoHDiv2(-6);
    if (progress <= 0) {
        _progress = 0;
        x = 0;
    } else if (progress >= 1) {
        _progress = 1;
        x = wid;
    } else {
        _progress = progress;
        x = r + _progress * (wid - 2 * r);
    }
    _maskingView.progress = _progress;
    [_pointerImgV mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(x + adjust);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
