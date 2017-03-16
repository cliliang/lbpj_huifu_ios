//
//  LBFaXianBannerView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFaXianBannerView.h"
#import "ImageCVCell.h"
#import "PSSFlowLayout.h"
#define kCVCellId @"collectionViewCellId"

#define kCycleCount 100

@interface LBFaXianBannerView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LBFaXianBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        PSSFlowLayout *layout = [[PSSFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCVCell" bundle:nil] forCellWithReuseIdentifier:kCVCellId];
        _collectionView.backgroundColor = kBackgroundColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = NO;
    }
    return self;
}

- (void)refreshCollectionV
{
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCVCell *cell = (ImageCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCVCellId forIndexPath:indexPath];
    if (self.modelArr != nil && self.modelArr.count != 0) {
        cell.model = self.modelArr[indexPath.row % self.modelArr.count];
    } else {
        [self imageArr];
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kCycleCount ;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![NSObject nullOrNilWithObjc:self.modelArr] && self.modelArr.count != 0) {
        if (self.itemBlock) {
            self.itemBlock(indexPath.row % self.modelArr.count);
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSMutableArray *cells = [[self.collectionView visibleCells] mutableCopy];
    // 冒泡排序，取中间的
    for (int i = 0; i < cells.count - 1; i++) {
        BOOL b1 = NO;
        for (int j = 0; j < cells.count - i - 1; j++) {
            ImageCVCell *cell1 = cells[j];
            ImageCVCell *cell2 = cells[j + 1];
            ImageCVCell *tempCell;
            NSIndexPath *indexP1 = [self.collectionView indexPathForCell:cell1];
            NSIndexPath *indexP2 = [self.collectionView indexPathForCell:cell2];
            if (indexP1.row > indexP2.row) {
                tempCell = cells[j];
                cells[j] = cells[j + 1];
                cells[j + 1] = tempCell;
                b1 = YES;
            }
        }
        if (b1 == NO) {
            break;
        }
    }
    
    if (_modelArr == nil || _modelArr.count == 0) { // 如果数据为空，给默认值
        NSIndexPath *resIndexP = [self.collectionView indexPathForCell:cells[1]];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:kCycleCount / 2 - (kCycleCount / 2) % self.imageArr.count + resIndexP.row % self.imageArr.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    } else {
        NSIndexPath *resIndexP = [self.collectionView indexPathForCell:cells[1]];
        NSInteger resultRow = kCycleCount / 2 - (kCycleCount / 2) % self.modelArr.count + resIndexP.row % self.modelArr.count; // 需要好好算算
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:resultRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}

- (NSArray *)imageArr
{
    if (_imageArr == nil) {
        _imageArr = @[@"", @"", @"", @"", @"", @""];
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:kCycleCount / 2 - (kCycleCount / 2) % _imageArr.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
    return _imageArr;
}

- (void)setModelArr:(NSArray *)modelArr
{
    _modelArr = modelArr;
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:kCycleCount / 2 - (kCycleCount / 2) % modelArr.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}


@end










