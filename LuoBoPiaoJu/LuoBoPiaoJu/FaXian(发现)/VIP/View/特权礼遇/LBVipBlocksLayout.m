//
//  LBVipBlocksLayout.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBVipBlocksLayout.h"

@implementation LBVipBlocksLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray new];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat lineW = 0.5;
    for (NSInteger i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        CGFloat height = div_2(180) - 3 * lineW / 2;
        CGFloat width = (kScreenWidth - 3 * lineW) / 4;
        NSInteger line = i / 4;
        NSInteger row = i % 4;
        attrs.frame = CGRectMake(0 + row * (width + lineW), lineW + line * (height + lineW), width, height);
        [array addObject:attrs];
    }
    return array;
}

@end
