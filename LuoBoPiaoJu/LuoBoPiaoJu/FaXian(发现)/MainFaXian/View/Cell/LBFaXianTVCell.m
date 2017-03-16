//
//  LBFaXianTVCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFaXianTVCell.h"
#import <UIImageView+AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation LBFaXianTVCell

- (void)awakeFromNib {
    // Initialization code
    [self.label_content changeLineDistance:5];
    self.label_content.lineBreakMode = NSLineBreakByTruncatingTail;
    self.imageV.backgroundColor = kNavBarColor;
    self.imageV.layer.masksToBounds = YES;
    [self.imageV becomeCircleWithR:4];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kBackgroundColor;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(LBFaXianNewsModel *)model
{
    _model = model;
    _label_data.text = model.createTime ? model.createTime : @"";
    _label_title.text = model.newsTitle ? model.newsTitle : @"";
    _label_content.text = ![NSObject nullOrNilWithObjc:model.description1] ? model.description1 : @"";
    [_imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_HOST, model.newsIcon]] placeholderImage:[UIImage imageNamed:@"image_placeHolder"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
