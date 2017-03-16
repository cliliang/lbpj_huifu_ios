//
//  LBVipKindsLayout.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBScrollFinishedBlock)(CGPoint position);

@interface LBVipKindsLayout : UICollectionViewFlowLayout

@property (nonatomic, copy) LBScrollFinishedBlock finishedPosition;
- (void)setFinishedPosition:(LBScrollFinishedBlock)finishedPosition;

@end
