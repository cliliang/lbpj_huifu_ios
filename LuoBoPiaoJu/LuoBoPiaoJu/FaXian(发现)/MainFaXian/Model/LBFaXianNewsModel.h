//
//  LBFaXianNewsModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/27.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBFaXianNewsModel : NSObject

@property (nonatomic, strong) NSString *description1;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *newsTitle;
// 新闻ID
@property (nonatomic, assign) NSInteger nId;
// 新闻图片
@property (nonatomic, strong) NSString *newsIcon;

@end
