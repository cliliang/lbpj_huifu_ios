//
//  LBAccountSecurityCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBAccountSecurityCell.h"

@implementation LBAccountSecurityCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kLineColor;
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(0.5);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setLinePosition:(LBLinePosition)linePosition
{
    _linePosition = linePosition;
    if (linePosition == LBLinePositionTop) {
        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(0.5);
            make.centerX.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView);
        }];
    } else {
        [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(0.5);
            make.centerX.mas_equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView);
        }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.lineView.backgroundColor = kLineColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
