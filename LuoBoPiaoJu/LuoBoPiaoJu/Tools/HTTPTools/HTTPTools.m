//
//  HTTPTools.m
//  HTTPTools
//
//  Created by 庞仕山 on 16/5/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "HTTPTools.h"

@interface HTTPTools ()

@end

@implementation HTTPTools

+ (AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传json格式
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // 获取到的数据格式, data
    return manager;
}

+ (void)GETWithUrl:(NSString *)urlString
         parameter:(NSDictionary *)param
          progress:(Progress)progress
           success:(SuccessBlock)success
           failure:(ErrorBlock)failure
{
    AFHTTPSessionManager *manager = [self manager];
    [manager GET:urlString parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(dict, YES);
        } else {
            success(@{@"data":@"没有数据"}, NO);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTWithUrl:(NSString *)urlString
          parameter:(NSDictionary *)param
           progress:(Progress)progress
            success:(SuccessBlock)success
            failure:(ErrorBlock)failure
{
#ifdef DEBUG
    [urlString urlWithParam:param];
#endif
    AFHTTPSessionManager *manager = [self manager];
    static int x = 0; // 总
    static int y = 0;
    x++;
    [manager POST:urlString parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             x--;
            if (success) {
                success(dict, YES);
            }
            if (![NSObject nullOrNilWithObjc:dict] && ![NSObject nullOrNilWithObjc:dict[@"token"]]) {
                if (kUserModel != nil && ![kUserModel.token isEqualToString:dict[@"token"]] && ![urlString containsString:@"mobile/user/judgeToken.do"]) {
                    // 两个不一致
                    kLog(@"UserModel -- 前 = %@", kUserModel.token);
                    LBUserModel *model = kUserModel;
                    NSString *oldToken = model.token;
                    NSString *newToken = dict[@"token"];
                    model.token = newToken;
                    [model saveInPhone];
                    kLog(@"UserModel -- 后 = %@", kUserModel.token);
                    kLog(@"HTTP = %@", dict[@"token"]);
                    y = x;
                    [LBHTTPObject POST_judgeTokenWithToken:newToken Success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
                        kLog(@"验证token的数据 %@", dict);
                        if ([NSObject nullOrNilWithObjc:dict] || [dict[@"success"] boolValue] == NO || successOrNot == NO) {
                            model.token = oldToken;
                            [model saveInPhone];
                            kLog(@"变成了以前的token-- %@", kUserModel.token);
                        } else {
                            kLog(@"不需要变回以前的token --- 成功了 bool = %d", [dict[@"success"] boolValue]);
                        }

                    } failure:^(NSError * _Nonnull error) {
                        model.token = oldToken;
                        [model saveInPhone];
                        kLog(@"error变成了以前的token-- %@", kUserModel.token);
                    }];
                }
            }
            if ([dict[@"flg"] intValue] == -111 && kUserModel != nil && ![urlString isEqualToString:@"mobile/user/judgeToken.do"]) {
                if (y <= 0) {
                    kLog(@"您的账号在其他设备上登录了 ------- %@", urlString);
                    kLog(@"异地登录请求的token - %@", param[@"token"]);
                    [[LBLoginAlert instanceLoginAlertWithTitle:@"提示" message:dict[@"message"]] show];
                    [LBUserModel deleteInPhone];
                    [LBUserModel deleteGesPassword];
                    [LBVCManager hideMessageView];
                } else {
                    y--;
                }
            }
        } else {
            success(@{@"data":@"没有数据"}, NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        kLog(@"请求失败");
        x--;
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POSTWithUrl:(NSString * _Nullable)URLString
         parameters:(_Nullable id)parameters
constructingBodyWithBlock:(void (^ _Nullable)(_Nullable id <AFMultipartFormData> formData))block
           progress:(Progress _Nullable)progress
            success:(SuccessBlock _Nullable)success
            failure:(ErrorBlock _Nullable)failure
{
    AFHTTPSessionManager *manager = [self manager];
    [manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (block) {
            block(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            success(dict, YES);
        } else {
            success(@{@"data":@"没有数据"}, NO);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        kLog(@"请求失败");
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)AFNetworkStatusReachable:(Network)reachable
                    notReachable:(Network)notReachable
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                reachable();
                break;
            case AFNetworkReachabilityStatusNotReachable:
                notReachable();
                break;
                
            default:
                break;
        }
    }];
    [manager startMonitoring];
}



@end










