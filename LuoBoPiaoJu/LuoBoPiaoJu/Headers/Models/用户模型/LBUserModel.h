//
//  LBUserModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  用户信息model -- TUser

#import <Foundation/Foundation.h>
@class LBUserModel;
typedef void(^LBUserBlock)(void);
typedef void(^LBReturnUserBlock)(LBUserModel *userModel);

@interface LBUserModel : NSObject <NSCoding>

/**
 *  用户id
 */
@property (nonatomic, assign) NSInteger userId;
/**
 *  手机号
 */
@property (nonatomic, strong) NSString *mobile;
/**
 *  密码
 */
@property (nonatomic, strong) NSString *passWord;
/**
 *  是否实名认证
 */
@property (nonatomic, assign) NSInteger isAutonym;
/**
 *  名字
 */
@property (nonatomic, strong) NSString *userName;
/**
 *  身份证
 */
@property (nonatomic, strong) NSString *idCard;

/**
 *  头像
 */
@property (nonatomic, strong) NSString *headPic;
/**
 *  备注
 */
@property (nonatomic, strong) NSString *remark;
/**
 * 用户类别0新用户1普通用户2vip用户
 */
@property (nonatomic, assign) int userType;
/**
 *  创建时间
 */
@property (nonatomic, strong)  NSString *createTime;
/**
 *  是否删除 0否 1是
 */
@property (nonatomic, assign)  int isDelete;
/**
 *  用户账户
 */
@property (nonatomic, strong)  NSString *countName;
/**
 *  用户客户号
 */
@property (nonatomic, strong)  NSString *usrCustId;
/**
 *  汇付平台返回交易码
 */
@property (nonatomic, strong)  NSString *trxId;
/**
 *  汇付平台返回交易码
 */
@property (nonatomic, strong)  NSString *respCode;
/**
 *  汇付平台返回交易描述
 */
@property (nonatomic, strong)  NSString *respDesc;
/**
 *  用户所在地
 */
@property (nonatomic, strong)  NSString *userPlace;
/**
 *  用户编号
 */
@property (nonatomic, strong)  NSString *userNo;
/**
 *  是否使用新手优惠券0否1是
 */
@property (nonatomic, assign) int couponFlg;
/**
 *  账户金额
 */
@property (nonatomic, assign) double countMoney;
/**
 *  账户冻结资金
 */
@property (nonatomic, assign) double freezeMoney;
/**
 *  账户可用资金
 */
@property (nonatomic, assign) double enAbleMoney;
/**
 *  累计收益
 */
@property (nonatomic, assign) double sumProceeds;
/**
 *  当前收益
 */
@property (nonatomic, assign) double nowProceeds;
/**
 *  银行卡号
 */
@property (nonatomic, strong) NSString *bankCard;
/**
 *  token
 */
@property (nonatomic, strong) NSString *token;
/**
 *  银行卡名称
 */
@property (nonatomic, strong) NSString *bankCardName;
/**
 *  手势密码
 */
@property (nonatomic, strong) NSString *handPassword;
/**
 *  deviceToken
 */
@property (nonatomic, strong) NSString *deviceToken;
/**
 *  邀请码
 */
@property (nonatomic, strong) NSString *inviteCode;
/**
 *  签到时间，java时间戳
 */
@property (nonatomic, strong) NSString *getScoreTime;
/**
 *  签到积分，java时间戳
 */
@property (nonatomic, strong) NSString *userScore;
/**
 *  是否开启签到提醒
 */
@property (nonatomic, assign) BOOL isOpenSignIn;

// 只用到过一次(也不一定)
@property (nonatomic, assign) CGFloat xsbMoneys; // 新手
@property (nonatomic, assign) CGFloat ypmMoneys; // 银票苗
@property (nonatomic, assign) CGFloat lbdtMoneys; // 萝卜定投
@property (nonatomic, assign) CGFloat lbkzMoneys; // 萝卜快赚
@property (nonatomic, assign) CGFloat yesterdayIncome; // 昨日收益
@property (nonatomic, assign) CGFloat experienceIncome; // 体验金

/**
 *  存到本地
 */
- (void)saveInPhone;
/**
 *  取出数据
 */
+ (LBUserModel *)getInPhone;
/**
 *  删除用户数据
 */
+ (void)deleteInPhone;
/**
 *  更新用户
 */
+ (void)updateUserWithUserModel:(LBUserBlock)block;
+ (void)refreshUser:(LBReturnUserBlock)block;

+ (void)deleteGesPassword;

+ (BOOL)boolWithIndexPath:(NSIndexPath *)indexPath section:(CGFloat)section row:(CGFloat)row;

+ (NSString *)getSecretUserName;
+ (NSString *)getSecretBankCard;





@end
