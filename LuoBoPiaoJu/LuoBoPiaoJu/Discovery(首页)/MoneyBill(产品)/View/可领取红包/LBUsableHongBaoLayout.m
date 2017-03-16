//
//  LBUsableHongBaoLayout.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/29.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBUsableHongBaoLayout.h"

#define kColumn 3

@implementation LBUsableHongBaoLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray new];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat lineW = 0;
    for (NSInteger i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        CGFloat height = _cellHeight - (kColumn - 1) * lineW / 2;
        CGFloat width = (kScreenWidth - (kColumn) * lineW) / kColumn;
        NSInteger line = i / kColumn;
        NSInteger row = i % kColumn;
        attrs.frame = CGRectMake(0 + row * (width + lineW), lineW + line * (height + lineW), width, height);
        [array addObject:attrs];
    }
    return array;
}

@end
