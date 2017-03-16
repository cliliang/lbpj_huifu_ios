//
//  PSSPageControl.h
//  PSSPageControl
//
//  Created by 庞仕山 on 16/4/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSSPageControl : UIView

@property (nonatomic, assign) NSInteger selectIndex; // 设置选中

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, assign) NSInteger pageNumber;

/**
 *  初始化
 *
 *  @param itemSize   单个大小
 *  @param itemSpace  间距
 *  @param pageNumber 页数
 *
 *  @return id
 */
- (instancetype)initWithOrigin:(CGPoint)origin
                      ItemSize:(CGSize)itemSize
                     itemSpace:(CGFloat)itemSpace
                    pageNumber:(NSInteger)pageNumber
                 selectedImage:(UIImage *)selectedImage
                   normalImage:(UIImage *)normalImage;






@end
