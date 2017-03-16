//
//  LBGesturePasswordCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/7/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LBChangeOnBlock)(BOOL theOn);

typedef enum : NSUInteger {
    LBGesturePasswordCellStyleDefault, // 手势密码判断开关
    LBGesturePasswordCellStyleNone, // 普通开关
} LBGesturePasswordCellStyle;

typedef void(^LBClickBlock)(void);

@interface LBGesturePasswordCell : UITableViewCell

@property (nonatomic, strong) UISwitch *swi;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) LBGesturePasswordCellStyle cellStyle;
@property (nonatomic, assign) BOOL showLineView;

@property (nonatomic, copy) LBClickBlock clickBlock;
- (void)setClickBlock:(LBClickBlock)clickBlock;

@property (nonatomic, copy) LBChangeOnBlock changeBlock;
- (void)setChangeBlock:(LBChangeOnBlock)changeBlock;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellStyle:(LBGesturePasswordCellStyle)cellStyle;

- (void)refreshSwitch;

@end
