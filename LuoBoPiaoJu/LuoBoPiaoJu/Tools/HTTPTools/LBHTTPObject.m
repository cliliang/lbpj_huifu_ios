//
//  LBHTTPObject.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/7/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBHTTPObject.h"
#import "LBSignInNewView.h"
#define kSignInKey @"LBSignInKey"

@implementation LBHTTPObject

/**
 *  修改手势密
 */
+ (void)postWithGesPassword:(NSString  * _Nonnull )gesPW
                     userId:(int)userId
                      token:(NSString * _Nonnull)token
                    success:(SuccessBlock _Nullable)success
                    failure:(ErrorBlock _Nullable)failure;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_HOST, url_ChangeGesturePassword];
    NSDictionary *param = @{
                            @"userId":@(userId),
                            @"handPassword":gesPW,
                            @"token":token
                            };
    [HTTPTools POSTWithUrl:urlStr parameter:param progress:nil success:success failure:failure];
}

+ (void)POST_uploadDeviceToken
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_HOST, url_Push_UploadDeviceToken];
    LBUserModel *model = [LBUserModel getInPhone];
    NSDictionary *param = @{
                            @"userId":@(model.userId),
                            @"token":model.token,
                            @"deviceToken":[PSSUserDefaultsTool getValueWithKey:kDeviceTokenPath]
                            };
    [HTTPTools POSTWithUrl:urlStr parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        kLineLog(@"%@", @"存deviceToken成功");
    } failure:^(NSError * _Nonnull error) {
        kLineLog(@"%@", @"存deviceToken失败");
    }];
}
+ (void)uploadDeviceTokenIfNeed
{
    NSString *deviceTStr = [PSSUserDefaultsTool getValueWithKey:kDeviceTokenPath];
    BOOL isLogin = ![NSObject nullOrNilWithObjc:kUserModel]; // 登录状态下
    BOOL isToken = ![NSObject nullOrNilWithObjc:deviceTStr]; // deviceToken不为空
    BOOL isdiff = ![kUserModel.deviceToken isEqualToString:deviceTStr];
    if (isLogin && isToken && isdiff) {
        [LBHTTPObject POST_uploadDeviceToken];
    }
}
+ (void)deleteDeviceToken
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", URL_HOST, url_Push_UploadDeviceToken];
    LBUserModel *model = [LBUserModel getInPhone];
    NSDictionary *param = nil;
    if (model != nil) {
        param = @{
                @"userId":@(model.userId),
                @"token":model.token,
                @"deviceToken":@""
                };
        [HTTPTools POSTWithUrl:urlStr parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
            kLineLog(@"删除deviceToken成功");
        } failure:^(NSError * _Nonnull error) {
            kLineLog(@"删除deviceToken失败");
        }];
    }
    
}
+ (void)POST_isHaveNotReadingMess:(void(^ _Nonnull)(NSDictionary *dict))Success
{
    if (kUserModel == nil) {
        return;
    }
    NSString *urlString = kAppendingUrl(url_isHaveNotReadMessage);
    NSDictionary *param = @{
                            @"userId":@(kUserModel.userId),
                            @"token":kUserModel.token
                            };
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if (Success) {
            Success(dict);
        }
    } failure:^(NSError * _Nonnull error) {
        kLog(@"小红点失败");
    }];
}

/**
 *  福利中心优惠券
 */
+ (void)POST_searchBenefitBill:(NSString *)url
                          page:(NSInteger)page
                      pageSize:(NSInteger)pageSize
                    couponType:(NSInteger)couponType
                       success:(SuccessBlock _Nullable)success
                       failure:(ErrorBlock _Nullable)failure
{
    if (kUserModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"uId":@(kUserModel.userId),
                            @"token":kUserModel.token,
                            @"page":@(page),
                            @"pageSize":@(pageSize),
                            @"couponType":@(couponType)
                            };
    [HTTPTools POSTWithUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, url] parameter:param progress:nil success:success failure:failure];
    
}

/**
 *  福利中心优惠券使用记录
 */
+ (void)POST_searchBenefitBill:(NSString *)url
                          page:(NSInteger)page
                      pageSize:(NSInteger)pageSize
                 couponRecType:(NSInteger)couponRecType
                       success:(SuccessBlock _Nullable)success
                       failure:(ErrorBlock _Nullable)failure
{
    if (kUserModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"uId":@(kUserModel.userId),
                            @"token":kUserModel.token,
                            @"page":@(page),
                            @"pageSize":@(pageSize),
                            @"couponReType":@(couponRecType)
                            };
    [HTTPTools POSTWithUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, url] parameter:param progress:nil success:success failure:failure];
}

/**
 *  邀请记录，查询所有记录, 参数是userId和token
 */
+ (void)POST_searchAllInvitedListSuccess:(SuccessBlock _Nullable)success
                                 failure:(ErrorBlock _Nullable)failure
{
//    if (kUserModel == nil) {
//        return;
//    }
    NSDictionary *param = @{
                            @"invitesUserId":@(kUserModel.userId),
                            @"token":kUserModel.token
                            };
    [HTTPTools POSTWithUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, url_searchAllInvitedList] parameter:param progress:nil success:success failure:failure];
}

/**
 *  体验金详情接口
 */
+ (void)POST_experienceMoneyDetailSuccess:(SuccessBlock _Nullable)success
                                  failure:(ErrorBlock _Nullable)failure
{
    NSInteger userId = kUserModel ? kUserModel.userId : 0;
    NSString *token = kUserModel ? kUserModel.token : @"";
    NSDictionary *param = @{
                            @"userId":@(userId),
                            @"token":token
                            };
    [HTTPTools POSTWithUrl:[NSString stringWithFormat:@"%@%@", URL_HOST, url_experienceMoneyDetail] parameter:param progress:nil success:success failure:failure];
}
+ (void)POST_buyExperienceMoneySuccess:(SuccessBlock _Nullable)success
                               failure:(ErrorBlock _Nullable)failure
{
    NSDictionary *param = @{
                            @"uId":@(kUserModel.userId),
                            @"token":kUserModel.token
                            };
    [HTTPTools POSTWithUrl:kStringFormat(@"%@%@", URL_HOST, url_experienctMoneyBuy) parameter:param progress:nil success:success failure:failure];
}

+ (void)POST_SignInNew
{
    if (kUserModel == nil) {
        return;
    }
    NSDate *nowDate = [NSDate date];
    NSTimeInterval nowTimeInt = [nowDate timeIntervalSince1970];
    NSTimeInterval twoTimeInt = [kUserModel.getScoreTime doubleValue];
    BOOL b1 = [NSDate compareOneDayTimeInt1:nowTimeInt timeInt2:twoTimeInt / 1000 + 100]; // 当前时间 = 上次签到时间
    if (!b1) {
        NSDictionary *param = @{
                                @"userId":@(kUserModel.userId),
                                @"token":kUserModel.token
                                };
        [HTTPTools POSTWithUrl:kAppendingUrl(url_signInNew) parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
            if ([dict[@"success"] boolValue]) {
                NSDictionary *rows = dict[@"rows"];
                LBUserModel *model = [LBUserModel mj_objectWithKeyValues:rows];
                [LBUserModel deleteInPhone];
                [model saveInPhone];
                [LBSignInNewView showWithMessage:dict[@"message"]];
            } else {
                kLog(@"%@", dict[@"message"]);
            }
        } failure:^(NSError * _Nonnull error) {
            kLog(@"签到请求失败");
        }];
    }
}

+ (void)POST_getHongBaoListSuccess:(SuccessBlock _Nullable)success
                           failure:(ErrorBlock _Nullable)failure
{
    if (kUserModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"userId":@(kUserModel.userId),
                            @"token":kUserModel.token
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_getHongBaoList) parameter:param progress:nil success:success failure:failure];
}
/**
 *  领取红包
 */
+ (void)POST_getHongBaoMoneyWithVID:(NSInteger)vid
                            Success:(SuccessBlock _Nullable)success
                            failure:(ErrorBlock _Nullable)failure
{
    if (kUserModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"userId":@(kUserModel.userId),
                            @"token":kUserModel.token,
                            @"vipId":@(vid)
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_getHongBaoMoney) parameter:param progress:nil success:success failure:failure];
}
/**
 *  发现页列表接口
 */
+ (void)POST_getFaXianListWithContentType:(NSInteger)contentType
                               page:(NSInteger)page
                           pageSize:(NSInteger)pageSize
                            Success:(SuccessBlock _Nullable)success
                            failure:(ErrorBlock _Nullable)failure
{
    NSDictionary *param = @{
                            @"contentType":@(contentType),
                                @"page":@(page),
                                @"pageSize":@(pageSize)
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_getFaXianList) parameter:param progress:nil success:success failure:failure];
}
/**
 *  购买页面获取可使用红包
 */
+ (void)POST_getHongBaosInBuyGcId:(NSInteger)gcId
                          Success:(SuccessBlock _Nullable)success
                          failure:(ErrorBlock _Nullable)failure
{
    if (kUserModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"gcId":@(gcId),
                            @"userId":@(kUserModel.userId),
                            @"token":kUserModel.token
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_searchUsableHongbao) parameter:param progress:nil success:success failure:failure];
}
/**
 *  领取刮刮乐
 */
+ (void)POST_LingQuGuaGuaLePrizeId:(NSString *)priId
                           Success:(SuccessBlock _Nullable)success
                           failure:(ErrorBlock _Nullable)failure;
{
    NSDictionary *param = @{
                            @"prizeId":priId,
                            @"uId":@(kUserModel.userId),
                            @"token":kUserModel.token
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_lingquGuaGuaLe) parameter:param progress:nil success:success failure:failure];
}
/**
 *  更新后台token
 */
+ (void)POST_judgeTokenWithToken:(NSString *)token
                         Success:(SuccessBlock _Nullable)success
                         failure:(ErrorBlock _Nullable)failure
{
    NSDictionary *param = @{
                            @"userId":@(kUserModel.userId),
                            @"token":token
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_judgeToken) parameter:param progress:nil success:success failure:failure];
}

/**
 *  轮播图接口
 */
+ (void)POST_cycleImageWithActivityType:(NSInteger)activityType
                                Success:(SuccessBlock _Nullable)success
                                failure:(ErrorBlock _Nullable)failure
{
    NSDictionary *param = @{
                            @"activityType":@(activityType)
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_HuoQuShouYeBanner) parameter:param progress:nil success:success failure:failure];
}

/**
 *  签到记录接口
 输入参数：String date(可选参数，当无此参数时查询全部签到记录，有此参数则查询指定时间及3个月之前的签到记录)
 */
+ (void)POST_getSignRecordWithDate:(NSString *)date
                           Success:(SuccessBlock _Nullable)success
                           failure:(ErrorBlock _Nullable)failure
{
    LBUserModel *userModel = kUserModel;
    if (userModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"userId":@(userModel.userId),
                            @"token":userModel.token,
                            @"date":date
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_signInRecord) parameter:param progress:nil success:success failure:failure];
}
/**
 *  用户是否打开自动签到功能接口, 0关闭, 1打开
 */
+ (void)POST_setSignInAlertState:(BOOL)state
                         Success:(SuccessBlock _Nullable)success
                         failure:(ErrorBlock _Nullable)failure
{
    LBUserModel *userModel = kUserModel;
    if (userModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"userId":@(userModel.userId),
                            @"token":userModel.token,
                            @"isOpenSignIn":@(state)
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_setSignInAlert) parameter:param progress:nil success:success failure:failure];
}


/**
 *  查询萝卜币
 */
+ (void)POST_getLuoBoBiCount:(SuccessBlock _Nullable)success
                     failure:(ErrorBlock _Nullable)failure
{
    LBUserModel *userModel = kUserModel;
    if (userModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"uId":@(userModel.userId),
                            @"token":userModel.token
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_getLuoboBiCount) parameter:param progress:nil success:success failure:failure];
}
/**
 *  兑换萝卜币
 */
+ (void)POST_exchangeLuoboBi:(SuccessBlock _Nullable)success
                     failure:(ErrorBlock _Nullable)failure
{
    LBUserModel *userModel = kUserModel;
    if (userModel == nil) {
        NSError *error;
        failure(error);
        return;
    }
    NSDictionary *param = @{
                            @"uId":@(userModel.userId),
                            @"token":userModel.token
                            };
    [HTTPTools POSTWithUrl:kAppendingUrl(url_exchangeLuoboBi) parameter:param progress:nil success:success failure:failure];
}
/**
 *  广告页接口
 */
+ (void)POST_guangGaoPage:(SuccessBlock _Nullable)success
                  failure:(ErrorBlock _Nullable)failure
{
    NSDictionary *param = @{};
    [HTTPTools POSTWithUrl:kAppendingUrl(url_guangGaoImageUrl) parameter:param progress:nil success:success failure:failure];
}
/**
 *  新活期接口 2.2.6
 */
+ (void)POST_huoQi_2_2_6:(SuccessBlock _Nullable)success
                 failure:(ErrorBlock _Nullable)failure
{
    NSDictionary *param = @{};
    [HTTPTools POSTWithUrl:kAppendingUrl(url_HuoQi_2_2_6) parameter:param progress:nil success:success failure:failure];
}

/**
 *  最大版本号
 */
+ (void)POST_mostVersion:(SuccessBlock _Nullable)success
                 failure:(ErrorBlock _Nullable)failure
{
    NSDictionary *param = @{};
    [HTTPTools POSTWithUrl:kAppendingUrl(url_appStoreVersion) parameter:param progress:nil success:success failure:failure];
}


@end














