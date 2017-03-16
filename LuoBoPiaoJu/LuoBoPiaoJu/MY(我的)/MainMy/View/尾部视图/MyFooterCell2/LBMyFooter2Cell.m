//
//  LBMyFooter2Cell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/30.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyFooter2Cell.h"

@interface LBMyFooter2Cell ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *lineView1;

@end

@implementation LBMyFooter2Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kBackgroundColor;
        UIView *bgView = [UIView new];
        bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentView);
            make.width.mas_equalTo(kDiv2(390));
            make.height.mas_equalTo(kDiv2(64));
        }];
        [bgView becomeCircleWithR:4];
        // 图
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.image = [UIImage imageNamed:@"image_wodeFooter_3"];
        [bgView addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(bgView);
            make.left.mas_equalTo(kDiv2(24));
            make.width.height.mas_equalTo(kDiv2(42));
        }];
        
        // 字
        UILabel *label = [UILabel new];
        [label setText:@"客服电话：400-825-8626" textColor:kColor_707070 font:kPingFangFont(12)];
        [bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageV.mas_right).offset(kDiv2(16));
            make.centerY.mas_equalTo(bgView);
        }];
        
        _imageV = imageV;
        _label = label;
        
        // 竖线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithRGBString:@"e3e3e3"];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView.mas_right).offset(-kDiv2(93) / 2);
            make.top.mas_equalTo(self.contentView);
            make.width.mas_equalTo(1);
            make.bottom.mas_equalTo(bgView.mas_top);
        }];
        _lineView = lineView;

        
        UIView *lineView1 = [[UIView alloc] init];
        lineView1.backgroundColor = [UIColor colorWithRGBString:@"e3e3e3"];
        [self.contentView addSubview:lineView1];
        [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(bgView.mas_right).offset(-kDiv2(93) / 2);
            make.top.mas_equalTo(bgView.mas_bottom);
            make.width.mas_equalTo(1);
            make.bottom.mas_equalTo(self.contentView);
        }];
        _lineView1 = lineView1;
        
        [self.contentView bringSubviewToFront:lineView];
    }
    return self;
}

- (void)setHavingLine:(BOOL)havingLine
{
    _havingLine = havingLine;
    _lineView.hidden = !havingLine;
    _lineView1.hidden = !havingLine;
}

- (void)setBottomLine:(BOOL)bottomLine
{
    _bottomLine = bottomLine;
    _lineView1.hidden = !bottomLine;
}



@end
