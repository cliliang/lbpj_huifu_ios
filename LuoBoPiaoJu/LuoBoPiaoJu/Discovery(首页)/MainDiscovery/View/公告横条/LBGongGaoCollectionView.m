//
//  LBGongGaoCollectionView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/26.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBGongGaoCollectionView.h"
#import "LBGongGaoCVCell.h"
#import "LBGongGaoModel.h"

@interface LBGongGaoCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isStartTimer;

@end

@implementation LBGongGaoCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //
        CGFloat x_image = 17;
        CGFloat hw_image = 17;
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(x_image, (frame.size.height - hw_image) / 2, hw_image, hw_image)];
        [self addSubview:_imageV];
        _imageV.image = [UIImage imageNamed:@"icon_faXian_gonggao"];
        
        CGFloat x_c = _imageV.right + 9;
        CGFloat y_c = 0;
        CGFloat width = kScreenWidth - x_c;
        CGFloat height = frame.size.height;
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake(width, height);
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(x_c, y_c, width, height) collectionViewLayout:flowLayout];
        
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LBGongGaoCVCell class]) bundle:nil] forCellWithReuseIdentifier:kLBGongGaoCVCell];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self addSubview:collectionView];
        _collectionView = collectionView;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.pagingEnabled = YES;
        collectionView.scrollEnabled = NO;
    }
    return self;
}

- (void)reloadGongGaoData
{
    NSMutableArray *array = [self.dataArray mutableCopy];
    [array addObject:array[0]];
    self.dataArray = array;
    [self.collectionView reloadData];
    
    self.index = 0;
    if (self.isStartTimer) {
        return;
    }
    self.isStartTimer = YES;
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
//    [timer fire];
//    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerAction:(NSTimer *)timer
{
    self.index++;
    if (self.index == self.dataArray.count) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        self.index = 1;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.index inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray) {
        return self.dataArray.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBGongGaoCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLBGongGaoCVCell forIndexPath:indexPath];
    if (self.dataArray) {
        LBGongGaoModel *model = self.dataArray[indexPath.row];
        cell.label_gonggao.text = model.newsTitle;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_buttonBlock) {
        _buttonBlock();
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
