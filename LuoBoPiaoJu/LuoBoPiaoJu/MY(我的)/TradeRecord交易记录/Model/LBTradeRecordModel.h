//
//  LBTradeRecordModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 balance = "421638.48";
 createTime = 1464143832967;
 flg = 0;
 gcId = 13;
 message = "\U8d4e\U56de";
 money = 20000;
 ordId = 2832;
 tid = 38;
 type = 0;
 uId = 151;
 */
@interface LBTradeRecordModel : NSObject

@property (nonatomic, assign) long long createTime;
@property (nonatomic, assign) CGFloat balance;
@property (nonatomic, assign) CGFloat money;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) int flg;

@end







