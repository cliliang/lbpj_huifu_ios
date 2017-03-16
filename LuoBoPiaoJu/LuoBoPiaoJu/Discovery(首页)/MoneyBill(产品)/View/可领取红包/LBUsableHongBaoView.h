//
//  LBUsableHongBaoView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/29.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellHeight 143

@class LBUsableHongBaoCell;
typedef void(^LBClickItemBlock)(NSInteger index, LBUsableHongBaoCell *cell);

@interface LBUsableHongBaoView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) LBClickItemBlock clickItem;
- (void)setClickItem:(LBClickItemBlock)clickItem;

@end
