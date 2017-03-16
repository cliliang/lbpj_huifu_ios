//
//  LBBankCardInfoModel.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBBankCardInfoModel.h"

@implementation LBBankCardInfoModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (NSString *)danBiXianE
{
    if (_danBiXianE == nil) {
        _danBiXianE = @"5万";
    }
    return _danBiXianE;
}
- (NSString *)dangRiXianE
{
    if (_dangRiXianE == nil) {
        _dangRiXianE = @"10万";
    }
    return _dangRiXianE;
}

@end









