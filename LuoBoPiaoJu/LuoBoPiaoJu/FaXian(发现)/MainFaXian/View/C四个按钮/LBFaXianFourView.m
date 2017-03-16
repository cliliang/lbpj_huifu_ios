//
//  LBFaXianFourView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/5.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFaXianFourView.h"
#import "LBFaXianFourCVCell.h"

@interface LBFaXianFourView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imagesArr;

@end

@implementation LBFaXianFourView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0.9;
        CGFloat width = (frame.size.width - 2) / 3;
        CGFloat height = frame.size.height;
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];

        [collectionView registerNib:[UINib nibWithNibName:@"LBFaXianFourCVCell" bundle:nil] forCellWithReuseIdentifier:kCVCell];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
        collectionView.backgroundColor = kBackgroundColor;
    }
    return self;
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBFaXianFourCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCVCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.label.text = self.dataArray[indexPath.row];
    cell.imageV.image = self.imagesArr[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickBtnBlock) {
        self.clickBtnBlock(indexPath.row);
    }
}

- (NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"积分商城", @"会员特权", @"帮助中心"];
    }
    return _dataArray;
}
- (NSArray *)imagesArr
{
    if (_imagesArr == nil) {
        UIImage *image1 = [UIImage imageNamed:@"icon_faxian111_jifenshangcheng"];
        UIImage *image2 = [UIImage imageNamed:@"icon_faxian111_huiyuantequan"];
        UIImage *image3 = [UIImage imageNamed:@"icon_faxian111_bangzhuzhongxin"];
        _imagesArr = @[image1, image2, image3];
    }
    return _imagesArr;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
