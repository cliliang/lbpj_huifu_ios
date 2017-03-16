//
//  LBVipKindsLayout.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBVipKindsLayout.h"

static const CGFloat PSSItemWH = kDiv2(57); // 高
static const CGFloat PSSItemWW = kDiv2(66); // 宽
static const CGFloat PSSMaxS = (93 * 1.0 / 65);

@implementation LBVipKindsLayout

- (instancetype)init
{
    if (self = [super init]) {
        self.itemSize = CGSizeMake(kAutoW(PSSItemWW), kAutoW(PSSItemWH));
        
        // 横向互动
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}
// 一些初始化工作最好在这里实现
- (void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = CGSizeMake(kAutoW(PSSItemWW), kAutoW(PSSItemWH));
    CGFloat inset = (self.collectionView.frame.size.width - kAutoW(PSSItemWW)) / 2;
    self.sectionInset = UIEdgeInsetsMake(KAutoHDiv2(50), inset, KAutoHDiv2(50), inset);
    self.minimumLineSpacing = KAutoWDiv2(84);
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
    if (self.finishedPosition) {
        self.finishedPosition(CGPointMake(proposedContentOffset.x + adjustOffSetX, proposedContentOffset.y));
    }
    return CGPointMake(proposedContentOffset.x + adjustOffSetX, proposedContentOffset.y);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGRect visiableRect; // 计算可见的矩形框
//    visiableRect.size = self.collectionView.frame.size;
//    visiableRect.origin = self.collectionView.contentOffset;
    CGFloat theWidth = KAutoWDiv2(300 - 70);
    visiableRect.size = CGSizeMake(theWidth, self.collectionView.frame.size.height);
    visiableRect.origin = CGPointMake(self.collectionView.contentOffset.x + div_2(kScreenWidth - theWidth), self.collectionView.contentOffset.y);
    
    
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
        CGFloat minS = 1;
        CGFloat maxS = PSSMaxS;
        CGFloat difS = (maxS - minS) * (abs * 2 / (theWidth + PSSItemWW));
        CGFloat scale = maxS - difS;
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
