//
//  LBSignInView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PSSClickSignBtnBlock)(UIButton *button);

@interface LBSignInView : UIView

@property (nonatomic, strong) NSString *signBtnTitle;

@property (nonatomic, strong) UILabel *label_jiFen;

@property (nonatomic, strong) UIImageView *myVipImgV;

@property (nonatomic, copy) PSSClickSignBtnBlock clickBtnBlock;
- (void)setClickBtnBlock:(PSSClickSignBtnBlock)clickBtnBlock;

@property (nonatomic, copy) LBSuccessVoidBlock clickBlock;

@end
