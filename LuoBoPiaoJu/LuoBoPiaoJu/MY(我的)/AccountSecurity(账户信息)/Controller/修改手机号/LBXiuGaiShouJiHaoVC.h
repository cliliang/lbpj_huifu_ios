//
//  LBXiuGaiShouJiHaoVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"

typedef void(^LBXiuGaiPhoneNumberBlock)(void);

@interface LBXiuGaiShouJiHaoVC : LBViewController

@property (nonatomic, copy) LBXiuGaiPhoneNumberBlock xiuGaiPhoneNumberBlock;
- (void)setXiuGaiPhoneNumberBlock:(LBXiuGaiPhoneNumberBlock)xiuGaiPhoneNumberBlock;

@end
