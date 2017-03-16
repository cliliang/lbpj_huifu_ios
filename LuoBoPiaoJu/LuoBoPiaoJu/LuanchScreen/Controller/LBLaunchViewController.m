//
//  LBLaunchViewController.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/7/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  启动页

#import "LBLaunchViewController.h"
#import "AppDelegate.h"
#import "LuanchScreenViewController.h"
#import "LBGuangGaoImgModel.h"

#define KDefaultImg [UIImage imageNamed:@"qidongtu5342"]


#define kStartGuangGaoTimeKey @"StartGuangGaoTimeKey"
#define kEndGuangGaoTimeKey @"EndGuangGaoTimeKey"
#define kGuangGaoUrlKey @"GuangGaoUrlKey"

#define kAllTime 4
#define kItemTime 1

@interface LBLaunchViewController ()
{
    NSString *imgUrlStr;
    double startTime;
    double endTime;
}
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) double timeTag;

@end

@implementation LBLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [self.view addSubview:imageV];
    _imageView = imageV;
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    imageV.image = KDefaultImg;
    
    // 判断本地需不需要显示缓存图片
    startTime = [[PSSUserDefaultsTool getValueWithKey:kStartGuangGaoTimeKey] doubleValue];
    endTime = [[PSSUserDefaultsTool getValueWithKey:kEndGuangGaoTimeKey] doubleValue];
    double nowTime = [[NSDate date] timeIntervalSince1970];
    imgUrlStr = [PSSUserDefaultsTool getValueWithKey:kGuangGaoUrlKey];
    if (nowTime >= startTime && nowTime <= endTime) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:kAppendingUrl(imgUrlStr)] placeholderImage:KDefaultImg];
    }
    
    [self setupImageData];
    
    _timeTag = kAllTime;
    _timer = [NSTimer scheduledTimerWithTimeInterval:kItemTime target:self selector:@selector(timeRun) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)timeRun
{
    _timeTag -= kItemTime;
    if (_timeTag <= 0) {
        [_timer invalidate];
        [self startProgram];
    }
}
- (void)startProgram
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        LBVCManager *manager = [LBVCManager shareVCManager];
        [manager instanceMainRoot];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        if (![[PSSUserDefaultsTool getValueWithKey:kVersionKey] isEqualToString:app_Version]) {
            [PSSUserDefaultsTool saveValue:app_Version WithKey:kVersionKey];
            LuanchScreenViewController *launchVC = [LuanchScreenViewController new];
            [UIApplication sharedApplication].delegate.window.rootViewController = launchVC;
            [launchVC setNextBlock:^{
                [manager instanceMainRoot];
            }];
            if ([app_Version isEqualToString:@"2.2"]) {
                [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:YES] WithKey:kLiJiJiaRuFirst];
                [PSSUserDefaultsTool saveValue:[NSNumber numberWithBool:YES] WithKey:kHuiYuanTeQuanFirst];
            }
        }
//    });
}

- (void)setupImageData
{
    [LBHTTPObject POST_guangGaoPage:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if (![NSObject nullOrNilWithObjc:dict] && [dict[@"success"] boolValue]) {
            LBGuangGaoImgModel *model = [LBGuangGaoImgModel mj_objectWithKeyValues:dict[@"rows"]];
            if (model.activityPic) {
                if ([imgUrlStr isEqualToString:model.activityPic] && startTime == model.startTimeStamp && endTime == model.endTimeStamp) {
                    // 本地和网上相同, 啥也不干
                } else {
                    // 不同, 替换,并下载
                    [PSSUserDefaultsTool saveValue:model.activityPic WithKey:kGuangGaoUrlKey];
                    [PSSUserDefaultsTool saveValue:@(model.startTimeStamp * 1.0 / 1000) WithKey:kStartGuangGaoTimeKey];
                    [PSSUserDefaultsTool saveValue:@(model.endTimeStamp * 1.0 / 1000) WithKey:kEndGuangGaoTimeKey];
                    _imageView.image = KDefaultImg;
                    [[SDWebImageManager sharedManager] downloadImageWithURL:kAppendingUrl(model.activityPic).mj_url options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                        _imageView.image = image;
                        _timeTag = kAllTime;
                    }];
                }
            } else {
                // 图片为空
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kGuangGaoUrlKey];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kStartGuangGaoTimeKey];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:kEndGuangGaoTimeKey];
                _imageView.image = KDefaultImg;
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
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
