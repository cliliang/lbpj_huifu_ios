//
//  LBUsableHBModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/29.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBUsableHBModel : NSObject

@property (nonatomic, assign) NSInteger couponId; //couponId
@property (nonatomic, assign) NSInteger couponType; // 
@property (nonatomic, strong) NSString *couponTitle;
@property (nonatomic, strong) NSString *couponMoney;
@property (nonatomic, assign) BOOL usingBool;

@end
