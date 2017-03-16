//
//  LBOrderModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBOrderModel : NSObject

//@property (nonatomic, strong) NSString *
//@property (nonatomic, assign) NSInteger
//@property (nonatomic, assign) CGFloat
@property (nonatomic, assign) NSInteger buyOrderId; // -订单id
@property (nonatomic, assign) NSInteger buyOrder; //
@property (nonatomic, assign) NSInteger gId; // -产品ID
@property (nonatomic, assign) NSInteger investTime; // 投资天数
@property (nonatomic, assign)       int gcId;

@property (nonatomic, assign) CGFloat   speedMoney; // -本息
@property (nonatomic, assign) CGFloat   countMoney; // -本金
@property (nonatomic, assign) CGFloat   preProceeds; // -预计收益
@property (nonatomic, assign) CGFloat   sumEarn; // -累计收益

@property (nonatomic, assign) double   cashMoney; // -现金红包
@property (nonatomic, assign) double   principalMoney; // -本金红包


@property (nonatomic, strong) NSString *buyOrderNo; // -订单编号
@property (nonatomic, strong) NSString *buyEndTime; // -结息时间
@property (nonatomic, strong) NSString *endTime; // -结息时间
@property (nonatomic, strong) NSString *createTime; // -创建时间
@property (nonatomic, strong) NSString *startTime; // 起息时间
@property (nonatomic, strong) NSString *goodName; // 产品名称
@property (nonatomic, strong) NSString *proceeds; // 年化利率





@end
