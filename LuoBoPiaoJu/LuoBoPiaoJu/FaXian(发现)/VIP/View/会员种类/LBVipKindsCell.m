//
//  LBVipKindsCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBVipKindsCell.h"

@implementation LBVipKindsCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        _myImageV = [[UIImageView alloc] init];
        [self.contentView addSubview:_myImageV];
        [_myImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView).offset(-kDiv2(6));
            make.width.mas_equalTo(_imageV.mas_width).multipliedBy(72.0 / 93.0);
            make.height.mas_equalTo(_myImageV.mas_width).multipliedBy(18.0 / 72.0);
            make.centerX.mas_equalTo(self.contentView);
        }];
        _myImageV.image = [UIImage imageNamed:@"vip_myVip"];
        _myImageV.hidden = YES;
    }
    return self;
}


@end










