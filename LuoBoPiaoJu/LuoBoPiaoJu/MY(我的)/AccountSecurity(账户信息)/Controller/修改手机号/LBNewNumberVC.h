//
//  LBNewNumberVC.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"

typedef void(^LBNewNumberBlock)(void);

@interface LBNewNumberVC : LBViewController

@property (nonatomic, copy) LBNewNumberBlock newNumberBlock;
- (void)setNewNumberBlock:(LBNewNumberBlock)newNumberBlock;

@end
