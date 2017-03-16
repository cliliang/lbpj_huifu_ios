//
//  LBVipPrivilegeView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBVipPriviBlock)(NSInteger index);

@interface LBVipPrivilegeView : UIView

@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *boolArr;

@property (nonatomic, copy) LBVipPriviBlock vipPrivBlock;
- (void)setVipPrivBlock:(LBVipPriviBlock)vipPrivBlock;

- (void)reloadDataBlocksView;


@end
