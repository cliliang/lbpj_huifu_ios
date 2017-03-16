//
//  LBPointModel.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBPointModel.h"

@implementation LBPointModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)createTime
{
    if (_createTime == nil) {
        return nil;
    }
    return [_createTime substringFromIndex:_createTime.length - 5];
}

@end
