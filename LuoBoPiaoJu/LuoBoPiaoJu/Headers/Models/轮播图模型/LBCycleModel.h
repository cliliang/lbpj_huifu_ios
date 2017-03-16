//
//  LBCycleModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBCycleModel : NSObject
/**
 *  跳转的url
 */
@property (nonatomic, strong) NSString *activityUrl;
@property (nonatomic, strong) NSString *activityPic;
/**
 *  拼接HOST，为图片url
 */
@property (nonatomic, strong) NSString *activityScrollPic;
@property (nonatomic, strong) NSString *activityTitle;

@end
