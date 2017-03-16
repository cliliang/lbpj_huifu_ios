//
//  LBGetHongBaoView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBClickHBBlock)(NSInteger index);

@interface LBGetHongBaoView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, copy) LBClickHBBlock clickBlock;
- (void)setClickBlock:(LBClickHBBlock)clickBlock;

@end
