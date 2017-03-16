//
//  LBFourButtonView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBFourButtonView.h"
#import "LBFourButtonCell.h"

#define kCVCell @"LBFourButtonCell"

@interface LBFourButtonView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *miaoShuArray;
@property (nonatomic, strong) NSArray *imagesArray;

@end

@implementation LBFourButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加collectionView
        UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
        CGFloat jianXi = 1; // 间隙
        CGFloat itemW = (self.width - jianXi * 4) / 3 - 0.2;
        CGFloat itemH = (self.height - jianXi * 3) / 2 - 0.2;
        layOut.minimumLineSpacing = jianXi;
        layOut.minimumInteritemSpacing = jianXi;
        layOut.itemSize = CGSizeMake(itemW, itemH);
        layOut.sectionInset = UIEdgeInsetsMake(jianXi, jianXi, jianXi, jianXi);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layOut];
        collectionView.scrollEnabled = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LBFourButtonCell class]) bundle:nil] forCellWithReuseIdentifier:kCVCell];
        collectionView.backgroundColor = kBackgroundColor;
        [self addSubview:collectionView];
    }
    return self;
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBFourButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCVCell forIndexPath:indexPath];
    cell.label_title.text = self.miaoShuArray[indexPath.row];
    if (indexPath.row == 4) {
        cell.label_title.textColor = kNavBarColor;
    }
    cell.label_miaoShu.text = self.titleArray[indexPath.row];
    cell.imageV.image = [self.imagesArray[indexPath.row] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row);
    }
}

- (NSArray *)miaoShuArray
{
    if (_miaoShuArray == nil) {
        _miaoShuArray = @[@"萝卜定投", @"银票苗",@"萝卜快赚",  @"邀请有礼", @"体验金8888", @"计算器"];
    }
    return _miaoShuArray;
}
- (NSArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = @[@"收益稳定", @"银行刚性兑付", @"灵活变现", @"邀请送好礼" , @"新手福利", @"票据贴现计算"];
    }
    return _titleArray;
}

- (NSArray *)imagesArray
{
    if (_imagesArray == nil) {
        UIImage *image1 = [UIImage imageNamed:@"icon_shouYe_dingqi"];
        UIImage *image2 = [UIImage imageNamed:@"icon_shouYe_yinpiaomiao"];
        UIImage *image3 = [UIImage imageNamed:@"icon_shouYe_luobokuaizhuan"];
        UIImage *image4 = [UIImage imageNamed:@"icon_shouYe_yaoqingyouli"];
        UIImage *image5 = [UIImage imageNamed:@"icon_shouYe_tiyanjin"];
        UIImage *image6 = [UIImage imageNamed:@"icon_shouYe_jisuanqi"];
        _imagesArray = @[image1, image2, image3, image4, image5, image6];
    }
    return _imagesArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
