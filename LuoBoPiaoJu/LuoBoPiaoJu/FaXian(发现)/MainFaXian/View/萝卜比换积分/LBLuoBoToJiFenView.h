//
//  LBLuoBoToJiFenView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/11/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBLuoBoToJiFenView : UIView

@property (nonatomic, copy) LBSuccessVoidBlock success;

+ (void)luoBoBiToJiFen:(NSString *)jifen luoBoBi:(NSString *)luoBoBi success:(LBSuccessVoidBlock)success;


@end
