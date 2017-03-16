//
//  LBViewController.m
//  BaLuoBoLiCai
//
//  Created by 庞仕山 on 16/5/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBViewController.h"
#import "UIImage+PSSImage.h"

@interface LBViewController ()

@end

@implementation LBViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRGBString:@"ff6e54"] size:CGSizeMake(1.0, 1.0)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[LBHttpStateView class]]) {
            [obj removeFromSuperview];
        }
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addReturnNavigationBarInBase];
    self.navigationItem.title = self.navcTitle ? self.navcTitle : self.navigationItem.title;
    
    
}



- (void)addReturnNavigationBarInBase
{
    UIBarButtonItem *returnBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_return"] style:UIBarButtonItemStylePlain target:self action:@selector(baseReturn)];
    self.navigationItem.leftBarButtonItem = returnBarItem;
}
- (void)baseReturn
{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)popIfFirstViewController
//{
//    NSArray *controllers = self.navigationController.viewControllers;
//    if ([self isEqual:[controllers lastObject]] && ![self isEqual:[controllers firstObject]]) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

- (void)setNavcTitle:(NSString *)navcTitle
{
    _navcTitle = navcTitle;
    self.navigationItem.title = navcTitle;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
