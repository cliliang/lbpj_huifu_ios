//
//  LBMessageCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBMessageCell : UITableViewCell

@property (nonatomic, strong) LBMessageModel *model;
@property (nonatomic, assign) BOOL imageType; // NO为不展开, 测试不展开颜色为红色

@property (nonatomic, assign) BOOL canJump; // 是否能跳转

@end
