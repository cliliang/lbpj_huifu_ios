//
//  LBGetHongBaoView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBGetHongBaoView.h"
#import "LBGetHongBaoLayout.h"
#import "LBGetHongBaoCell.h"
#import "LBHongBaoModel.h"

#define kDefaultCellId @"getHongbaoDefault"
#define ktheCellId @"getHongBaoCell"

@interface LBGetHongBaoView () <UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation LBGetHongBaoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCollectionViewInThisView];
        
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addCollectionViewInThisView];
    }
    return self;
}

// 添加collectionView
- (void)addCollectionViewInThisView
{
    LBGetHongBaoLayout *layout = [[LBGetHongBaoLayout alloc] init];
    layout.cellHeight = kDiv2(220);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kDefaultCellId];
    [collectionView registerClass:[LBGetHongBaoCell class] forCellWithReuseIdentifier:ktheCellId];
    _collectionView = collectionView;
    collectionView.backgroundColor = kLineColor;
}
#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count / 3 * 3 + 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.dataArray.count) {
        LBGetHongBaoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ktheCellId forIndexPath:indexPath];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDefaultCellId forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.clickBlock) {
        self.clickBlock(indexPath.row);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
