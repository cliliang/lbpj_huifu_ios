//
//  LBFaXianFourView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PSSClickButtons)(NSInteger index);

@interface LBFaXianFourView : UIView

@property (nonatomic, copy) PSSClickButtons clickBtnBlock;
- (void)setClickBtnBlock:(PSSClickButtons)clickBtnBlock;

@end
