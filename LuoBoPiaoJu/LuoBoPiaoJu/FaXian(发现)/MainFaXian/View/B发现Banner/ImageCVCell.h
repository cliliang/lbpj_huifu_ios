//
//  ImageCVCell.h
//  CollectionViewLearning
//
//  Created by mu-tu on 16/1/25.
//  Copyright © 2016年 PSS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCVCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (nonatomic, strong) LBCycleModel *model;

@end
