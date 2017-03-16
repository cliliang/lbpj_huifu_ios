//
//  PSSFlowLayout.m
//  CollectionViewLearning
//
//  Created by mu-tu on 16/1/25.
//  Copyright © 2016年 PSS. All rights reserved.
//

#import "PSSFlowLayout.h"
static const CGFloat PSSItemWH = kDiv2(218); // 高
static const CGFloat PSSItemWW = kDiv2((218 * 479 * 1.0 / 281)); // 宽
static const CGFloat PSSMaxS = (281 * 1.0 / 218);

@implementation PSSFlowLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(PSSItemWW, PSSItemWH);
        
        // 横向互动
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}
// 一些初始化工作最好在这里实现
- (void)prepareLayout
{
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(PSSItemWW, PSSItemWH);
    CGFloat inset = (self.collectionView.frame.size.width - PSSItemWW) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    self.minimumLineSpacing = kAutoW(53);
    // 每一个cell(item)都有自己的UICollectionViewLayoutAttributes
    // 每一个indexPath都有自己的UICollectionViewLayoutAttributes
}

/**
 *  scrollView滑动停止的时候，返回让scrollView停止的位置
 *
 *  @param proposedContentOffset 原本scrollView停止滚动那一刻的位置
 *  @param velocity              滚动速度
 *
 *  @return 让scrollView滚动的位置
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity

{
    // 计算出scrollView最后会停留的范围
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    // 计算屏幕最中间x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2;
    
    // 取出这个范围内所有的属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    // 遍历所有属性
    CGFloat adjustOffSetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x - centerX) < ABS(adjustOffSetX)) {
            adjustOffSetX = attrs.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + adjustOffSetX, proposedContentOffset.y);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGRect visiableRect; // 计算可见的矩形框
    
    CGSize size = CGSizeMake(self.collectionView.frame.size.width * (1 + 1.6), self.collectionView.frame.size.height);
    CGPoint point = CGPointMake(self.collectionView.contentOffset.x - self.collectionView.frame.size.width * 0.8, self.collectionView.contentOffset.y);
    visiableRect.size = size;
    visiableRect.origin = point;
    
    
//    visiableRect.size = self.collectionView.frame.size;
//    visiableRect.origin = self.collectionView.contentOffset;
    // 1.取得默认的cell的UICollectionViewLayoutAttributes属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    // 计算屏幕最中间的x (屏幕中心点)
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 2.便利所有布局属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        // 判断两个矩形是否相交
        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) {
            continue;
        }
        CGFloat itemCenterX = attrs.center.x;
        // 取绝对值的宏（系统提供）
        CGFloat abs = ABS(itemCenterX - centerX);
//        CGFloat minS = 1;
//        CGFloat maxS = PSSMaxS;
//        CGFloat difS = (maxS - minS) * (abs * 2 / self.collectionView.frame.size.width);
//        CGFloat scale = maxS - difS;
        
        double minS = 0.5;
        double maxS = PSSMaxS;
        double aa = visiableRect.size.width / 2 + PSSItemWW;
        double scale = (minS - maxS) * 1.0 / aa * abs + maxS;

        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
    }
    return array;
}

// 只要发生滑动，就会调用。内部会调用layoutAttributesForElementsInRect方法获得所有cell布局属性
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


@end
