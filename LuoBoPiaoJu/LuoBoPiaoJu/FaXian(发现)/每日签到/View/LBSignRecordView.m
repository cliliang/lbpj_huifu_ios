//
//  LBSignRecordView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBSignRecordView.h"
#import "LBSignRecordCell.h"

@interface LBSignRecordView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *weekDayArray; // 一, 二, 三 ,,,, 日

@property (nonatomic, assign) NSInteger firstWeekDay; // 第一天周几
@property (nonatomic, assign) NSInteger totalDay; // showing 总共多少天

@property (nonatomic, assign) BOOL showRightImg; // 右侧按钮是否可点击

// 日期
@property (nonatomic, strong) UILabel *headerLabel;

// 前进, 返回
@property (nonatomic, strong) UIImageView *leftImgV;
@property (nonatomic, strong) UIImageView *rightImgV;

// 日历部分, collectionView
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LBSignRecordView

- (void)loadTheSubviews
{
    
    // 日期header
    UILabel *headerLabel = [UILabel new];
    [self addSubview:headerLabel];
    _headerLabel = headerLabel;
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(kDiv2(49));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(kDiv2(36));
    }];
    [headerLabel setText:@"2016年09月" textColor:kDeepColor font:[UIFont pingfangWithFloat:kDiv2(36) weight:UIFontWeightLight]];
    
    // 左右按钮
    UIImageView *imageV1 = [UIImageView new];
    [self addSubview:imageV1];
    [imageV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(headerLabel.mas_left).offset(-kDiv2(60));
        make.centerY.mas_equalTo(headerLabel);
        make.width.mas_equalTo(kDiv2(19));
        make.height.mas_equalTo(kDiv2(39));
    }];
    imageV1.image = [UIImage imageNamed:@"icon_everydaySign_left"];
    _leftImgV = imageV1;
    
    UIImageView *imageV2 = [UIImageView new];
    [self addSubview:imageV2];
    [imageV2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headerLabel.mas_right).offset(kDiv2(60));
        make.centerY.mas_equalTo(headerLabel);
        make.width.mas_equalTo(kDiv2(19));
        make.height.mas_equalTo(kDiv2(39));
    }];
    imageV2.image = [UIImage imageNamed:@"icon_everydaySign_rightNO"];
    _rightImgV = imageV2;
    
    CGFloat width = KAutoWDiv2(50) * 7 + KAutoWDiv2(39) * 6;
    CGFloat height = KAutoHDiv2(50) * 7 + KAutoHDiv2(22) * 6;
//    CGFloat y_coll = kDiv2(49 + 39 + 59);
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = KAutoHDiv2(21);
    layout.minimumInteritemSpacing = KAutoWDiv2(38);
    layout.itemSize = CGSizeMake(KAutoWDiv2(50), KAutoWDiv2(50));
    layout.sectionInset = UIEdgeInsetsMake(0, (kScreenWidth - width) / 2, 0, (kScreenWidth - width) / 2);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
    collectionView.collectionViewLayout = layout;
    [self addSubview:collectionView];
    collectionView.userInteractionEnabled = NO;
    _collectionView = collectionView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerLabel.mas_bottom).offset(kDiv2(59));
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(height);
    }];
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[LBSignRecordCell class] forCellWithReuseIdentifier:@"CVCell"];
    
    // 左右按钮添加点击事件
    UIButton *button1 = [UIButton new];
    [self addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV1).offset(-10);
        make.bottom.mas_equalTo(imageV1).offset(10);
        make.left.mas_equalTo(imageV1).offset(-15);
        make.right.mas_equalTo(imageV1).offset(15);
    }];
    [button1 addTarget:self action:@selector(clickLast) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton new];
    [self addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageV2).offset(-10);
        make.bottom.mas_equalTo(imageV2).offset(10);
        make.left.mas_equalTo(imageV2).offset(-15);
        make.right.mas_equalTo(imageV2).offset(15);
    }];
    [button2 addTarget:self action:@selector(clickNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self prepareData];
    
    _showingDate = _nowDate;
    [self refreshDate];
}

- (void)prepareData
{
    self.weekDayArray = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
}
// 下一个
- (void)clickNext
{
    if (_showRightImg) {
        _showingDate = [self nextMonth:_showingDate];
        [self refreshDate];
        [self.collectionView reloadData];
    }
}
// 上一个
- (void)clickLast
{
    _showingDate = [self lastMonth:_showingDate];
    [self refreshDate];
    [[self collectionView] reloadData];
}
// 根据showingDate 刷新必要数据
- (void)refreshDate
{
    _firstWeekDay = [self firstWeekdayInThisMonth:_showingDate];
    _totalDay = [self totaldaysInMonth:_showingDate];
    _headerLabel.text = [NSString stringWithFormat:@"%ld年%02ld月", [self year:_showingDate], [self month:_showingDate]];
    if ([self year:_showingDate] == [self year:_nowDate] && [self month:_showingDate] == [self month:_nowDate]) {
        _showRightImg = NO;
        _rightImgV.image = [UIImage imageNamed:@"icon_everydaySign_rightNO"];
    } else {
        _showRightImg = YES;
        _rightImgV.image = [UIImage imageNamed:@"icon_everydaySign_right"];
    }
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 49;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBSignRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CVCell" forIndexPath:indexPath];
    if (indexPath.row < 7) {
        cell.theText = self.weekDayArray[indexPath.row];
        cell.selectedDate = NO;
    } else {
        // 0 为 周一
        if (indexPath.row < 6 + _firstWeekDay || indexPath.row > 6 + _firstWeekDay + _totalDay - 1) {
            // 无日期
            cell.theText = @"";
            cell.selectedDate = NO;
        } else {
            // 有日期
            NSInteger year = [self year:_showingDate];
            NSInteger month = [self month:_showingDate];
            NSInteger day = indexPath.row - (6 + _firstWeekDay) + 1;
            cell.theText = [NSString stringWithFormat:@"%ld", day];
            
            NSString *timeKey = [NSString stringWithFormat:@"%ld-%02ld-%02ld", year, month, day];
            
            cell.selectedDate = self.recordDict[timeKey];
        }
        
    }
    return cell;
}

#pragma mark - date
// 日
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

// 月
- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}
// 年
- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

// 获得 这个月的第一天是 周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

// 这个月 总共多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}
// 得到上个月date
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
// 得到下个月date
- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = + 1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

@end
















