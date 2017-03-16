//
//  LBCheckForUpdateView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/10/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBCheckForUpdateView.h"

#define kCheckForUpdatePath @"checkForUpdatePath"

NSString *appStr = @"appStoreVersion";
NSString *nativeStr = @"nativeVersion";
NSString *spacialStr = @"13";

NSString *const isAppCheckingKey = @"isAppCheckingKey";

@interface LBCheckForUpdateView ()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation LBCheckForUpdateView

+ (void)checkForUpdate
{
    [LBHTTPObject POST_mostVersion:^(NSDictionary * _Nonnull dict, BOOL successOrNot) {
        if (dict[@"rows"][@"ios_version_num"]) {
            [self receiveData:dict[@"rows"][@"ios_version_num"]];
        } else {
            [PSSUserDefaultsTool saveValue:@(NO) WithKey:isAppCheckingKey];
        }
    } failure:^(NSError * _Nonnull error) {
        [PSSUserDefaultsTool saveValue:@(NO) WithKey:isAppCheckingKey];
    }];
}

+ (void)receiveData:(NSString *)sender
{
    NSString *version_appS = sender;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version_native = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [PSSUserDefaultsTool saveValue:version_appS WithKey:appStr];
    [PSSUserDefaultsTool saveValue:version_native WithKey:nativeStr];
    [PSSUserDefaultsTool saveValue:@(NO) WithKey:isAppCheckingKey];
    
    int resInt = [PSSTool compareVersion:version_appS withVersion:version_native]; // >,=,< 对应 1,0,-1 
    if (resInt == 1) {
        kLog(@"旧版本");
        double time1 = [[PSSUserDefaultsTool getValueWithKey:kCheckForUpdatePath] doubleValue];
        double time2 = [[NSDate date] timeIntervalSince1970];
        kLog(@"%lf --- %lf", time1, time2);
        if ([NSDate compareOneDayTimeInt1:time1 timeInt2:time2]) {
            return;
        }
        [PSSUserDefaultsTool saveValue:@(time2) WithKey:kCheckForUpdatePath];
        
        LBCheckForUpdateView *theView = [[self alloc] init];
        [kWindow addSubview:theView];
        [theView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(kWindow);
        }];
        theView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [theView addSubview:imageV];
        
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(theView);
            make.width.mas_equalTo(KAutoWDiv2(493));
            make.height.mas_equalTo(KAutoWDiv2(374));
        }];
        imageV.image = [UIImage imageNamed:@"image_checkUpdate"];
        theView.imageV = imageV;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom normalColor:[UIColor clearColor] highColor:[UIColor clearColor] target:theView action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside title:@""];
        [theView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(imageV);
            make.height.mas_equalTo(KAutoWDiv2(88));
        }];
        
    } else if (resInt == 0) {
        kLog(@"新版本");
    } else {
        kLog(@"app审核中");
        [PSSUserDefaultsTool saveValue:@(YES) WithKey:isAppCheckingKey];
    }
}
- (void)clickButton
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id1050564862"]];
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    BOOL contains = CGRectContainsPoint(self.imageV.frame, touchPoint);
    
    NSString *ver_appStore = [PSSUserDefaultsTool getValueWithKey:appStr];
    NSString *ver_native = [PSSUserDefaultsTool getValueWithKey:nativeStr];
    BOOL isSpacial = ![ver_native isEqualToString:ver_appStore] && [ver_appStore containsString:spacialStr];
    if (!contains && !isSpacial) {
        [self removeFromSuperview];
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
