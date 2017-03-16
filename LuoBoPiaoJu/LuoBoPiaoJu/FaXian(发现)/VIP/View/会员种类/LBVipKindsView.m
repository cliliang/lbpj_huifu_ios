//
//  LBVipKindsView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBVipKindsView.h"
#import "LBVipKindsLayout.h"
#import "LBVipKindsCell.h"

@interface LBVipKindsView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) CGFloat itemW;

@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *selectedArr;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) UILabel *seleLabel;

@property (nonatomic, assign) BOOL clickScroll;

@end

@implementation LBVipKindsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCollectionViewInThisView];
        [self addLabelInThis];
    }
    return self;
}
- (void)addLabelInThis
{
    UILabel *label = [[UILabel alloc] init];
    _seleLabel = label;
    [label setText:self.titleArr[_selectedIndex] textColor:kDeepColor font:[UIFont systemFontOfSize:12]];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(12);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-kAutoH(9));
    }];
}
// 添加collectionView
- (void)addCollectionViewInThisView
{
    LBVipKindsLayout *layout = [[LBVipKindsLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [collectionView registerClass:[LBVipKindsCell class] forCellWithReuseIdentifier:kVIPKindsCellID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.bounces = NO;
    
    [layout setFinishedPosition:^(CGPoint position) {
//        if (_itemW == 0) {
//            NSArray *array = [_collectionView visibleCells];
//            UICollectionViewCell *cell0;
//            UICollectionViewCell *cell1;
//            if (array.count > 1) {
//                cell0 = array[0];
//                cell1 = array[1];
//            }
//            _itemW = cell1.center.x - cell0.center.x;
//        }
//        if (self.selectedBlock) {
//            NSInteger selectedIndex = (NSInteger)(position.x / _itemW);
//            self.selectedBlock(selectedIndex);
//            self.selectedIndex = selectedIndex;
//            self.seleLabel.text = self.titleArr[selectedIndex];
//        }
    }];
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBVipKindsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVIPKindsCellID forIndexPath:indexPath];
    NSString *norStr = [NSString stringWithFormat:@"%@%@", self.imageArr[indexPath.row], @"normal"];
    NSString *selStr = [NSString stringWithFormat:@"%@%@", self.imageArr[indexPath.row], @"selected"];
    cell.imageV.image = [self.selectedArr[indexPath.row] boolValue] ? [UIImage imageNamed:selStr] : [UIImage imageNamed:norStr];
    cell.myImageV.hidden = !(indexPath.row == _myVipGrade);
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _clickScroll = YES;
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row);
        self.selectedIndex = indexPath.row;
        self.seleLabel.text = self.titleArr[indexPath.row];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!_clickScroll) {
        if (_itemW == 0) {
            NSArray *array = [_collectionView visibleCells];
            UICollectionViewCell *cell0;
            UICollectionViewCell *cell1;
            for (int i = 0; i < array.count; i++) {
                if (i == 0) {
                    CGPoint center0 = [[array[i] valueForKey:@"center"] CGPointValue];
                    CGPoint center1 = [[array[i + 1] valueForKey:@"center"] CGPointValue];
                    cell0 = center0.x > center1.x ? array[i + 1] : array[i];
                    cell1 = center0.x < center1.x ? array[i + 1] : array[i];
                    i++;
                } else {
                    if ([[array[i] valueForKey:@"center"] CGPointValue].x < cell0.center.x) {
                        cell0 = array[i];
                        continue;
                    }
                    if ([[array[i] valueForKey:@"center"] CGPointValue].x < cell1.center.x) {
                        cell1 = array[i];
                    }
                }
            }
            _itemW = cell1.center.x - cell0.center.x;
        }
        if (self.selectedBlock) {
            NSInteger selectedIndex = (NSInteger)((scrollView.contentOffset.x + ABS(_itemW) / 2) / ABS(_itemW));
//            NSLog(@"%lf --- %ld --- %lf", scrollView.contentOffset.x, selectedIndex, _itemW);
            self.selectedBlock(selectedIndex);
            self.selectedIndex = selectedIndex;
            self.seleLabel.text = self.titleArr[selectedIndex];
        }
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    _clickScroll = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    if (_itemW == 0) {
//        NSArray *array = [_collectionView visibleCells];
//        UICollectionViewCell *cell0;
//        UICollectionViewCell *cell1;
//        if (array.count > 1) {
//            cell0 = array[0];
//            cell1 = array[1];
//        }
//        _itemW = cell1.center.x - cell0.center.x;
//    }
//    if (self.selectedBlock) {
//        NSInteger selectedIndex = (NSInteger)(scrollView.contentOffset.x / _itemW);
//        self.selectedBlock(selectedIndex);
//        self.selectedIndex = selectedIndex;
//        self.seleLabel.text = self.titleArr[selectedIndex];
//    }
}
- (NSArray *)imageArr
{
    if (_imageArr == nil) {
        _imageArr = @[@"vip_normal_icon_", @"vip_bronze_icon_", @"vip_silver_icon_", @"vip_gold_icon_", @"vip_diamond_icon_", @"vip_gold_diamond_icon_"];
    }
    return _imageArr;
}
- (NSArray *)titleArr
{
    if (_titleArr == nil) {
        _titleArr = @[@"普通会员", @"铜牌会员", @"银牌会员", @"金牌会员", @"钻石会员", @"金钻会员"];
    }
    return _titleArr;
}
- (NSArray *)selectedArr
{
    if (_selectedArr == nil) {
        _selectedArr = @[@1, @0, @0, @0, @0, @0];
    }
    return _selectedArr;
}
- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex) {
        return;
    }
    _selectedIndex = selectedIndex;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        [arr addObject:i == selectedIndex ? @1 : @0];
    }
    _selectedArr = arr;
    [_collectionView reloadData];
}
- (void)setMyVipGrade:(NSInteger)myVipGrade
{
    _myVipGrade = myVipGrade;
    if (myVipGrade < 10) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:myVipGrade inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.selectedIndex = myVipGrade;
        self.selectedIndex = myVipGrade;
        self.seleLabel.text = self.titleArr[myVipGrade];
    }
}

@end













