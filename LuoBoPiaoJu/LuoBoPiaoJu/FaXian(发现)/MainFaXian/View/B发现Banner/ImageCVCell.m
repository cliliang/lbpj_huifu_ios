//
//  ImageCVCell.m
//  CollectionViewLearning
//
//  Created by mu-tu on 16/1/25.
//  Copyright © 2016年 PSS. All rights reserved.
//

#import "ImageCVCell.h"

@interface ImageCVCell ()



@end

@implementation ImageCVCell

- (void)awakeFromNib {
    // Initialization code
//    self.imageV.backgroundColor = kNavBarColor;
    [self.imageV becomeCircleWithR:4];
    self.imageV.layer.masksToBounds = YES;
//    self.imageV.layer.cornerRadius = 5;
//    self.imageV.layer.borderWidth = 1;
//    self.imageV.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setModel:(LBCycleModel *)model
{
    _model = model;
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", URL_HOST, model.activityScrollPic]];
    [self.imageV sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"image_placeHolder"]];
}

@end
