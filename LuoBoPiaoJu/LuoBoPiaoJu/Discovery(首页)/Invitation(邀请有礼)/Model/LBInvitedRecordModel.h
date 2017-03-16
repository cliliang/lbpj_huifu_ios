//
//  LBInvitedRecordModel.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/22.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBInvitedRecordModel : NSObject

@property (nonatomic, assign) NSInteger inviteReId;
@property (nonatomic, assign) long long createTime;
@property (nonatomic, assign) NSInteger couponMoney;
@property (nonatomic, strong) NSString *invitedMobile;
@property (nonatomic, strong) NSString *inviteDesc;

@end
