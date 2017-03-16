//
//  LBFaXianBannerView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBClickImageItemBlock)(NSInteger index);

@interface LBFaXianBannerView : UIView

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *modelArr;

@property (nonatomic, copy) LBClickImageItemBlock itemBlock;
- (void)setItemBlock:(LBClickImageItemBlock)itemBlock;


- (void)refreshCollectionV;

@end
