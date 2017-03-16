//
//  NSString+PSS.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "NSString+PSS.h"

@implementation NSString (PSS)

- (NSString *)urlWithParam:(NSDictionary *)param
{
    if (param == nil || param.count == 0 || [param isKindOfClass:[NSNull class]]) {
        kLog(@"%@", self);
        return self;
    } else {
        
        __block NSString *url = self;
        __block int i = 0;
        [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (i == 0) {
                url = [NSString stringWithFormat:@"%@?%@=%@", url, key, obj];
            } else {
                url = [NSString stringWithFormat:@"%@&%@=%@", url, key, obj];
            }
            i++;
        }];
        kLog(@"%@", url);
        return url;
    }
}
- (BOOL)isSingleNumber
{
    if (self.length == 1) {
        const char *letters = [self UTF8String];
        if (*letters >= '0' && *letters <= '9') {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
    
}
- (BOOL)isPassword
{
    if (self == nil || self.length == 0) {
        return YES;
    }
    if (self.length > 1) {
        return NO;
    }
    const char *letters = [self UTF8String];
    if (strlen(letters) == 1) {
        if ((*letters >= '0' && *letters <= '9') || (*letters >= 'a' && *letters <= 'z') || (*letters >= 'A' && *letters <= 'Z')) {
            return YES;
        }
    }
    return NO;
}

@end
