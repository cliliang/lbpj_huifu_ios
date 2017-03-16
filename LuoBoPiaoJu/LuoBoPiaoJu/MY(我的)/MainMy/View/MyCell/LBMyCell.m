//
//  LBMyCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyCell.h"
#define kWidth 15

@implementation LBMyCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.imageV_ass.image = [[UIImage imageNamed:@"icon_wode_ass"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self.messSignV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.imageV_ass.mas_left).offset(-6);
        make.width.and.height.mas_equalTo(kWidth);
    }];
    self.messSignV.hidden = YES;
}

- (UIView *)messSignV
{
    if (!_messSignV) {
        _messSignV = [[UIView alloc] init];
        _messSignV.backgroundColor = kNavBarColor;
        _messSignV.layer.cornerRadius = kWidth * 1.0 / 2;
        [self.contentView addSubview:_messSignV];
        _messLabel = [UILabel new];
        [_messLabel setText:@"" textColor:[UIColor whiteColor] font:[UIFont pingfangWithFloat:9 weight:UIFontWeightLight]];
        [_messSignV addSubview:_messLabel];
        [_messLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_messSignV);
        }];
        [_messLabel becomeCircleWithR:kWidth * 1.0 / 2];
        _messLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messSignV;
}
- (void)setRedCount:(NSInteger)redCount
{
    _redCount = redCount;
    if (redCount > 99) {
        _messLabel.text = @"···";
    } else {
        _messLabel.text = [NSString stringWithFormat:@"%ld", redCount];
    }
//    _messLabel.text = @"99";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
