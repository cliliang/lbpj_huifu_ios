//
//  PSSToast.h
//  OMGToast
//
//  Created by 庞仕山 on 16/9/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSSToast : UIView

+ (instancetype)shareToast;

- (void)showMessage:(NSString *)message;

@end
