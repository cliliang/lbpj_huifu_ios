//
//  PSSToast.m
//  OMGToast
//
//  Created by 庞仕山 on 16/9/19.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSToast.h"
#import <Masonry.h>

@interface PSSToast ()

@property (nonatomic, assign) NSInteger toastCount; // 随机ID
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation PSSToast

+ (instancetype)shareToast
{
    static PSSToast *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (toast == nil) {
            toast = [[PSSToast alloc] init];
            toast.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            toast.layer.cornerRadius = 4;
            toast.toastCount = 0;
        }
    });
    return toast;
}

- (void)showMessage:(NSString *)message
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.messageLabel.text = message;
    if (!self.superview) {
        [window addSubview:self];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(window);
            make.width.mas_lessThanOrEqualTo(window).multipliedBy(0.66);
        }];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageLabel).offset(-6);
            make.left.mas_equalTo(self.messageLabel).offset(-9);
            make.bottom.mas_equalTo(self.messageLabel).offset(6);
            make.right.mas_equalTo(self.messageLabel).offset(9);
        }];
        self.toastCount++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.toastCount--;
            if (self.toastCount == 0) {
                [self removeFromSuperview];
            }
        });
    }
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel new];
        [self addSubview:_messageLabel];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightLight];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
