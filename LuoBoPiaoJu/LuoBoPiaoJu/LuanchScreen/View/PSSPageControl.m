//
//  PSSPageControl.m
//  PSSPageControl
//
//  Created by 庞仕山 on 16/4/6.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSPageControl.h"

//#define kRootItemTag 834765 // 随机值

@interface PSSPageControl ()

@property (nonatomic, strong) NSMutableArray *imageViewArray;

@end

@implementation PSSPageControl

- (instancetype)initWithOrigin:(CGPoint)origin
                      ItemSize:(CGSize)itemSize
                     itemSpace:(CGFloat)itemSpace
                    pageNumber:(NSInteger)pageNumber
                 selectedImage:(UIImage *)selectedImage
                   normalImage:(UIImage *)normalImage
{
    self = [super init];
    if (self) {
        
        CGFloat x = origin.x;
        CGFloat y = origin.y;
        CGFloat width  = itemSize.width * pageNumber + itemSpace * (pageNumber - 1);
        CGFloat height = itemSize.height;
        self.frame = CGRectMake(x, y, width, height);
        self.selectedImage = selectedImage;
        self.normalImage   = normalImage;
        self.pageNumber = pageNumber;
        
        // 添加item图片
        for (int i = 0; i < pageNumber; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + i * (itemSize.width + itemSpace), 0, itemSize.width, itemSize.height)];
            [self addSubview:imageView];
            imageView.image = normalImage;
            [self.imageViewArray addObject:imageView];
            self.selectIndex = 0;
        }
    }
    return self;
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    if (selectIndex > _pageNumber - 1) {
        return;
    }
    _selectIndex = selectIndex;
    for (int i = 0; i < self.imageViewArray.count; i++) {
        UIImageView *imageView = (UIImageView *)self.imageViewArray[i];
        if (i == selectIndex) {
            imageView.image = _selectedImage;
        } else {
            imageView.image = _normalImage;
        }
    }
}

#pragma mark -- 所有懒加载
- (NSMutableArray *)imageViewArray
{
    if (_imageViewArray == nil) {
        _imageViewArray = [NSMutableArray new];
    }
    return _imageViewArray;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
