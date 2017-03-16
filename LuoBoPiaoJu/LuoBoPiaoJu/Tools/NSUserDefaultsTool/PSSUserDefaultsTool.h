//
//  PSSUserDefaultsTool.h
//  baluobolicai
//
//  Created by 庞仕山 on 16/4/25.
//  Copyright © 2016年 BIHUA－PEI. All rights reserved.
//  

#import <Foundation/Foundation.h>

@interface PSSUserDefaultsTool : NSObject

+ (void)saveValue:(nullable id)value WithKey:(nonnull NSString *)key;

+ (nullable id)getValueWithKey:(nonnull NSString *)key;

@end
