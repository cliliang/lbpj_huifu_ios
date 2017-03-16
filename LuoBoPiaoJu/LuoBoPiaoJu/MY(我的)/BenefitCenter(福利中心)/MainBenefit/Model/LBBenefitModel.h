//
//  LBBenefitModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBBenefitModel : NSObject

@property (nonatomic, assign) NSInteger couponMoney;
@property (nonatomic, assign) NSInteger couponType;
@property (nonatomic, strong) NSString *couponDesc;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, assign) NSInteger state; // 0未使用, 1已使用, 2已过期

@end
