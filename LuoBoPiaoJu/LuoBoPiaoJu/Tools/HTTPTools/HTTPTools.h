//
//  HTTPTools.h
//  HTTPTools
//
//  Created by 庞仕山 on 16/5/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  封装AFNetworking, 需要AFN 3.1

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define kTimeOutInterval 30 // 请求超时时间
typedef void(^SuccessBlock)(NSDictionary * _Nonnull dict, BOOL successOrNot);
typedef void(^ErrorBlock)( NSError * _Nonnull error);
typedef void(^Progress)(CGFloat progress);
typedef void(^Network)(void);

@interface HTTPTools : NSObject

/**
 *  普通get请求
 *
 *  @param urlString url
 *  @param param     携带参数
 *  @param progress  加载进程 0-1
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)GETWithUrl:(NSString * _Nullable)urlString
         parameter:(NSDictionary * _Nullable )param
          progress:(Progress _Nullable)progress
           success:(SuccessBlock _Nullable)success
           failure:(ErrorBlock _Nullable)failure;

/**
 *  普通post请求
 *
 *  @param urlString url
 *  @param param     携带参数
 *  @param progress  加载进程 0-1
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+ (void)POSTWithUrl:(NSString * _Nullable)urlString
          parameter:(NSDictionary * _Nullable)param
           progress:(Progress _Nullable)progress
            success:(SuccessBlock _Nullable)success
            failure:(ErrorBlock _Nullable)failure;

/**
 *  POST请求 -- 上传
 *
 *  @param URLString      url
 *  @param parameters     参数
 *  @param block          拼接block
 *  @param uploadProgress 上传进程
 *  @param success        成功回调
 *  @param failure        失败回调
 */
+ (void)POSTWithUrl:(NSString * _Nullable)URLString
         parameters:(_Nullable id)parameters
 constructingBodyWithBlock:(void (^ _Nullable)(_Nullable id <AFMultipartFormData> formData))block
           progress:(Progress _Nullable)progress
            success:(SuccessBlock _Nullable)success
            failure:(ErrorBlock _Nullable)failure;


/**
 *  判断网络状态
 *
 *  @param reachable    有网
 *  @param notReachable 没网
 */
+ (void)AFNetworkStatusReachable:(Network _Nullable)reachable
           notReachable:(Network _Nullable)notReachable;


@end






















