//
//  LBCaluTVCell_2.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/8.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KCellH_2 65

typedef void(^LBClickBtnBlock)(NSInteger index); // 0 清除, 1 计算

@interface LBCaluTVCell_2 : UITableViewCell

@property (nonatomic, copy) LBClickBtnBlock btnBlock;
- (void)setBtnBlock:(LBClickBtnBlock)btnBlock;

@end
