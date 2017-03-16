//
//  LBUserModel.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBUserModel.h"
#import "PSSUserDefaultsTool.h"
#import "CoreLockConst.h"

#define kUserModelPath @"userModelPath.da"
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

@implementation LBUserModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    kLog(@"未找到key -- %@", key);
}

// 归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *strName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivars);
}

// 反归档
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *strName = [NSString stringWithUTF8String:name];
//            BOOL b1 = [strName isEqualToString:@"_yesterdayIncome"];
            BOOL b2 = [strName isEqualToString:@"_experienceIncome"];
            if (b2) {
                continue;
            }
            id value = [aDecoder decodeObjectForKey:strName];
            if ([NSObject nullOrNilWithObjc:value]) {
                continue;
            }
            [self setValue:value forKey:strName];
        }
        free(ivars);
    }
    
    return self;
}

- (void)saveInPhone
{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archivew = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archivew encodeObject:self forKey:@"LBUserModel"];
    [archivew finishEncoding];
    NSString *documentPath = kDocumentPath;
    NSString *dataPath = [documentPath stringByAppendingPathComponent:kUserModelPath];
    [data writeToFile:dataPath atomically:YES];
}

+ (LBUserModel *)getInPhone
{
    NSData *data = [NSData dataWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kUserModelPath]];
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    LBUserModel *userModel = [unArchiver decodeObjectForKey:@"LBUserModel"];
    [unArchiver finishDecoding];
    if (userModel == nil || [userModel isKindOfClass:[NSNull class]] || !userModel.userId) {
        return nil;
    }
    return userModel;
}
+ (void)updateUserWithUserModel:(LBUserBlock)block
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_updateUser];
    LBUserModel *model = [LBUserModel getInPhone];
    if (model == nil || [model isKindOfClass:[NSNull class]]) {
        kLog(@"未登录状态");
        block();
        return;
    }
    NSDictionary *param = @{@"userId":@([LBUserModel getInPhone].userId), @"token":[LBUserModel getInPhone].token};
    [HTTPTools POSTWithUrl:string parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if ([dict[@"success"] boolValue]) {
            [LBUserModel deleteInPhone];
            LBUserModel *model = [LBUserModel mj_objectWithKeyValues:dict[@"rows"]];
            [model saveInPhone];
//            kLog(@"更新用户成功");
            block();
        } else {
//            kLog(@"更新用户失败，删除了用户");
//            [LBUserModel deleteInPhone];
//            [LBUserModel deleteGesPassword];
            block();
        }
    } failure:^(NSError * _Nonnull error) {
        block();
    }];
}
// 返回userModel的 刷新方法
+ (void)refreshUser:(LBReturnUserBlock)block
{
    NSString *string = [NSString stringWithFormat:@"%@%@", URL_HOST, url_updateUser];
    LBUserModel *model = [LBUserModel getInPhone];
    if ([NSObject nullOrNilWithObjc:model]) {
        kLog(@"未登录状态");
        block(nil);
        return;
    }
    NSDictionary *param = @{@"userId":@([LBUserModel getInPhone].userId), @"token":[LBUserModel getInPhone].token};
    [HTTPTools POSTWithUrl:string parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if ([dict[@"success"] boolValue]) {
            [LBUserModel deleteInPhone];
            LBUserModel *model = [LBUserModel mj_objectWithKeyValues:dict[@"rows"]];
            [model saveInPhone];
            //            kLog(@"更新用户成功");
            block(model);
        } else {
            //            kLog(@"更新用户失败，删除了用户");
            //            [LBUserModel deleteInPhone];
            //            [LBUserModel deleteGesPassword];
            block(nil);
        }
    } failure:^(NSError * _Nonnull error) {
        block(nil);
    }];
}

+ (void)deleteInPhone
{
    NSString *deletePath = [kDocumentPath stringByAppendingPathComponent:kUserModelPath];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDelete = [manager removeItemAtPath:deletePath error:nil];
    if (isDelete) {
        [LBHTTPObject deleteDeviceToken];
    }
}
+ (void)deleteGesPassword
{
    [PSSUserDefaultsTool saveValue:@"" WithKey:kGesturePasswordKey];
    [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:NO] WithKey:kFingerLockBool];
}

+ (NSString *)getSecretBankCard
{
    NSString *labelString = @"";
    NSString *bankCard = [LBUserModel getInPhone].bankCard;
    if (bankCard == nil || bankCard.length == 0) {
        return nil;
    }
    labelString = [NSString stringWithFormat:@"%@****%@", [bankCard substringToIndex:4], [bankCard substringFromIndex:bankCard.length - 3]];
    return labelString;
}
+ (NSString *)getSecretUserName
{
    NSString *labelString = @"";
    NSString *name = [LBUserModel getInPhone].userName;
    for (int i = 0; i < name.length; i++) {
        if (i == name.length - 1) {
            labelString = [labelString stringByAppendingString:[name substringWithRange:NSMakeRange(name.length - 1, 1)]];
        } else {
            labelString = [labelString stringByAppendingString:@"*"];
        }
    }
    return labelString;
}
+ (BOOL)boolWithIndexPath:(NSIndexPath *)indexPath section:(CGFloat)section row:(CGFloat)row
{
    if (indexPath.section == section && indexPath.row == row) {
        return YES;
    }
    return NO;
}

@end
