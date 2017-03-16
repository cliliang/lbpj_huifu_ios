//
//  LBVipPrivilegeView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBVipPrivilegeView.h"
#import "LBVipBlocksLayout.h"
#import "LBVipBlocksCVCell.h"

@interface LBVipPrivilegeView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imagesArr;

@end

@implementation LBVipPrivilegeView

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
    LBVipBlocksLayout *blockLayout = [[LBVipBlocksLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:blockLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    collectionView.backgroundColor = kLineColor;
    [collectionView registerNib:[UINib nibWithNibName:@"LBVipBlocksCVCell" bundle:nil] forCellWithReuseIdentifier:kVipBlocksCell];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"vipCell"];
    _collectionView = collectionView;
}
- (void)reloadDataBlocksView
{
    [_collectionView reloadData];
}
#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataArr.count - 1 + 1 < indexPath.row + 1) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"vipCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    } else {
        LBVipBlocksCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVipBlocksCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.label.text = self.dataArr[indexPath.row];
        if (self.boolArr) {
            NSString *norStr = [NSString stringWithFormat:@"%@%@", self.imagesArr[indexPath.row], @"nor"];
            NSString *seleStr = [NSString stringWithFormat:@"%@sele", self.imagesArr[indexPath.row]];
            cell.imageV.image = ![self.boolArr[indexPath.row] boolValue] ? [UIImage imageNamed:norStr] : [UIImage imageNamed:seleStr];
        }
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 7) {
        if (self.vipPrivBlock) {
            self.vipPrivBlock(indexPath.row);
        }
    }
}
- (NSArray *)imagesArr
{
    if (_imagesArr == nil) {
        _imagesArr = @[@"icon_benjinhongbao_", @"icon_jingxihongbao_", @"icon_shengrihongbao_", @"icon_tequanhuodong_", @"icon_zhuanshukefu_", @"icon_shuangbeijifen_", @"icon_zhuanshuliwu_"];
    }
    return _imagesArr;
}

@end






