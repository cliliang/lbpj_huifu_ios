//
//  LBBankCardTVCell.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBBankCardInfoModel.h"

@interface LBBankCardTVCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_bankCardName;
@property (weak, nonatomic) IBOutlet UILabel *label_danBiXianE;
@property (weak, nonatomic) IBOutlet UILabel *label_dangRiXianE;

@property (nonatomic, strong) LBBankCardInfoModel *model;

@end
