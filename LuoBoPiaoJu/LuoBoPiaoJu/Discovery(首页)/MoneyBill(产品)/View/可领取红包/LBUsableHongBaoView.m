
//
//  LBUsableHongBaoView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/29.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBUsableHongBaoView.h"
#import "LBUsableHongBaoLayout.h"
#import "LBUsableHongBaoCell.h"

#define kCellID @"usableHongBaoCellId"

#define kPingFangFont(a) [UIFont fontWithName:@"PingFangSC-Light" size:(a)]

@interface LBUsableHongBaoView () <UICollectionViewDelegate , UICollectionViewDataSource>



@end

@implementation LBUsableHongBaoView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addCollectionViewInThisView];
    }
    return self;
}
- (void)addCollectionViewInThisView
{
    // 选择使用红包
    UILabel *label1 = [UILabel new];
    [label1 setText:@"选择使用红包" textColor:kDeepColor font:kPingFangFont(15)];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_top).offset(kDiv2(90) / 2);
        make.left.mas_equalTo(self.mas_left).offset(15);
    }];
    
    LBUsableHongBaoLayout *layout = [[LBUsableHongBaoLayout alloc] init];
    layout.cellHeight = kDiv2(kCellHeight);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[LBUsableHongBaoCell class] forCellWithReuseIdentifier:kCellID];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(kDiv2(90));
        make.left.right.bottom.mas_equalTo(self);
    }];
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBUsableHongBaoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBUsableHongBaoCell *cell = (LBUsableHongBaoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (self.clickItem) {
        self.clickItem(indexPath.row, cell);
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
