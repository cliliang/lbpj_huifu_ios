//
//  LBMessageCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBMessageCell.h"

@interface LBMessageCell ()

@property (weak, nonatomic) IBOutlet UIView *view_Background;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet UIImageView *imgV_sign; // 右边的图标

@end

@implementation LBMessageCell

- (void)addGestureInImageView
{
    _imgV_sign.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSignImage)];
    [_imgV_sign addGestureRecognizer:tapGesture];
    
}
- (void)clickSignImage
{
    kLog(@"点击message页面图标了");
}

- (void)setModel:(LBMessageModel *)model
{
    _model = model;
    self.label_title.text = model.title;
    self.label_time.text = model.createTime;
    self.label_content.text = model.messDesc;
    kLog(@"%d", model.seenType);
    if (model.seenType) { // 已读
        [self textColorWithColor:kLightColor];
    } else {
        [self textColorWithColor:[UIColor blackColor]];
    }
    kLog(@"model.messType = %d", model.messType);
    BOOL showAss = NO;
    if (model.messType >= 2 && model.messType <= 4) {
        showAss = YES;
    }
    self.imgV_sign.hidden = !showAss;
}

- (void)textColorWithColor:(UIColor *)color
{
    self.label_title.textColor = color;
    self.label_time.textColor = color;
    self.label_content.textColor = color;
}

- (void)setImageType:(BOOL)imageType
{
    _imageType = imageType;
    if (imageType) { // 展开
//        self.imgV_sign.hidden = NO;
        self.label_content.numberOfLines = 0;
    } else { // 不展开
        self.label_content.numberOfLines = 0;
//        self.imgV_sign.hidden = NO;
    }
}

- (void)awakeFromNib {
    // Initialization code
//    [self addGestureInImageView];
//    self.view_Background.layer.cornerRadius = 3;
    [super awakeFromNib];
    self.label_title.textColor = kDeepColor;
    self.label_content.textColor = kLightColor;
    self.label_time.textColor = kLightColor;
    self.view_Background.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = kBackgroundColor;
    _imgV_sign.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
