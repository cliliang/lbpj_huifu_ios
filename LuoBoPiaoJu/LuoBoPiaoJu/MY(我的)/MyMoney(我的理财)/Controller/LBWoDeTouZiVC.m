//
//  LBWoDeTouZiVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBWoDeTouZiVC.h"
#import "PSSSegmentControl.h"
#import "LBMyMoneyTableView.h"

@interface LBWoDeTouZiVC () <UIScrollViewDelegate>

@property (nonatomic, strong) PSSSegmentControl *segment;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LBMyMoneyTableView *myTableView_1;
@property (nonatomic, strong) LBMyMoneyTableView *myTableView_2;
@property (nonatomic, strong) LBMyMoneyTableView *myTableView_3;
@property (nonatomic, assign) BOOL isScroll; // 

@end

@implementation LBWoDeTouZiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的理财";
    [self addSegmentInThis];
    [self addScrollViewInThisView];    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        
    }];
}
- (void)addSegmentInThis
{
    PSSSegmentControl *segment = [[PSSSegmentControl alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, 35) titleArray:@[@"投资中", @"还款中", @"已还款"]];
    segment.labelFont = [UIFont systemFontOfSize:15];
    segment.lineHeight = 2;
    segment.lineWidth = 58;
    segment.selectedColor = kNavBarColor;
    segment.lineColor = kNavBarColor;
    self.segment = segment;
    [self.view addSubview:self.segment];
    [segment setButtonBlock:^(NSInteger index) {
        self.isScroll = index != self.scrollView.contentOffset.x / kScreenWidth;
        switch (index) {
            case 0: {
                [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                break;
            }
            case 1: {
                [self.scrollView setContentOffset:CGPointMake(kScreenWidth * 1, 0) animated:YES];
                break;
            }
            case 2: {
                [self.scrollView setContentOffset:CGPointMake(kScreenWidth * 2, 0) animated:YES];
                break;
            }
            default:
                break;
        }
    }];
}
- (void)addScrollViewInThisView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segment.bottom, kScreenWidth, kScreenHeight - self.segment.bottom - kJian64)];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
//    scrollView.scrollEnabled = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(kScreenWidth * 3, scrollView.height);
    scrollView.delegate = self;
    // 1
    self.myTableView_1 = [[LBMyMoneyTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, scrollView.height)];
    [self.scrollView addSubview:self.myTableView_1];
    self.myTableView_1.buyflg = 3;
    
    self.myTableView_2 = [[LBMyMoneyTableView alloc] initWithFrame:CGRectMake(0 + 1 * kScreenWidth, 0, kScreenWidth, scrollView.height)];
    [self.scrollView addSubview:self.myTableView_2];
    self.myTableView_2.buyflg = 2;
    
    self.myTableView_3 = [[LBMyMoneyTableView alloc] initWithFrame:CGRectMake(0 + 2 * kScreenWidth, 0, kScreenWidth, scrollView.height)];
    self.myTableView_3.buyflg = 1;
    [self.scrollView addSubview:self.myTableView_3];
    
    self.myTableView_1.VC = self;
    self.myTableView_2.VC = self;
    self.myTableView_3.VC = self;
    
    [self.myTableView_1 startHeaderRefresh];
    [self.myTableView_2 startHeaderRefresh];
    [self.myTableView_3 startHeaderRefresh];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isScroll) {
        return;
    }
    if (scrollView.contentOffset.x < kScreenWidth / 2) {
        self.segment.selectedIndex = 0;
    } else if (scrollView.contentOffset.x < kScreenWidth * 3 / 2) {
        self.segment.selectedIndex = 1;
    } else {
        self.segment.selectedIndex = 2;
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.isScroll = NO;
}

#pragma mark - 所有懒加载

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
