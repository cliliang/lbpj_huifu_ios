//
//  LBConnectUsVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/16.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBConnectUsVC.h"
#import "LBConnectUsCell.h"

#define kCell @"LBConnectUsCell"

@interface LBConnectUsVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;

@end

@implementation LBConnectUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"联系我们";
    self.titleArray = @[@"官方微博", @"官方微信", @"官方网址", @"邮箱", @"客服电话"];
    self.contentArray = @[@"萝卜票据", @"baluobo-com", @"www.luobopj.com", @"service@luobopj.com", @"400-825-8626"];
    [self addTableViewInThisView];
    [self addHeaderImageView];
}

- (void)addHeaderImageView
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:@"image_login"];
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view.mas_top).offset(132 - kJian64);
    }];
}

// 添加collectionView
- (void)addTableViewInThisView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 - kJian64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.scrollEnabled = NO;
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 135)];
    headerV.backgroundColor = [UIColor whiteColor];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 135)];
    [tableView addSubview:headerV];
    tableView.backgroundColor = kBackgroundColor;
    
    // 第一条线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 135, kScreenWidth, 1)];
    [tableView addSubview:lineView];
    lineView.backgroundColor = kLineColor;
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBConnectUsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBConnectUsCell class]) owner:nil options:nil] firstObject];
    }
    cell.label_title.text = self.titleArray[indexPath.row];
    cell.label_content.text = self.contentArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: // 官方微博
            
            break;
        case 1: // 官方微信
            
            break;
        case 2: // 官方网址
            
            break;
        case 3: // 邮箱
            
            break;
        case 4: // 客服电话
            [self callPhoneNumber];
            break;
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)callPhoneNumber
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"客服电话" message:@"400-825-8626" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"拨打" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://400-825-8626"]];
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertC dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertC addAction:action_1];
    [alertC addAction:action_2];
    [self presentViewController:alertC animated:YES completion:nil];
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
