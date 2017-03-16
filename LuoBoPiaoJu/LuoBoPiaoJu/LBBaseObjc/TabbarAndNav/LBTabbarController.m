//
//  LBTabbarController.m
//  BaLuoBoLiCai
//
//  Created by 庞仕山 on 16/5/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBTabbarController.h"
#import "LBTabbar.h"
#import "LBVCManager.h"
#import "LBNavigationController.h"

@interface LBTabbarController ()

@end

@implementation LBTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self replaceTabbar];
}

- (void)replaceTabbar
{
    LBTabbar *tabbar = [[LBTabbar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
}

- (void)addTabbarItemNavWithClass:(Class)class
                            title:(NSString *)title
                  normalImageName:(NSString *)normalImageName
                selectedImageName:(NSString *)selectedImageName
                         adjuestX:(CGFloat)adjuestX
{
    UIViewController *viewC = [[class alloc] init];
    viewC.view.backgroundColor = [UIColor whiteColor];
    LBNavigationController *naVC = [[LBNavigationController alloc] initWithRootViewController:viewC];
    UITabBarItem *tabbarItem = naVC.tabBarItem;
    tabbarItem.title = title;
    tabbarItem.image = [[UIImage imageNamed:normalImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    [self addChildViewController:naVC];
}

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
