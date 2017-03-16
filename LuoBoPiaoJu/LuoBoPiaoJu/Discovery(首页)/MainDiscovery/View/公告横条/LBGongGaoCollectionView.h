//
//  LBGongGaoCollectionView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBButtonBlock)(void);

@interface LBGongGaoCollectionView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) UILabel *imageLabel; // svg
@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, copy) LBButtonBlock buttonBlock;
- (void)setButtonBlock:(LBButtonBlock)buttonBlock;

- (void)reloadGongGaoData;

@end




