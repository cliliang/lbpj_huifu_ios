//
//  LBMessageModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBMessageModel : NSObject

/**
 *  消息ID
 */
@property (nonatomic, assign) int messId;
/**
 *  消息标题
 */
@property (nonatomic, strong) NSString *title;
/**
 *  消息类型:0公告, 1交易---2.2.2之前
 *  消息跳转类型（messType字段）： 1普通消息(前台点击不可跳转) 2用户投资 3会员特权礼遇 4红包到期
 */
@property (nonatomic, assign) int messType;
/**
 *  创建时间
 */
@property (nonatomic, strong) NSString *createTime;
/**
 *  消息描述
 */
@property (nonatomic, strong) NSString *messDesc;
/**
 *  用户ID
 */
@property (nonatomic, assign) NSInteger uId;
/**
 *  是否阅读
 */
@property (nonatomic, assign) BOOL seenType;


@end
