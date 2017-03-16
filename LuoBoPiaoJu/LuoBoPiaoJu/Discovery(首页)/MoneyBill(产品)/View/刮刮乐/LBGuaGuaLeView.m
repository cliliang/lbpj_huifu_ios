//
//  LBGuaGuaLeView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBGuaGuaLeView.h"
#import "HYScratchCardView.h"

@interface LBGuaGuaLeView ()

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_content;



@end

@implementation LBGuaGuaLeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        
        CGFloat x1 = 0;
        CGFloat y1 = KAutoHDiv2(466);
        CGFloat w1 = kScreenWidth;
        CGFloat h1 = KAutoWDiv2(472);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x1, y1, w1, h1)];
        [self addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"image_guaguale"];
        imageView.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
        
        
        
        // 刮刮
        CGFloat insetTop = 18;
        CGFloat w2 = KAutoWDiv2(483);
        CGFloat h2 = KAutoWDiv2(255);
        CGFloat x2 = (kScreenWidth - w2) / 2;
        CGFloat y2 = KAutoWDiv2(146 - 94 + insetTop);
        HYScratchCardView *guagualeView = [[HYScratchCardView alloc] initWithFrame:CGRectMake(x2, y2, w2, h2)];
        [imageView addSubview:guagualeView];
        guagualeView.backgroundColor = [UIColor clearColor];
        
        _guagualeV = guagualeView;
        
//        guagualeView.image = objc_msgSend(guagualeView, NSSelectorFromString(@"imageByColor:"), [UIColor clearColor]);
        guagualeView.image = [UIImage imageNamed:@"bg_guaguale_zhedang"];
        guagualeView.surfaceImage = [UIImage imageNamed:@"image_guaguale_weigua"];
        
        _label_title = guagualeView.label_title;
        _label_content = guagualeView.label_content;
        
        // 取消
        UIImageView *imageV_btn = [UIImageView new];
        imageV_btn.image = [UIImage imageNamed:@"icon_yaoqingyouli_quxiao"];
        [self addSubview:imageV_btn];
        [imageV_btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageView.mas_bottom).offset(KAutoHDiv2(30));
            make.centerX.mas_equalTo(self);
            make.width.height.mas_equalTo(KAutoWDiv2(70));
        }];
        imageV_btn.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancel)];
        [imageV_btn addGestureRecognizer:tapGes];
        
        
        
    }
    return self;
}

- (void)clickCancel
{
    [self removeFromSuperview];
}

+ (void)showWithView:(UIView *)view
{
    LBGuaGuaLeView *theView = [[LBGuaGuaLeView alloc] init];
    theView.frame = view.bounds;
    [view addSubview:theView];
    [theView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(view);
    }];
}
+ (instancetype)showWithtitle:(NSString *)title content:(NSString *)content
{
    LBGuaGuaLeView *theView = [[LBGuaGuaLeView alloc] init];
    theView.label_title.text = title;
    theView.label_content.text = content;
    [kWindow addSubview:theView];
    [theView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(kWindow);
    }];
    return theView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
