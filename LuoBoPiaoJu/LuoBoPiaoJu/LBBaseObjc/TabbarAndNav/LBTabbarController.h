//
//  LBTabbarController.h
//  BaLuoBoLiCai
//
//  Created by 庞仕山 on 16/5/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBTabbarController : UITabBarController

- (void)addTabbarItemNavWithClass:(Class)class
                            title:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName
                         adjuestX:(CGFloat)adjuestX;

@end
