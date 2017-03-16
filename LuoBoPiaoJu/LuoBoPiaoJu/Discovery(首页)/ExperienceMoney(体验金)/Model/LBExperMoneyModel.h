//
//  LBExperMoneyModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/23.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBExperMoneyModel : NSObject

@property (nonatomic, strong) NSString *usrId;
@property (nonatomic, assign) CGFloat proceeds;
@property (nonatomic, assign) NSInteger investTime;
@property (nonatomic, assign) NSInteger goodMoney;
@property (nonatomic, assign) NSInteger goodFlg; // 0可购买, 1不可购买

@end
