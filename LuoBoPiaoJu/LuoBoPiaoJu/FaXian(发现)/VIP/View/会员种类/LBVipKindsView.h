//
//  LBVipKindsView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBVipKindsSelectedBlock)(NSInteger index);

@interface LBVipKindsView : UIView

@property (nonatomic, assign) NSInteger myVipGrade; // 会员等级
@property (nonatomic, strong) UICollectionView *collectionView;



@property (nonatomic, copy) LBVipKindsSelectedBlock selectedBlock;
- (void)setSelectedBlock:(LBVipKindsSelectedBlock)selectedBlock;

@end
