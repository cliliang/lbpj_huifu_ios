//
//  LBImportantHolidayView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/1.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBImportantHolidayView : UIView

@property (nonatomic, copy) LBSuccessVoidBlock successBlock;
- (void)setSuccessBlock:(LBSuccessVoidBlock)successBlock;

+ (instancetype)showWithImgUrl:(NSString *)imgUrl success:(LBSuccessVoidBlock)success;

@end
