//
//  LBMyTopUpCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TopUpBlock)(void);

@interface LBMyTopUpCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (nonatomic, strong) NSString *moneyString;
@property (nonatomic, copy) TopUpBlock topUpBlock;
- (void)setTopUpBlock:(TopUpBlock)topUpBlock;

@end
