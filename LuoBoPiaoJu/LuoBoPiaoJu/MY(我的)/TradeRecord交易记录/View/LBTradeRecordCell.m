//
//  LBTradeRecordCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/18.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBTradeRecordCell.h"

@interface LBTradeRecordCell ()

@property (weak, nonatomic) IBOutlet UILabel *label_date;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_center;
@property (weak, nonatomic) IBOutlet UILabel *label_MoneyChange;
@property (weak, nonatomic) IBOutlet UILabel *label_yuE;

@property (nonatomic, strong) NSDictionary *colorDict;
@property (nonatomic, strong) NSArray *colorArray;

@end

@implementation LBTradeRecordCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    self.label_date.textColor = [UIColor colorWithRGBString:@"929292"];
    self.label_time.textColor = [UIColor colorWithRGBString:@"929292"];
    self.label_MoneyChange.textColor = [UIColor colorWithRGBString:@"929292"];
    self.label_yuE.textColor = [UIColor colorWithRGBString:@"929292"];
    self.label_center.numberOfLines = 0;
    self.label_center.layer.masksToBounds = YES;
    self.label_center.layer.cornerRadius = self.label_center.width / 2;
    
    self.lineView.backgroundColor = kLineColor;
}

- (void)setModel:(LBTradeRecordModel *)model
{
    _model = model;
    NSString *string1 = [NSString stringWithFormat:@"%lld", model.createTime];
    NSString *timeString = [string1 substringToIndex:string1.length - 3];
    NSTimeInterval time = [timeString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [dateFormatter stringFromDate:date];
    NSArray *array = [string componentsSeparatedByString:@" "];
    self.label_time.text = array[0];
    self.label_date.text = array[1];
    self.label_MoneyChange.text = [NSString stringWithFormat:@"%.2lf", model.money];
    self.label_center.text = model.message;
    self.label_yuE.text = [NSString stringWithFormat:@"可用余额: %.2lf", model.balance];
    
    if ([model.message containsString:@"失败"]) {
        self.label_center.backgroundColor = self.colorDict[@"失败"];
    } else {
        self.label_center.backgroundColor = self.colorDict[model.message];
    }
}

- (NSDictionary *)colorDict
{
    if (_colorDict == nil) {
        _colorDict = @{
                       @"投资":[UIColor colorWithRGBString:@"ffa57d"],
                       @"提现":[UIColor colorWithRGBString:@"6ee3b2"],
                       @"充值":[UIColor colorWithRGBString:@"ffc562"],
                       @"赎回":[UIColor colorWithRGBString:@"b6f0fa"],
                       @"还款":[UIColor colorWithRGBString:@"ffd58e"],
                       @"投标":[UIColor colorWithRGBString:@"ffc5ab"],
                       @"失败":[UIColor colorWithRGBString:@"abacb1"]
                       };
    }
    return _colorDict;
}
- (NSArray *)colorArray
{
    if (_colorDict == nil) {
        _colorArray = @[
                        [UIColor colorWithRGBString:@"ffa57d"],
                        [UIColor colorWithRGBString:@"6ee3b2"],
                        [UIColor colorWithRGBString:@"ffc562"],
                        [UIColor colorWithRGBString:@"b6f0fa"],
                        [UIColor colorWithRGBString:@"ffd58e"],
                        [UIColor colorWithRGBString:@"ffc5ab"],
                        [UIColor colorWithRGBString:@"abacb1"]
                        ];
    }
    return _colorArray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
