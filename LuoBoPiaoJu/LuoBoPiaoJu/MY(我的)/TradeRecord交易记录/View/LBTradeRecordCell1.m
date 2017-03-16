//
//  LBTradeRecordCell1.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBTradeRecordCell1.h"

@interface LBTradeRecordCell1 ()

@property (nonatomic, strong) UILabel *label_tixian; // type, 提现/充值/投资等
@property (nonatomic, strong) UILabel *label_date; // 日期
@property (nonatomic, strong) UILabel *label_time; // 时间
@property (nonatomic, strong) UILabel *label_money;
@property (nonatomic, strong) UILabel *label_state; // 成功/失败

@property (nonatomic, strong) NSDictionary *typeDict;

@end

@implementation LBTradeRecordCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSomeViews];
        
    }
    return self;
}

- (void)addSomeViews
{
    CGFloat topAndBottom = 14; // 需要除以2
    
    // 1.提现/提现/投资 等
    UILabel *label1 = [UILabel new];
    [label1 setText:@"提现" textColor:kDeepColor font:[UIFont pingfangWithFloat:kDiv2(30) weight:UIFontWeightLight]];
    [self.contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(kDiv2(topAndBottom));
        make.left.mas_equalTo(self.contentView).offset(kDiv2(30));
        make.height.mas_equalTo(kDiv2(30));
    }];
    _label_tixian = label1;
    
    // 2.日期 - date
    UILabel *label2 = [UILabel new];
    [label2 setText:@"2008-08-08" textColor:kLightColor font:[UIFont pingfangWithFloat:kDiv2(22) weight:UIFontWeightLight]];
    [self.contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(-kDiv2(topAndBottom));
        make.left.mas_equalTo(self.contentView).offset(kDiv2(30));
        make.height.mas_equalTo(kDiv2(22));
    }];
    _label_date = label2;
    
    // 3.时间 - time
    UILabel *label3 = [UILabel new];
    [label3 setText:@"19:00" textColor:kLightColor font:[UIFont pingfangWithFloat:kDiv2(22) weight:UIFontWeightLight]];
    [self.contentView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(-kDiv2(topAndBottom));
        make.left.mas_equalTo(label2.mas_right).offset(kDiv2(15));
        make.height.mas_equalTo(kDiv2(22));
    }];
    _label_time = label3;
    
    // 4.金额 - money
    UILabel *label4 = [UILabel new];
    [label4 setText:@"5000" textColor:kDeepColor font:[UIFont pingfangWithFloat:kDiv2(30) weight:UIFontWeightLight]];
    [self.contentView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label1);
        make.right.mas_equalTo(self.contentView).offset(-kDiv2(30));
        make.height.mas_equalTo(kDiv2(30));
    }];
    _label_money = label4;
    
    // 5.状态 - state(成功/失败)
    UILabel *label5 = [UILabel new];
    [label5 setText:@"成功" textColor:kNavBarColor font:[UIFont pingfangWithFloat:kDiv2(22) weight:UIFontWeightLight]];
    [self.contentView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label2);
        make.right.mas_equalTo(self.contentView).offset(-kDiv2(30));
        make.height.mas_equalTo(kDiv2(22));
    }];
    _label_state = label5;
    
    // 线
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kLineColor;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setModel:(LBTradeRecordModel *)model
{
    _model = model;
    NSString *string1 = [NSString stringWithFormat:@"%lld", model.createTime];
    NSString *timeString = [string1 substringToIndex:string1.length - 3];
    NSTimeInterval time = [timeString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *string = [dateFormatter stringFromDate:date];
    NSArray *array = [string componentsSeparatedByString:@" "];
    self.label_time.text = array[0];
    self.label_date.text = array[1];
    self.label_money.text = [NSString stringWithFormat:@"%@%.2lf", self.typeDict[model.type], model.money];
//    self.label_tixian.text = model.message;
//    self.label_tixian.text = model.type ? self.typeDict[model.type] : @"";
    self.label_tixian.text = model.message;
    self.label_state.text = model.flg ? @"成功" : @"失败";
//    self.label_yuE.text = [NSString stringWithFormat:@"可用余额: %.2lf", model.balance];
}
- (NSDictionary *)typeDict
{
    if (_typeDict == nil) {
        _typeDict = @{
                      @"0":@"",
                      @"1":@"-",
                      @"2":@"-",
                      @"3":@"+",
                      @"4":@"+",
                      @"5":@"+",
                      @"6":@"",
                      @"7":@"",
                      };
    }
    return _typeDict;
}
//// -没用
//- (NSDictionary *)typeDict
//{
//    if (_typeDict == nil) {
//        _typeDict = @{
//                      @"0":@"失败",
//                      @"1":@"投资",
//                      @"2":@"提现",
//                      @"3":@"充值",
//                      @"4":@"赎回",
//                      @"5":@"还款",
//                      @"6":@"冻结",
//                      @"7":@"解除冻结",
//                      };
//    }
//    return _typeDict;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
