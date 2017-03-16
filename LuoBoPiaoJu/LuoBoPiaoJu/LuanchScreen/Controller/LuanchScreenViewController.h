//
//  LuanchScreenViewController.h
//  baluobo
//
//  Created by BIHUA－PEI on 15/10/20.
//  Copyright © 2015年 BIHUA－PEI. All rights reserved.
//  引导页

#import <UIKit/UIKit.h>

typedef void(^CheckNextBlock)(void);

@interface LuanchScreenViewController : UIViewController

@property (nonatomic, copy) CheckNextBlock nextBlock; // 传递点击方法

- (void)setNextBlock:(CheckNextBlock)nextBlock;

@end
