//
//  LBHongBaoModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBHongBaoModel : NSObject

@property (nonatomic, assign) NSInteger vid;
@property (nonatomic, assign) NSInteger vmoney;
/**
 *  0 现金红包 1 本金红包 2 体验金券
 */
@property (nonatomic, assign) NSInteger vtype;
/**
 *  0未领取 1已领取 2等级不够
 */
@property (nonatomic, assign) NSInteger gtype;

/**
 *  最低领取等级
 */
@property (nonatomic, assign) NSInteger vlevel;

@end















