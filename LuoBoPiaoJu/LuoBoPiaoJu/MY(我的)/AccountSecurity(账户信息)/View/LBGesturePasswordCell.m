//
//  LBGesturePasswordCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/7/12.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBGesturePasswordCell.h"
#import "CoreLockConst.h"
#import "PSSUserDefaultsTool.h"

@interface LBGesturePasswordCell ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *label;

@end

@implementation LBGesturePasswordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellStyle:(LBGesturePasswordCellStyle)cellStyle
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellStyle = cellStyle;
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kLineColor;
        [self.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView);
            make.centerX.mas_equalTo(self.contentView);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(0.5);
        }];
        _lineView = lineView;
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"手势密码";
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        label.textColor = [UIColor darkGrayColor];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView);
            make.left.mas_equalTo(self.contentView).offset(15);
        }];
        _label = label;
        
        UISwitch *switchV = [[UISwitch alloc] init];
        [self.contentView addSubview:switchV];
        [switchV addTarget:self action:@selector(clickTheSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [switchV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).offset(-20);
            make.centerY.mas_equalTo(self.contentView);
//            make.width.mas_equalTo(200);
//            make.height.mas_equalTo(30);
        }];
        _swi = switchV;
        
        if (_cellStyle == LBGesturePasswordCellStyleNone) {
            switchV.on = [[PSSUserDefaultsTool getValueWithKey:kFingerLockBool] boolValue];
            kLog(@"%d", [[PSSUserDefaultsTool getValueWithKey:kFingerLockBool] boolValue]);
        } else {
            switchV.on = [self boolWithGesPW] ? YES : NO;
        }
    }
    return self;
}

- (void)clickTheSwitch:(UISwitch *)swi
{
    [self refreshSwitch];
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)refreshSwitch
{
    if (self.cellStyle == LBGesturePasswordCellStyleNone) {
        BOOL isSupportFingerLock = [[PSSUserDefaultsTool getValueWithKey:kSupportingFingerLock] boolValue];
        if (isSupportFingerLock) {
            [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:_swi.on] WithKey:kFingerLockBool];
            if (_changeBlock) {
                _changeBlock(_swi.on);
            }
        } else {
            _swi.on = NO;
            [[PSSToast shareToast] showMessage:@"请先设置您的TouchID"];
        }
        
    } else {
        NSString *gesPW = [PSSUserDefaultsTool getValueWithKey:kGesturePasswordKey];
        if ([gesPW isEqualToString:@""] || gesPW == nil || [gesPW isKindOfClass:[NSNull class]]) {
            _swi.on = NO;
        } else {
            _swi.on = YES;
        }
    }    
}

- (BOOL)boolWithGesPW
{
    NSString *str = [PSSUserDefaultsTool getValueWithKey:kGesturePasswordKey];
    if ([NSObject nullOrNilWithObjc:str] || str.length == 0) {
        return NO;
    }
    return YES;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    _label.text = title;
}
- (void)switchChanged:(UISwitch *)swi
{
    kLog(@"%d", swi.on);
}

- (void)setShowLineView:(BOOL)showLineView
{
    _showLineView = showLineView;
    _lineView.hidden = !showLineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
