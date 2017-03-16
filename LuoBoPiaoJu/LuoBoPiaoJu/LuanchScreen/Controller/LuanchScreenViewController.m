//
//  LuanchScreenViewController.m
//  baluobo
//
//  Created by BIHUA－PEI on 15/10/20.
//  Copyright © 2015年 BIHUA－PEI. All rights reserved.
//


#define ONESCREEN ([UIScreen mainScreen].bounds.size.height == 480)
#import "LuanchScreenViewController.h"
#import "PSSPageControl.h"
#import "PSSImageCVCell.h"
#import "UIButton+PSButton.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize   [UIScreen mainScreen].bounds.size


@interface LuanchScreenViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UIButton    *nextButton;
    UIImageView *bgImageV; // 下一步buttom 背景图
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imageNameArray;
@property (nonatomic, strong) PSSPageControl *pageControl;

@end

@implementation LuanchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加collectionView
    [self addCollectionViewInThisView];
    
//     添加自定义pageControl
    [self addPageControlInThisView];
    
    // 添加下一步button
    [self addNextButton];
}

- (void)addNextButton
{
    
    CGFloat buttonWidth = div_2(341);
    CGFloat buttonHeight = div_2(72);
    CGFloat button_X = (kScreenWidth - buttonWidth) / 2;
    CGFloat button_Y = kScreenHeight - div_2(173 + 72);
    
    if (kIPHONE_6s) {
        buttonWidth = div_2(341);
        buttonHeight = div_2(72);
        button_X = (kScreenWidth - buttonWidth) / 2;
        button_Y = kScreenHeight - div_2(207 + 72);
    } else if (kIPHONE_6P) {
        buttonWidth = div_3(564);
        buttonHeight = div_3(118);
        button_X = (kScreenWidth - buttonWidth) / 2;
        button_Y = kScreenHeight - div_3(343 + 118);
    }
    

    // 背景图
    UIImageView *imageView = [UIImageView new];
    bgImageV = imageView;
    imageView.backgroundColor = kNavBarColor;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 5;
    imageView.frame = CGRectMake(3 * kScreenWidth + button_X, button_Y, buttonWidth, buttonHeight);
    [self.collectionView addSubview:imageView];
    imageView.alpha = 0;
    
    // 按钮
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor whiteColor] highColor:[UIColor whiteColor] target:self action:@selector(leadClick) forControlEvents:UIControlEventTouchUpInside title:@"立即体验"];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    nextButton.frame = imageView.frame;
    nextButton.alpha = 0;
    
    [self.collectionView addSubview:nextButton];
}

- (void)addPageControlInThisView
{
    
    CGPoint point = CGPointMake(div_2(267), kScreenHeight - div_2(131 + 22));
    if (kIPHONE_6P) {
        point = CGPointMake(div_3(442.0), kScreenHeight - div_3(217 + 38));
    } else if (kIPHONE_5s) {
        point = CGPointMake(div_3(267), kScreenHeight - div_2(110 + 22));
    }
    // 添加自定义pageControl
    PSSPageControl *pageControl = [[PSSPageControl alloc] initWithOrigin:point ItemSize:CGSizeMake(11, 11) itemSpace:22 pageNumber:4 selectedImage:[UIImage imageNamed:@"selectImage"] normalImage:[UIImage imageNamed:@"normalImage"]];
    pageControl.center = CGPointMake(self.view.center.x, kScreenHeight - div_2(131 + 11));
    
    // 适配5s
    if (kIPHONE_5s) {
        pageControl.center = CGPointMake(self.view.center.x, kScreenHeight - div_2(110 + 11));
    } else if (kIPHONE_6P) {
        pageControl.center = CGPointMake(self.view.center.x, kScreenHeight - div_3(217.0 + 19));
    }
    
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

// 点击下一步
- (void)leadClick {
    self.nextBlock();
}

// 添加collectionView
- (void)addCollectionViewInThisView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    [collectionView registerNib:[UINib nibWithNibName:@"PSSImageCVCell" bundle:nil] forCellWithReuseIdentifier:@"CVCell"];
    [self.view addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
}

#pragma mark -- collectionView代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PSSImageCVCell *cell = (PSSImageCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"CVCell" forIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.imageNameArray[indexPath.row]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (NSInteger i = 0; i < 4; i++) {
        CGFloat contentOffSizeX = scrollView.contentOffset.x / kScreenWidth;
        if (i - 0.5 < contentOffSizeX && contentOffSizeX < i + 0.5) {
            if (self.pageControl.selectIndex != i) {
                self.pageControl.selectIndex = i;
            }
        }
    }
    // 最后一页显示下一步
    if (scrollView.contentOffset.x / kScreenWidth == 3) {
        [UIView animateWithDuration:0.2 animations:^{
            bgImageV.alpha = 1;
            nextButton.alpha = 1;
        }];
    } else {
        bgImageV.alpha = 0;
        nextButton.alpha = 0;
    }
}

- (void)setNextBlock:(CheckNextBlock)nextBlock
{
    _nextBlock = nextBlock;
}

#pragma mark -- 所有懒加载
- (NSArray *)imageNameArray
{
    if (_imageNameArray == nil) {
        _imageNameArray = @[@"launchImage0", @"launchImage1", @"launchImage2.png", @"launchImage3"];
    }
    return _imageNameArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
