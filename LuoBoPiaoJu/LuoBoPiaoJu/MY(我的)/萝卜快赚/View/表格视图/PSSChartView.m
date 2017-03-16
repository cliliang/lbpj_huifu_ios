//
//  PSSChartView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/30.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  6行 6列的表格

#import "PSSChartView.h"

#define kCount 5 // 几行几列, 这个需要跟给的数组数量一致, 为了方便调整个数

@interface PSSChartView ()

@property (nonatomic, strong) NSMutableArray *y_Array;
@property (nonatomic, strong) NSMutableArray *x_Array;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSMutableArray *pointArray;

@property (nonatomic, strong) UILabel *label_riqi;
@property (nonatomic, strong) UIView *frontView; // 遮挡

@end

@implementation PSSChartView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 累计收益
        UILabel *label_leijishouyi = [[UILabel alloc] init];
        [self addSubview:label_leijishouyi];
        label_leijishouyi.textColor = [UIColor colorWithRGBString:@"707070"];
        label_leijishouyi.text = @"累计收益";
        label_leijishouyi.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        [label_leijishouyi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(29);
            make.centerX.mas_equalTo(self.mas_left).offset(60);
            make.height.mas_equalTo(11);
        }];
        
        // 累计收益走势
        UILabel *label_leijizoushi = [[UILabel alloc] init];
        [self addSubview:label_leijizoushi];
        label_leijizoushi.textColor = [UIColor colorWithRGBString:@"707070"];
        label_leijizoushi.text = @"累计收益走势";
        label_leijizoushi.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        [label_leijizoushi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-30);
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(11);
        }];
        
        // 遮挡
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        self.frontView = view;
        view.backgroundColor = [UIColor whiteColor];
        
        // 日期
        UILabel *label_riqi = [[UILabel alloc] init];
        [self addSubview:label_riqi];
        label_riqi.textColor = [UIColor colorWithRGBString:@"707070"];
        label_riqi.text = @"日期";
        label_riqi.font = [UIFont systemFontOfSize:11 weight:UIFontWeightRegular];
        [label_riqi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_right).offset(-25);
            make.centerY.mas_equalTo(self.mas_bottom).offset(-80);
        }];
        _label_riqi = label_riqi;
        
        
    }
    return self;
}

// 画表
- (void)drawChartWithTotalMonty:(CGFloat)totalMoney dataArr:(NSArray *)dataArr
{
    if (self.x_Array.count != 0) { // 只添加一遍
        return;
    }
    self.dataArr = dataArr;
    
    CGFloat h_chart = self.height - 50 - 80;
    CGFloat w_chart = self.width - 60 - 50;
    CGFloat h_item = h_chart / (kCount - 1);
    CGFloat w_item = w_chart / (kCount - 1);
    
    CGFloat itemMoney = totalMoney * 1.0 / (kCount - 1);
    
    // y轴label
    for (int i = 0; i < kCount; i++) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        label.text = [NSString stringWithFormat:@"%.2lf", totalMoney - i * itemMoney];
        if (i == kCount - 1) {
            label.text = @"0";
        }
        label.textColor = [UIColor colorWithRGBString:@"707070"];
        label.font = [UIFont systemFontOfSize:9 weight:UIFontWeightLight];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_left).offset(55);
            make.centerY.mas_equalTo(self.mas_top).offset(50 + i * h_item);
        }];
        [self.y_Array insertObject:label atIndex:0];
    }
    
    // x轴label
    for (int i = 0; i < kCount; i++) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        label.text = [NSString stringWithFormat:@"06-0%d", i + 1];
        label.textColor = [UIColor colorWithRGBString:@"707070"];
        label.font = [UIFont systemFontOfSize:9 weight:UIFontWeightLight];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-60);
            make.centerX.mas_equalTo(self.mas_left).offset(60 + i * w_item);
        }];
//        [self.x_Array insertObject:label atIndex:0];
        [self.x_Array addObject:label];
    }
    
    if (self.pointArray.count >= kCount) { // 保护一下
        return;
    }
    // 添加数据点
    for (int i = 0; i < kCount; i++) {
        CGFloat x_point = 60 + i * w_item;
        CGFloat y_point = self.height - [dataArr[i] floatValue] * h_chart * 1.0 / totalMoney - 80 - 1;
//        NSLog(@"%lf", y_point);
//        NSLog(@"%lf", [dataArr[i] floatValue]);
        CGPoint point = CGPointMake(x_point, y_point);
        [self.pointArray addObject:[NSNumber valueWithCGPoint:point]];
    }
    // x轴上点 调高1
    for (int i = 0; i < kCount; i++) {
        CGFloat x_point = 60 + w_chart - i * w_item;
        CGFloat y_point = self.height - 80 - 1;
        CGPoint point = CGPointMake(x_point, y_point);
        [self.pointArray addObject:[NSNumber valueWithCGPoint:point]];
    }
    
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect
{
    if (self.dataArr.count == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();//设置一个空白view，准备画画
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.831 green:0.820 blue:0.816 alpha:1.000].CGColor); //设置当前笔头颜色
    CGContextSetLineWidth(context, 1.0);//设置当前画笔粗细
    CGContextMoveToPoint(context, 60, self.height - 80);//将花笔移到某点
    CGContextAddLineToPoint(context, self.width - 40, self.height - 80);//设置一个终点
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 60, self.height - 80);
    CGContextAddLineToPoint(context, 60, 45);
    CGContextStrokePath(context);
    
    // 多边形
    CGPoint point1 = [self.pointArray[0] CGPointValue];
    CGContextMoveToPoint(context, point1.x, point1.y);
    for (int i = 0; i < self.pointArray.count + 1; i++) {
        CGPoint point = [self.pointArray[i % self.pointArray.count] CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.000 green:0.937 blue:0.847 alpha:1.000].CGColor);
    CGContextFillPath(context);
    
    // 画折线
    CGContextSetLineWidth(context, 0.5);//设置当前画笔粗细
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.992 green:0.741 blue:0.302 alpha:1.000].CGColor);
    CGContextMoveToPoint(context, point1.x, point1.y);
    for (int i = 0; i < self.pointArray.count / 2; i++) {
        CGPoint point = [self.pointArray[i] CGPointValue];
        CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextStrokePath(context);
}

- (void)startAnimationWithTime:(CGFloat)time
{
    self.frontView.frame = CGRectMake(61, 51, self.width - 102, self.height - 131);
    [UIView animateWithDuration:time animations:^{
        self.frontView.frame = CGRectMake(61 + self.width - 100, 51, self.width - 102, self.height - 131);
    }];
}

- (void)setDateArray:(NSArray *)dateArray
{
    _dateArray = dateArray;
    for (int i = 0; i < kCount; i++) {
        UILabel *label = (UILabel *)self.x_Array[i];
        label.text = dateArray[i];
    }
}

- (NSMutableArray *)pointArray
{
    if (_pointArray == nil) {
        _pointArray = [NSMutableArray array];
    }
    return _pointArray;
}

- (NSMutableArray *)x_Array
{
    if (_x_Array == nil) {
        _x_Array = [NSMutableArray array];
    }
    return _x_Array;
}

- (NSMutableArray *)y_Array
{
    if (_y_Array == nil) {
        _y_Array = [NSMutableArray array];
    }
    return _y_Array;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
