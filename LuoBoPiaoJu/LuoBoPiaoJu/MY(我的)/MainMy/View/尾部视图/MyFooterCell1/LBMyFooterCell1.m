//
//  LBMyFooterCell1.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/30.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMyFooterCell1.h"

@interface LBMyFooterCell1 ()

@property (nonatomic, strong) UIView *lineView;
//@property (nonatomic, strong) UIView *pointView;

@end

@implementation LBMyFooterCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = kBackgroundColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // bgView
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.width.mas_equalTo(kDiv2(390));
            make.height.mas_equalTo(kDiv2(kCell1Height));
        }];
        // image1
        UIImageView *imageV1 = [[UIImageView alloc] init];
        imageV1.image = [UIImage imageNamed:@"image_wodeFooter_2"];
        [view addSubview:imageV1];
        // image2
        UIImageView *imageV2 = [[UIImageView alloc] init];
        imageV2.image = [UIImage imageNamed:@"image_wodeFooter_1"];
        [view addSubview:imageV2];
        [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view);
            make.right.mas_equalTo(view);
            make.width.mas_equalTo(kDiv2(93));
            make.height.mas_equalTo(kDiv2(93));
        }];
        [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(view);
            make.left.mas_equalTo(view);
            make.height.mas_equalTo(kDiv2(93));
            make.right.mas_equalTo(imageV2.mas_left).offset(-kDiv2(23));
        }];
        // 文字
        UILabel *label1 = [[UILabel alloc] init];
        [label1 setText:@"如果您需要帮助\r\n  请点击我哦！" textColor:kColor_707070 font:kPingFangFont(12)];
        [imageV1 addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(imageV1);
        }];
        label1.numberOfLines = 0;
        label1.textAlignment = NSTextAlignmentCenter;
        [label1 changeFont:kPingFangFont(12)];
        [label1 changeLineDistance:2];
        [label1 changeTextColor:kColor_707070 range:NSMakeRange(0, label1.text.length)];
        
        // 竖线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithRGBString:@"e3e3e3"];
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(imageV2);
            make.top.mas_equalTo(imageV2.mas_bottom);
            make.width.mas_equalTo(1);
            make.bottom.mas_equalTo(self.contentView);
        }];
        [self.contentView sendSubviewToBack:lineView];
        // 点
//        UIView *dianView = [[UIView alloc] init];
//        dianView.backgroundColor = kLightColor;
//        [self.contentView addSubview:dianView];
//        [dianView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(lineView);
//            make.top.mas_equalTo(lineView).offset(kDiv2(45));
//            make.width.height.mas_equalTo(3);
//        }];
//        [dianView becomeCircleWithR:1.5];
        
//        _pointView = dianView;
        _lineView = lineView;
        
        lineView.hidden = YES;
//        dianView.hidden = YES;
        
    }
    return self;
}

- (void)setHavingLine:(BOOL)havingLine
{
    _havingLine = havingLine;
    _lineView.hidden = !havingLine;
//    _pointView.hidden = !havingLine;
}

@end













