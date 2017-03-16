//
//  LBBenefitCenterCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBBenefitCenterCell.h"

@interface LBBenefitCenterCell ()

@property (nonatomic, strong) UILabel *label_money;
@property (nonatomic, strong) UILabel *label_typeName;
@property (nonatomic, strong) UILabel *label_desc;
@property (nonatomic, strong) UILabel *label_time;
@property (nonatomic, strong) UIImageView *image_using;
@property (nonatomic, strong) UILabel *label_111;

// 线
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LBBenefitCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        UIImageView *imageV1 = [[UIImageView alloc] init];
        _imageV1 = imageV1;
        [self.contentView addSubview:imageV1];
        [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(15);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.bottom.mas_equalTo(self.contentView).offset(0);
            make.width.mas_equalTo(imageV1.mas_height);
        }];
        imageV1.image = [UIImage imageNamed:@"wode_fulizhongxin_1"];
        
        UIImageView *imageV2 = [[UIImageView alloc] init];
        _imageV2 = imageV2;
        [self.contentView addSubview:imageV2];
        [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageV1.mas_right);
            make.top.bottom.mas_equalTo(imageV1);
            make.right.mas_equalTo(self.contentView).offset(-15);
        }];
        imageV2.image = [UIImage imageNamed:@"wode_fulizhongxin_2"];
        
        
        
        // money
        UILabel *label2 = [[UILabel alloc] init];
        [self.contentView addSubview:label2];
        [label2 setText:@"10" textColor:kNavBarColor font:[UIFont systemFontOfSize:kDiv2(72)]];
        [label2 pingFangFont:36];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageV1);
            make.centerX.mas_equalTo(imageV1);
            make.height.mas_equalTo(kDiv2(72));
        }];
        
        // ¥
        UILabel *label1 = [[UILabel alloc] init];
        [self.contentView addSubview:label1];
        [label1 setText:@"¥" textColor:kNavBarColor font:[UIFont systemFontOfSize:11]];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(label2.mas_top).offset(2);
            make.right.mas_equalTo(label2.mas_left).offset(2);
            make.height.mas_equalTo(11);
        }];
        
        // 红包
        UILabel *label3 = [[UILabel alloc] init];
        [self.contentView addSubview:label3];
        [label3 setText:@"红包" textColor:kNavBarColor font:[UIFont systemFontOfSize:12]];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label2.mas_bottom).offset(kDiv2(4));
            make.centerX.mas_equalTo(imageV1);
            make.height.mas_equalTo(kDiv2(24));

        }];
        
        // 描述
        UILabel *label4 = [UILabel new];
        [label4 setText:@"邀请送10元现金，投资满1元，即可自动使用。\r\n有效期至：2016-06-30" textColor:kLightColor font:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:label4];
        [label4 fuLiZhongXinDescription];
        
        label4.numberOfLines = 0;
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageV2);
            make.left.mas_equalTo(imageV2).offset(KAutoWDiv2(30));
            make.right.mas_equalTo(imageV2).offset(-KAutoWDiv2(30));
        }];
        
//        // 时间
//        UILabel *label5 = [UILabel new];
//        [self.contentView addSubview:label5];
//        [label5 setText:@"time:time:time" textColor:kDeepColor font:[UIFont systemFontOfSize:13]];
//        [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(label4.mas_bottom);
//            make.left.mas_equalTo(label4);
//        }];
        
        // 已使用、已过期。。。
        UIImageView *imageV_using = [[UIImageView alloc] init];
        [imageV2 addSubview:imageV_using];
        [imageV_using mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(imageV2).offset(-KAutoWDiv2(23));
            make.bottom.mas_equalTo(imageV2).offset(-div_2(20));
        }];
        _image_using = imageV_using;
        
        // 添加分界线, 默认隐藏
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = kLightColor;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(15);
            make.left.mas_equalTo(self.contentView).offset(15);
            make.right.mas_equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(0.5);
        }];
        lineView.hidden = YES;
        _lineView = lineView;
        
        _label_money = label2;
        _label_typeName = label3;
        _label_desc = label4;
        _label_111 = label1;
//        _label_time = label5;
        
    
    }
    return self;
}

- (void)setBenefitModel:(LBBenefitModel *)benefitModel
{
    _benefitModel = benefitModel;
    _label_money.text = [NSString stringWithFormat:@"%ld", (long)benefitModel.couponMoney];
    _image_using.image = nil;
    
    NSString *descStr = benefitModel.couponDesc ? benefitModel.couponDesc : @"";
    NSString *timeStr = benefitModel.endTime;
    NSString *descText = [NSString stringWithFormat:@"%@\r\n有效期至：%@",  descStr, timeStr];

    switch (benefitModel.couponType) {
        case 0: {
            _label_typeName.text = @"现金红包";
            break;
        }
        case 1: {
            _label_typeName.text = @"本金红包";
            descText = [descText stringByAppendingString:@"\r\n投资需≥100元可使用"];
            break;
        }
        case 2: {
            _label_typeName.text = @"体验金券";
            break;
        }
        default:
            break;
    }
    
    _label_desc.text = descText;
    if (benefitModel.state == 0) { // 未使用
        _image_using.image = [UIImage new];
        [self changeColor:kNavBarColor];
    } else if (benefitModel.state == 1) { // 已使用
        NSString *discText = [NSString stringWithFormat:@"%@\r\n使用日期：%@",  descStr, timeStr];
        if (_benefitModel.couponType == 1) {
            discText = [discText stringByAppendingString:@"\r\n投资需≥100元可使用"];
        }
        _label_desc.text = descText;
        _image_using.image = [UIImage imageNamed:@"img_Benefit_used"];
        [self changeColor:kLightColor];
    } else if (benefitModel.state == 2) { // 已过期
        _image_using.image = [UIImage imageNamed:@"img_Benefit_timeOut"];
        [self changeColor:kLightColor];
    }
}
- (void)changeColor:(UIColor *)color
{
    _label_111.textColor = color;
    _label_money.textColor = color;
    _label_typeName.textColor = color;
    
    NSString *str = _label_desc.text;
    int len = _benefitModel.couponType == 1 ? 13 + 15 : 15;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = NSMakeRange(str.length - len, len);
    if (range.length + range.location < str.length + 1 && str.length > len) {
        [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setLineSpacing:10];
    [attrStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, str.length)];
    _label_desc.attributedText = attrStr;
}
- (void)setBenefitRecModel:(LBBebefitRecordModel *)benefitRecModel
{
    _benefitRecModel = benefitRecModel;
    _label_money.text = [NSString stringWithFormat:@"%ld", (long)benefitRecModel.couponMoney];
    switch (benefitRecModel.couponReType) {
        case 0: {
            _label_typeName.text = @"已使用";
            _image_using.image = [UIImage imageNamed:@"img_Benefit_used"];
            break;
        }
        case 1: {
            _label_typeName.text = @"已过期";
            _image_using.image = [UIImage imageNamed:@"img_Benefit_timeOut"];
            break;
        }
        default:
            break;
    }
    NSString *descStr = benefitRecModel.couponReDesc ? benefitRecModel.couponReDesc : @"";
    NSString *timeStr = benefitRecModel.createTime;
    _label_desc.text = [NSString stringWithFormat:@"%@\r\n使用时间：%@",  descStr, timeStr];
    [_label_desc fuLiZhongXinDescription];
}

- (void)setSpace:(BOOL)space
{
    _space = space;
    if (space) {
        _lineView.hidden = NO;
        [_imageV1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(30);
        }];
    } else {
        _lineView.hidden = YES;
        [_imageV1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(15);
        }];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
