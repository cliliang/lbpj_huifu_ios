//
//  LBFourButtonView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBFourButtonViewBlock)(NSInteger index);

@interface LBFourButtonView : UIView

@property (nonatomic, copy) LBFourButtonViewBlock selectedBlock;
- (void)setSelectedBlock:(LBFourButtonViewBlock)selectedBlock;

@end
