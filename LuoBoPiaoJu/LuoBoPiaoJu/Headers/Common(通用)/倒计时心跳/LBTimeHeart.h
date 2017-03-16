//
//  LBTimeHeart.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/11/21.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBTimeHeart : NSObject

@property (nonatomic, assign) BOOL timeRun;
@property (nonatomic, assign) BOOL networking;

+ (instancetype)shareTime;

@end
