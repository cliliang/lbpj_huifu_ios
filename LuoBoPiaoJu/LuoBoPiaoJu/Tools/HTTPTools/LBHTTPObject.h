//
//  LBHTTPObject.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/7/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kAppendingUrl(a) [NSString stringWithFormat:@"%@%@", URL_HOST, a]

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnullability-completeness"
@interface LBHTTPObject : NSObject

/**
 *  修改手势密
 */
+ (void)postWithGesPassword:(NSString  * _Nonnull )gesPW
                     userId:(int)userId
                      token:(NSString * _Nonnull)token
                    success:(SuccessBlock _Nullable)success
                    failure:(ErrorBlock _Nullable)failure;

/**
 *  上传deviceToken
 */
+ (void)POST_uploadDeviceToken;
/**
 *  如果需要, 就调用上传的方法
 */
+ (void)uploadDeviceTokenIfNeed;
+ (void)deleteDeviceToken;

/**
 *  是否有未读消息
 */
+ (void)POST_isHaveNotReadingMess:(void(^ _Nonnull)(NSDictionary *dict))Success;

/**
 *  福利中心优惠券
 */
+ (void)POST_searchBenefitBill:(NSString *)url
                          page:(NSInteger)page
                      pageSize:(NSInteger)pageSize
                    couponType:(NSInteger)couponType
                       success:(SuccessBlock _Nullable)success
                       failure:(ErrorBlock _Nullable)failure;

/**
 *  福利中心优惠券使用记录
 */
+ (void)POST_searchBenefitBill:(NSString *)url
                          page:(NSInteger)page
                      pageSize:(NSInteger)pageSize
                    couponRecType:(NSInteger)couponRecType
                       success:(SuccessBlock _Nullable)success
                       failure:(ErrorBlock _Nullable)failure;


/**
 *  邀请记录，查询所有记录
 */
+ (void)POST_searchAllInvitedListSuccess:(SuccessBlock _Nullable)success
                                 failure:(ErrorBlock _Nullable)failure;

/**
 *  体验金详情接口
 */
+ (void)POST_experienceMoneyDetailSuccess:(SuccessBlock _Nullable)success
                                  failure:(ErrorBlock _Nullable)failure;
/**
 *  体验金购买接口
 */
+ (void)POST_buyExperienceMoneySuccess:(SuccessBlock _Nullable)success
                               failure:(ErrorBlock _Nullable)failure;
/**
 *  签到接口
 */
+ (void)POST_SignInNew;

/**
 *  获取红包列表
 */
+ (void)POST_getHongBaoListSuccess:(SuccessBlock _Nullable)success
                           failure:(ErrorBlock _Nullable)failure;
/**
 *  领取红包
 */
+ (void)POST_getHongBaoMoneyWithVID:(NSInteger)vid
                            Success:(SuccessBlock _Nullable)success
                            failure:(ErrorBlock _Nullable)failure;
/**
 *  发现页列表接口
 */
+ (void)POST_getFaXianListWithContentType:(NSInteger)contentType
                               page:(NSInteger)page
                           pageSize:(NSInteger)pageSize
                            Success:(SuccessBlock _Nullable)success
                            failure:(ErrorBlock _Nullable)failure;
/**
 *  购买页面获取可使用红包
 */
+ (void)POST_getHongBaosInBuyGcId:(NSInteger)gcId
                          Success:(SuccessBlock _Nullable)success
                             failure:(ErrorBlock _Nullable)failure;
/**
 *  领取刮刮乐
 */
+ (void)POST_LingQuGuaGuaLePrizeId:(NSString *)priId
                           Success:(SuccessBlock _Nullable)success
                           failure:(ErrorBlock _Nullable)failure;
/**
 *  更新后台token
 */
+ (void)POST_judgeTokenWithToken:(NSString *)token
                         Success:(SuccessBlock _Nullable)success
                         failure:(ErrorBlock _Nullable)failure;
/**
 *  轮播图接口, 0首页，1发现
 */
+ (void)POST_cycleImageWithActivityType:(NSInteger)activityType
                                Success:(SuccessBlock _Nullable)success
                                failure:(ErrorBlock _Nullable)failure;

/**
 *  签到记录接口
    输入参数：String date(可选参数，当无此参数时查询全部签到记录，有此参数则查询指定时间及3个月之前的签到记录) 例如: 2016-09-12
 */
+ (void)POST_getSignRecordWithDate:(NSString *)date
                           Success:(SuccessBlock _Nullable)success
                           failure:(ErrorBlock _Nullable)failure;

/**
 *  用户是否打开自动签到功能接口, 0关闭, 1打开
 */
+ (void)POST_setSignInAlertState:(BOOL)state
                         Success:(SuccessBlock _Nullable)success
                         failure:(ErrorBlock _Nullable)failure;

/**
 *  查询萝卜币
 */
+ (void)POST_getLuoBoBiCount:(SuccessBlock _Nullable)success
                     failure:(ErrorBlock _Nullable)failure;

/**
 *  兑换萝卜币
 */
+ (void)POST_exchangeLuoboBi:(SuccessBlock _Nullable)success
                     failure:(ErrorBlock _Nullable)failure;

/**
 *  广告页接口
 */
+ (void)POST_guangGaoPage:(SuccessBlock _Nullable)success
                  failure:(ErrorBlock _Nullable)failure;
/**
 *  新活期接口 2.2.6
 */
+ (void)POST_huoQi_2_2_6:(SuccessBlock _Nullable)success
                 failure:(ErrorBlock _Nullable)failure;
/**
 *  最大版本号
 */
+ (void)POST_mostVersion:(SuccessBlock _Nullable)success
                 failure:(ErrorBlock _Nullable)failure;



@end
#pragma clang diagnostic pop
























