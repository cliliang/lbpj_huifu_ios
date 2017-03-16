//
//  LBShuRuView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/17.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBShuRuView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeH:(NSString *)placeH;

@end
