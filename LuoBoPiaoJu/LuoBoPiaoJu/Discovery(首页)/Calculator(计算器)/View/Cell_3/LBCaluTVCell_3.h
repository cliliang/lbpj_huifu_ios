//
//  LBCaluTVCell_3.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KCellH_3 50

typedef void(^LBLongPreBlock)(NSString *string);

typedef void(^LBClickCalcBlock)(void);

@interface LBCaluTVCell_3 : UITableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, copy) LBLongPreBlock longPreBlock;
- (void)setLongPreBlock:(LBLongPreBlock)longPreBlock;

@property (nonatomic, copy) LBClickCalcBlock clickBtn;
- (void)setClickBtn:(LBClickCalcBlock)clickBtn;

@end
