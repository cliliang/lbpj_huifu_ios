//
//  LBInviteRecordTVCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/10.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBInviteRecordTVCell.h"

@implementation LBInviteRecordTVCell

- (void)awakeFromNib {
    // Initialization code
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kLineColor;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(LBInvitedRecordModel *)model
{
    _model = model;
    _label_user.text = model.invitedMobile;
    _label_jiangLiMoney.text = model.inviteDesc;
    _label_time.text = [NSString stringWithFormat:@"%@%@", [NSDate stringWithJavaTimeInter:model.createTime dateFormat:@"yyyy-MM-dd"], @"注册"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
