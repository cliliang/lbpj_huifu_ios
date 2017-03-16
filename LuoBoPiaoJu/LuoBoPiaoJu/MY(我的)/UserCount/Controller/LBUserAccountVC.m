//
//  LBUserAccountVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/14.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBUserAccountVC.h"
#import "LBAccountCell.h"
#import "LBBankCardManagerVC.h"

#define kCell @"AccountCellID"

@interface LBUserAccountVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageNameArray;

@property (nonatomic, strong) LBUserModel *userModel;

@end

@implementation LBUserAccountVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [LBUserModel updateUserWithUserModel:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.userModel = [LBUserModel getInPhone];
        [self.tableView reloadData];
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"账户信息";
    self.titleArray = @[@"手机号码", @"实名认证", @"绑定银行卡"];
    self.view.backgroundColor = kBackgroundColor;
    [self addTableViewInThisView];
    [self addQuitButton];
}

- (void)addQuitButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"安全退出" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRGBString:@"929292"] forState:UIControlStateNormal];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor colorWithRGBString:@"929292"].CGColor;
    [button setBackgroundColor:kBackgroundColor];
    button.layer.cornerRadius = 5;
    button.frame = CGRectMake(35, 252, kScreenWidth - 70, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(clickQuitButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickQuitButton
{
    LBYesOrNoAlert *alert = [LBYesOrNoAlert alertWithMessage:@"是否退出当前账号" sureBlock:^{
        [LBUserModel deleteInPhone];
        [LBUserModel deleteGesPassword];
        [[LBVCManager shareVCManager] instanceMainRoot];
        [LBVCManager hideMessageView];
    }];
    [alert show];
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
    tableView.backgroundColor = kBackgroundColor;
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LBAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LBAccountCell class]) owner:nil options:nil] firstObject];
    }
    cell.label_title.text = self.titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.label_content.text = self.phoneNumber ? self.phoneNumber : @"";
            cell.img_ass.hidden = YES;
            break;
        case 1: {
            NSString *cardStr = [LBUserModel getInPhone].idCard;
            if (cardStr.length == 0 || cardStr == nil || [cardStr isKindOfClass:[NSNull class]]) {
                cell.label_content.text = @"未认证";
            } else {
                NSString *cardS = [NSString stringWithFormat:@"%@****%@", [cardStr substringToIndex:3], [cardStr substringFromIndex:cardStr.length - 3]];
                NSString *resultS = [NSString stringWithFormat:@"%@ %@", [LBUserModel getSecretUserName], cardS];
                cell.label_content.text = resultS;
            }
            break;
        }
        case 2:
            cell.label_content.text = [LBUserModel getSecretBankCard].length ? [LBUserModel getSecretBankCard] : @"未绑定";
            break;
            
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: // 手机号码
            
            break;
        case 1: // 实名认证
            if (!self.userModel.isAutonym) {
                [self loadShiMingRenZheng];
            }
            break;
        case 2: // 绑定银行卡
            [self bindingCard];
            break;
            
        default:
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
// 实名认证
- (void)loadShiMingRenZheng
{
    LBWebViewController *webVC = [LBWebViewController new];
    webVC.webViewStyle = LBWebViewControllerStyleRenZheng;
    [self.navigationController pushViewController:webVC animated:YES];

}
// 绑定银行卡
- (void)bindingCard
{
    LBBankCardManagerVC *bankVC = [LBBankCardManagerVC new];
    [self.navigationController pushViewController:bankVC animated:YES];
    
//    LBWebViewController *webVC = [LBWebViewController new];
//    webVC.webViewStyle = LBWebViewControllerStyleBindingCard;
//    [self.navigationController pushViewController:webVC animated:YES];
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
