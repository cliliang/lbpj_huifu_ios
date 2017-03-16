//
//  LBLuoBoKuaiZhuanVC.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBLuoBoKuaiZhuanVC.h"
#import "LBShuHuiVC.h"
#import "PSSChartView.h"
#import "LBPointModel.h"

@interface LBLuoBoKuaiZhuanVC ()

@property (weak, nonatomic) IBOutlet UIView *view_1111;
@property (weak, nonatomic) IBOutlet UIImageView *img_Image;
@property (weak, nonatomic) IBOutlet UILabel *label_zuorishouyi;
@property (weak, nonatomic) IBOutlet UILabel *label_lijishouyi;
@property (weak, nonatomic) IBOutlet UILabel *label_keshuhuijinE;
@property (weak, nonatomic) IBOutlet UIButton *btn_shuhui;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic, strong) PSSChartView *chartView;
@property (weak, nonatomic) IBOutlet UILabel *label_leijishouyiTitle;
@property (weak, nonatomic) IBOutlet UILabel *label_keshuhuijinETitle;

@property (nonatomic, assign) BOOL returnToTheController;

@property (nonatomic, strong) LBUserModel *userModel;

//@property (nonatomic, assign) NSInteger page;

@end

@implementation LBLuoBoKuaiZhuanVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setUpData];
    [LBHttpStateView httpStatusWithView:self.view refreshBlock:^{
        [self setUpData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.img_Image.backgroundColor = kNavBarColor;
    self.btn_shuhui.backgroundColor = kNavBarColor;
    self.btn_shuhui.layer.cornerRadius = 4;
    [self.view sendSubviewToBack:self.view_1111];
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.title = @"萝卜快赚";
    self.userModel = [LBUserModel getInPhone];
    self.label_zuorishouyi.text = @"";
    self.label_lijishouyi.text = @"";
    self.label_keshuhuijinE.text = @"";

    self.label_leijishouyiTitle.textColor = kColor_707070;
    self.label_keshuhuijinETitle.textColor = kColor_707070;
    self.label_lijishouyi.textColor = kColor_707070;
    self.label_keshuhuijinE.textColor = kColor_707070;
    self.lineView.backgroundColor = kLineColor;
    
//    self.page = 1;
    self.img_Image.image = [UIImage imageNamed:@"image_detailHeader"];
    
    if (kIPHONE_5s) {
        [self.img_Image mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(64 - kJian64);
            make.left.and.right.mas_equalTo(self.view);
            make.height.mas_equalTo(145);
        }];
    }
    [self addChartView];
}

//// 这个方法会走很多遍
//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    static int i = 0;
//    if (i == 0) {
//        [self.chartView drawChartWithTotalMonty:500 dataArr:@[@(100), @(200), @(400), @(200), @(300), @(350)]];
//        NSLog(@"%lf", self.chartView.height);
//        [self.chartView startAnimationWithTime:2];
//        i = 1;
//    }
//}

- (void)setUpData
{
    [MBProgressHUD showHUDAddedTo:kWindow animated:YES];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", URL_HOST, url_wodeluobokuaizhuan];
    NSDictionary *param = @{@"userId":@(self.userModel.userId), @"token":self.userModel.token};
    
//    NSDictionary *param = @{
//                            @"userId":@11050,
//                            @"token":@"v1MK6w2WIR2YRzLAN1XV"
//                            };
    [HTTPTools POSTWithUrl:urlString parameter:param progress:nil success:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        
        [MBProgressHUD hideHUDForView:kWindow animated:YES];
        if ([dict[@"success"] boolValue]) {
            NSString *message = dict[@"message"];
            if ([message isNullOrNil]) {
                return;
            }
            NSArray *rowsArr = dict[@"rows"];
            NSMutableArray *numArray = [NSMutableArray array];
            NSMutableArray *dateArray = [NSMutableArray array];
            if (rowsArr.count == 0) {
                numArray = [@[@(0), @(0), @(0), @(0), @(0)] mutableCopy];
                dateArray = [@[@"", @"", @"", @"", @""] mutableCopy];
            }
            CGFloat maxN = 0;
            for (NSDictionary *dataDic in rowsArr) {
                LBPointModel *model = [LBPointModel mj_objectWithKeyValues:dataDic];
                maxN = maxN > model.incomeSum ? maxN : model.incomeSum;
                NSString *dateStr = model.createTime;
                NSNumber *floatN = [NSNumber numberWithFloat:model.incomeSum];
                [numArray addObject:floatN];
                [dateArray addObject:dateStr];
            }
            if (self.returnToTheController == NO) {
                // 绘制表格
                [self.chartView drawChartWithTotalMonty:maxN * 1.2 dataArr:numArray];
                self.chartView.dateArray = dateArray;
                kLog(@"%lf", self.chartView.height);
                [self.chartView startAnimationWithTime:1.5];
                self.returnToTheController = YES;
            }
            
            NSArray *moneyArray = [message componentsSeparatedByString:@","];
            if (moneyArray.count < 3) {
                return;
            } else {
                self.label_zuorishouyi.text = moneyArray[0];
                self.label_lijishouyi.text = moneyArray[1];
                self.label_keshuhuijinE.text = moneyArray[2];
            }
            if (self.label_keshuhuijinE.text == nil || self.label_keshuhuijinE.text.length == 0 || [self.label_keshuhuijinE.text floatValue] == 0) {
                [self changeShuHuiBtn:NO];
            } else {
                [self changeShuHuiBtn:YES];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:kWindow animated:YES];
    }];
}

// 添加表格视图
- (void)addChartView
{
    PSSChartView *chartView = [[PSSChartView alloc] init];
    self.chartView = chartView;
    [self.view addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.lineView.mas_bottom);
        make.bottom.mas_equalTo(self.btn_shuhui.mas_top).offset(-15);
    }];
    chartView.backgroundColor = [UIColor whiteColor];
}

// 点击赎回
- (IBAction)clickShuHuiBtn:(id)sender {
    
    if (self.userModel.isAutonym == 0) {
        LBWebViewController *webVC = [[LBWebViewController alloc] init];
        webVC.webViewStyle = LBWebViewControllerStyleRenZheng;
        [self.navigationController pushViewController:webVC animated:YES];
        return;
    }
    
//    if (self.userModel.bankCard.length == 0 || [NSObject nullOrNilWithObjc:self.userModel.bankCard]) {
//        LBWebViewController *webVC = [[LBWebViewController alloc] init];
//        webVC.webViewStyle = LBWebViewControllerStyleBindingCard;
//        [self.navigationController pushViewController:webVC animated:YES];
//        return;
//    }
    
    LBShuHuiVC *shuhuiVC = [LBShuHuiVC new];
    [self.navigationController pushViewController:shuhuiVC animated:YES];
}

- (void)changeShuHuiBtn:(BOOL)animation
{
    self.btn_shuhui.userInteractionEnabled = animation;
    self.btn_shuhui.backgroundColor = animation ? kNavBarColor : [UIColor lightGrayColor];
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
