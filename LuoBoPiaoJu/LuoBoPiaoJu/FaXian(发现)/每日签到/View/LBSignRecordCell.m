//
//  LBSignRecordCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBSignRecordCell.h"

@interface LBSignRecordCell ()

@property (nonatomic, strong) UILabel *theLabel;

@end

@implementation LBSignRecordCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *label = [UILabel new];
        [self.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        label.textAlignment = NSTextAlignmentCenter;
        [label setText:@"" textColor:kColor_707070 font:[UIFont pingfangWithFloat:KAutoWDiv2(36) weight:UIFontWeightLight]];
        _theLabel = label;
        
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = KAutoWDiv2(50) / 2;

        
    }
    return self;
}

- (void)setTheText:(NSString *)theText
{
    _theText = theText;
    _theLabel.text = theText;
}
- (void)setSelectedDate:(BOOL)selectedDate
{
    _selectedDate = selectedDate;
    _theLabel.backgroundColor = selectedDate ? kNavBarColor : [UIColor whiteColor];
    _theLabel.textColor = selectedDate ? [UIColor whiteColor] : kColor_707070;
}


@end








