//
//  NSObject+PSSObjc.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/27.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PSSObjc)

/**
 *  是nul 或者 nil, 返回yes;
 */
- (BOOL)isNullOrNil;

+ (BOOL)nullOrNilWithObjc:(id)objc;

+ (NSInteger)vipWithMoney:(NSInteger)money;

@end
