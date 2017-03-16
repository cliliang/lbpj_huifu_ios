//
//  LBChanPinDetail.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  产品详情

#import <UIKit/UIKit.h>

@interface LBChanPinDetail : UIView

@property (nonatomic, assign) BOOL isNewHand;

- (instancetype)initWithGCID:(NSInteger)gcId;

@property (nonatomic, strong) NSURL *imgUrl;

@property (nonatomic, strong) NSArray *dataArray;
- (void)refreshThisView;

@end
