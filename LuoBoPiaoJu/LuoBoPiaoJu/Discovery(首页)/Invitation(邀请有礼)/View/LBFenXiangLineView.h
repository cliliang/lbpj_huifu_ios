//
//  LBFenXiangLineView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/22.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PSSClickBtn)(void);

@interface LBFenXiangLineView : UIView

@property (nonatomic, copy) PSSClickBtn clickLeftBlock;
@property (nonatomic, copy) PSSClickBtn clickRightBlock;
- (void)setClickLeftBlock:(PSSClickBtn)clickLeftBlock;
- (void)setClickRightBlock:(PSSClickBtn)clickRightBlock;

+ (instancetype)creatInView:(UIView *)view height:(CGFloat)height;

@end





