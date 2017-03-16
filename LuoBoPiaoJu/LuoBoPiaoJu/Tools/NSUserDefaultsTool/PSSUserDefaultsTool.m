//
//  PSSUserDefaultsTool.m
//  baluobolicai
//
//  Created by 庞仕山 on 16/4/25.
//  Copyright © 2016年 BIHUA－PEI. All rights reserved.
//

#import "PSSUserDefaultsTool.h"

@implementation PSSUserDefaultsTool

+ (void)saveValue:(nullable id)value WithKey:(nonnull NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:value forKey:key];
    [userDefaults synchronize];
}

+ (nullable id)getValueWithKey:(nonnull NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults valueForKey:key];
}



@end
