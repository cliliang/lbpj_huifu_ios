//
//  LBLiJiRulerView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBLiJiRulerView.h"
#import "LBLiJiRulerCVCell.h"

@interface LBLiJiRulerView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *numberArray;

@end

@implementation LBLiJiRulerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addCollectionViewInThisView];
        
        UIView *lineView = [[UIView alloc] init];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self);
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(15);
        }];
        lineView.backgroundColor = kNavBarColor;
    }
    return self;
}

// 添加collectionView
- (void)addCollectionViewInThisView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(200, 90);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth / 2 - 40, 0);
    flowLayout.footerReferenceSize = CGSizeMake(kScreenWidth / 2, 0);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90) collectionViewLayout:flowLayout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CVCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.bounces = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LBLiJiRulerCVCell class]) bundle:nil] forCellWithReuseIdentifier:kCellId];
//    collectionView.backgroundColor = [UIColor redColor];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2 - 19, 20)];
    headerV.backgroundColor = [UIColor whiteColor];
    [collectionView addSubview:headerV];
}

- (void)scrollToNumber:(NSInteger)number
{
    if (number > self.totalMoney) {
        return;
    }
    _isScrolling = YES;
    CGFloat x = number * 1.0 / 5;
    [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (![self.numberArray isNullOrNil]) {
        return self.numberArray.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBLiJiRulerCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (![self.numberArray isNullOrNil]) {
        cell.label_num1.text = self.numberArray[indexPath.row][0];
        cell.label_num2.text = self.numberArray[indexPath.row][1];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    kLog(@"点击CVCell");
}
// 滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isScrolling) {
        return;
    } else {
        if (self.scrollingBlock) {
            if (scrollView.contentOffset.x > self.totalMoney / 5) {
                self.scrollingBlock((int)self.totalMoney);
                scrollView.contentOffset = CGPointMake(self.totalMoney / 5, 0);
                return;
            }
            self.scrollingBlock((int)scrollView.contentOffset.x * 5 / 100 * 100);
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isScrolling = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate == NO) { // 没有减速, 轻轻松手
        int endDrag = (int)scrollView.contentOffset.x;
        int scroll = endDrag - endDrag % 20;
        [scrollView setContentOffset:CGPointMake(scroll, 0) animated:YES];
        _isScrolling = YES;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int endDrag = (int)scrollView.contentOffset.x;
    int scroll = endDrag - endDrag % 20;
    [scrollView setContentOffset:CGPointMake(scroll, 0) animated:YES];
    _isScrolling = YES;
}

- (void)setTotalMoney:(NSInteger)totalMoney
{
    _totalMoney = totalMoney;
    for (int i = 0; i < (int)(totalMoney / 1000) + 2; i++) {
        NSInteger number_1 = i * 1000;
        NSInteger number_2 = number_1 + 500;
        NSArray *array = @[[NSString stringWithFormat:@"%ld", (long)number_1], [NSString stringWithFormat:@"%ld", (long)number_2]];
        [self.numberArray addObject:array];
    }
    [self.collectionView reloadData];
}
- (NSMutableArray *)numberArray
{
    if (_numberArray == nil) {
        _numberArray = [NSMutableArray array];
    }
    return _numberArray;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
