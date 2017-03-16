//
//  LBBankCardInfoModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBBankCardInfoModel : NSObject

/**
 *  银行卡名字
 */
@property (nonatomic, strong) NSString *bankCardCode;
/**
 *  单笔限额, 目前给的是默认值, 无数据
 */
@property (nonatomic, strong) NSString *danBiXianE;
/**
 *  当日限额, 目前给的是默认值, 无数据
 */
@property (nonatomic, strong) NSString *dangRiXianE;

@end
