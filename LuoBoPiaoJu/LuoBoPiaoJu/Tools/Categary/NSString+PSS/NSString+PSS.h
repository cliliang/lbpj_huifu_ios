//
//  NSString+PSS.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/6/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PSS)

/**
 *  是否是 26个字母或数字
 *
 *  @return BOOL
 */
- (BOOL)isPassword;

// 单个字符，是否是数字
- (BOOL)isSingleNumber;

// 以get方式拼接url, 测试用
- (NSString *)urlWithParam:(NSDictionary *)param;


@end
