//
//  LBGongGaoModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBGongGaoModel : NSObject

@property (nonatomic, strong) NSString *newsGuide; // 
@property (nonatomic, strong) NSString *newsTitle; // 标题
@property (nonatomic, strong) NSString *createTime; // 创建时间
@property (nonatomic, strong) NSString *newsContent; // 内容
@property (nonatomic, assign) int nId;

@end
