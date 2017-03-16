//
//  LBBenefitBaseView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBBenefitBaseView.h"
#import "LBBenefitItemView.h"
#import "PSSSegmentControl.h"

@interface LBBenefitBaseView () <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isScroll; //
@property (nonatomic, strong) PSSSegmentControl *segment;
@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation LBBenefitBaseView

- (instancetype)initWithTitleArray:(NSArray *)titleArray
{
    self = [super init];
    if (self) {
        self.backgroundColor = kBackgroundColor;
        
        // 导航条
        PSSSegmentControl *segment = [[PSSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50) titleArray:titleArray];
        segment.bottomLineColor = [UIColor clearColor];
        segment.lineColor = kNavBarColor;
        segment.lineWidth = div_2(87);
        segment.labelFont = [UIFont systemFontOfSize:15 weight:UIFontWeightLight];
        segment.normalColor = kDeepColor;
        segment.selectedColor = kDeepColor;
        segment.lineHeight = 1.5;
        [self addSubview:segment];
        _segment = segment;
        
        // scrollView
        UIScrollView *scrollV = [[UIScrollView alloc] init];
        [self addSubview:scrollV];
        [scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(segment.mas_bottom).offset(0);
            make.left.bottom.mas_equalTo(self);
            make.width.mas_equalTo(kScreenWidth);
        }];
        scrollV.showsHorizontalScrollIndicator = NO;
        scrollV.pagingEnabled = YES;
        scrollV.delegate = self;
        NSMutableArray *viewArr = [NSMutableArray array];
        for (int i = 0; i < titleArray.count; i++) {
            LBBenefitItemView *itemView = [[LBBenefitItemView alloc] init];
            [scrollV addSubview:itemView];
            [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(segment.mas_bottom).offset(-1);
                make.bottom.mas_equalTo(self);
                make.left.mas_equalTo(scrollV).offset(0 + i * kScreenWidth);
                make.width.mas_equalTo(kScreenWidth);
            }];
            [viewArr addObject:itemView];
        }
        [scrollV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo([viewArr lastObject]);
        }];
        _itemsArray = viewArr;
        [segment setButtonBlock:^(NSInteger index) {
            self.isScroll = index != scrollV.contentOffset.x / kScreenWidth;
            [scrollV setContentOffset:CGPointMake(kScreenWidth * index, 0) animated:YES];
        }];
        [self refreshThisView];
    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isScroll) {
        return;
    }
    CGFloat diffF = scrollView.contentOffset.x - (- kScreenWidth / 2);
    CGFloat diffItemF = diffF / kScreenWidth;
    NSInteger diffInt = (NSInteger)diffItemF;
    self.segment.selectedIndex = diffInt;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.isScroll = NO;
}
- (void)setDatas
{
    for (int i = 0; i < _itemsArray.count; i++) {
        LBBenefitItemView *itemView = _itemsArray[i];
        itemView.type = [_typeArray[i] integerValue];
        itemView.url = _url;
    }
}
- (void)refreshThisView
{
    for (int i = 0; i < _itemsArray.count; i++) {
        LBBenefitItemView *itemView = _itemsArray[i];
        [itemView startHeaderRefresh];
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
