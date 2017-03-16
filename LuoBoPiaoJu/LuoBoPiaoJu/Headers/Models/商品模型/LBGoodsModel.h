//
//  LBGoodsModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  商品模型

#import <Foundation/Foundation.h>

#define GCID_YINPIAOMIAO 5
#define GCID_DINGTOU     10
#define GCID_KUAIZHUAN   13

@interface LBGoodsModel : NSObject

@property (nonatomic, strong) NSString *goodName;
@property (nonatomic, strong) NSString *payLabel; // 承兑银行
@property (nonatomic, strong) NSString *goodLabel; // 产品标签

@property (nonatomic, assign) NSInteger backType; // 汇款方式
@property (nonatomic, assign) NSInteger investUnit; // 起投金额
@property (nonatomic, assign) NSInteger investTime; // 投资天数
@property (nonatomic, assign) int gcId;
@property (nonatomic, assign) int buyflg1; // 1:已还款 2:还款中 3:已售罄 4:立即抢购

@property (nonatomic, assign) CGFloat proceeds; // 年化收益
@property (nonatomic, assign) CGFloat buyMoney; // 总金额
@property (nonatomic, assign) double surplusMoney; // 剩余金额/可投金额

@property (nonatomic, assign) NSInteger onLineTimeStamp;
@property (nonatomic, assign) NSInteger buyUserCount; //累计购买人次
@property (nonatomic, assign) NSInteger sumMoney; // 累计交易金额

@property (nonatomic, strong) NSString *bankName; // -由payLabel 前去3 后去2

/**
 *  创建日期/也可能是发售日
 */
@property (nonatomic, strong) NSString *createTime;
/**
 *  上线日期
 */
@property (nonatomic, strong) NSString *onLineTime;
/**
 *  起息时间
 */
@property (nonatomic, strong) NSString *valuesTime;
/**
 *  结息时间
 */
@property (nonatomic, strong) NSString *valueTime;
/**
 *  到账时间
 */
@property (nonatomic, strong) NSString *valuedTime;

@property (nonatomic, assign) int goodId;

/**
 *  获得投资天数
 */
- (NSInteger)getInvestDayNum;

@end















