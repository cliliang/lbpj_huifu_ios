//
//  LBXiangMuShenHe.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  项目审核
//

#import "LBXiangMuShenHe.h"
#import <MJPhotoBrowser.h>

@interface LBXiangMuShenHe ()

@end

@implementation LBXiangMuShenHe

- (instancetype)initWithStyle:(LBXiangMuShenHeStyle)style
{
    self = [super init];
    if (self) {
        [self refreshWithStyle:style];
    }
    return self;
}

- (void)refreshWithStyle:(LBXiangMuShenHeStyle)style
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    // 添加scrollView
    UIScrollView *scrollView = [UIScrollView new];
    [self addSubview:scrollView];
    scrollView.bounces = NO;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    scrollView.backgroundColor = [UIColor whiteColor];
    
    //        _imageV = [[UIImageView alloc] init];
    //        [scrollView addSubview:_imageV];
    //        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.left.mas_equalTo(scrollView).offset(10);
    //            make.top.mas_equalTo(scrollView).offset(10);
    //            make.width.mas_equalTo(scrollView).offset(-20);
    //            make.height.mas_equalTo(_imageV.mas_width).multipliedBy(286.0/710);
    //        }];
    //        _imageV.backgroundColor = kNavBarColor;
    
    //  style -- 银票苗
    if (style == LBXiangMuShenHe_YinPiaoMiao) {
        // 添加图片
        _imageV = [[UIImageView alloc] init];
        [scrollView addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(scrollView).offset(10);
            make.top.mas_equalTo(scrollView).offset(10);
            make.width.mas_equalTo(scrollView).offset(-20);
            make.height.mas_equalTo(_imageV.mas_width).multipliedBy(286.0/710);
        }];
        _imageV.backgroundColor = kNavBarColor;
        
        // 票据保障
        UILabel *label_1 = [UILabel new];
        [scrollView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_imageV.mas_bottom).offset(10);
            make.centerX.mas_equalTo(_imageV);
        }];
        label_1.text = @"票据保障";
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.textColor = [UIColor colorWithRGBString:@"404040" withAlpha:1];
        // 内容
        UILabel *label_2 = [UILabel new];
        [scrollView addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_1.mas_bottom).offset(10);
            make.left.mas_equalTo(scrollView.mas_left).offset(26);
            make.right.mas_equalTo(self.mas_right).offset(-26);
            //            make.width.mas_equalTo(scrollView.mas_width).offset(-52);
        }];
        label_2.numberOfLines = 0;
        label_2.font = [UIFont systemFontOfSize:13];
        label_2.textColor = [UIColor colorWithRGBString:@"707070" withAlpha:1];
        NSString *string_2 = @"平台所有票据均由浙商银行检验真伪，并委托保管至到期托收，彻底杜绝一票两融，确保投资者本息安全。";
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string_2];
        NSMutableParagraphStyle *paragraphS = [[NSMutableParagraphStyle alloc] init];
        [paragraphS setLineSpacing:6]; // 行距
        [attributeString addAttribute:NSParagraphStyleAttributeName value:paragraphS range:NSMakeRange(0, string_2.length)];
        label_2.attributedText = attributeString;
        
        // 温馨提示
        UILabel *label_3 = [UILabel new];
        [scrollView addSubview:label_3];
        [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_2.mas_bottom).offset(10);
            make.centerX.mas_equalTo(self);
        }];
        label_3.text = @"温馨提示";
        label_3.font = [UIFont systemFontOfSize:15];
        label_3.textColor = [UIColor colorWithRGBString:@"404040" withAlpha:1];
        // 内容
        UILabel *label_4 = [UILabel new];
        [scrollView addSubview:label_4];
        [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_3.mas_bottom).offset(10);
            make.left.mas_equalTo(self.mas_left).offset(26);
            make.right.mas_equalTo(self.mas_right).offset(-26);
        }];
        label_4.numberOfLines = 0;
        label_4.font = [UIFont systemFontOfSize:13];
        label_4.textColor = [UIColor colorWithRGBString:@"707070" withAlpha:1];
        NSString *string_4 = @"为了保护融资人的隐私，平台将隐去银行承兑汇票票号，公司名称，法人名称。";
        NSMutableAttributedString *attributeString_1 = [[NSMutableAttributedString alloc] initWithString:string_4];
        NSMutableParagraphStyle *paragraphS_1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphS_1 setLineSpacing:6]; // 行距
        [attributeString_1 addAttribute:NSParagraphStyleAttributeName value:paragraphS_1 range:NSMakeRange(0, string_4.length)];
        label_4.attributedText = attributeString_1;
        
        // 四个想按钮的东西
        UIButton *button_1 = [UIButton buttonWithType:UIButtonTypeCustom];
        button_1.backgroundColor = [UIColor colorWithRGBString:@"99e9f7" withAlpha:1];
        [button_1 setTitle:@"银行查验票据真伪" forState:UIControlStateNormal];
        [button_1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button_1.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIButton *button_2 = [UIButton buttonWithType:UIButtonTypeCustom];
        button_2.backgroundColor = [UIColor colorWithRGBString:@"ffc562" withAlpha:1];
        [button_2 setTitle:@"银行查询无异常" forState:UIControlStateNormal];
        [button_2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button_2.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIButton *button_3 = [UIButton buttonWithType:UIButtonTypeCustom];
        button_3.backgroundColor = [UIColor colorWithRGBString:@"ffb899" withAlpha:1];
        [button_3 setTitle:@"票据均由银行保管" forState:UIControlStateNormal];
        [button_3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button_3.titleLabel.font = [UIFont systemFontOfSize:15];
        
        UIButton *button_4 = [UIButton buttonWithType:UIButtonTypeCustom];
        button_4.backgroundColor = [UIColor colorWithRGBString:@"6ee3b2" withAlpha:1];
        [button_4 setTitle:@"票据均由银行托收" forState:UIControlStateNormal];
        [button_4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button_4.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [scrollView addSubview:button_1];
        [scrollView addSubview:button_2];
        [scrollView addSubview:button_3];
        [scrollView addSubview:button_4];
        
        if (kIPHONE_5s) {
            button_1.titleLabel.font = [UIFont systemFontOfSize:13];
            button_2.titleLabel.font = [UIFont systemFontOfSize:13];
            button_3.titleLabel.font = [UIFont systemFontOfSize:13];
            button_4.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        
        [button_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_4.mas_bottom).offset(17);
            make.left.mas_equalTo(self).offset(27);
            if (kIPHONE_5s) {
                make.right.mas_equalTo(button_2.mas_left).offset(-30);
            } else {
                make.right.mas_equalTo(button_2.mas_left).offset(-60);
            }
            make.height.mas_equalTo(32);
            make.width.mas_equalTo(button_2);
        }];
        
        [button_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button_1);
            make.right.mas_equalTo(self).offset(-27);
            make.height.mas_equalTo(32);
        }];
        [button_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button_1.mas_bottom).offset(10);
            make.left.mas_equalTo(self).offset(27);
            if (kIPHONE_5s) {
                make.right.mas_equalTo(button_4.mas_left).offset(-30);
            } else {
                make.right.mas_equalTo(button_4.mas_left).offset(-60);
            }
            make.height.mas_equalTo(32);
            make.width.mas_equalTo(button_4);
        }];
        [button_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button_2.mas_bottom).offset(10);
            make.right.mas_equalTo(self).offset(-27);
            make.height.mas_equalTo(32);
        }];
        
        [scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(button_4).offset(26).priorityLow();
        }];
    } else {
        
        
        NSString *string_1 = @"“萝卜快赚” 是拔萝卜推出的期限灵活型投资理财产品";
        NSString *string_2 = @"“萝卜快赚” 为融资方将存于保管银行内的部分票据资产作为全额本息担保的投资标，是随买随赎的一款活期理财产品";
        switch (style) {
            case LBXiangMuShenHe_XinShou:
                string_1 = @"“新手抢赚” 是平台针对新手用户推出的一款理财产品";
                string_2 = @"“新手抢赚” 是融资方将保管于银行内的部分票据资产作为全额本息担保的投资标，是面向新手的一款定期类理财产品";
                break;
            case LBXiangMuShenHe_LuoBoDingtou:
                string_1 = @"“萝卜定投” 是平台专为用户推出的一款理财产品";
                string_2 = @"“萝卜定投” 是融资方将保管于银行内的部分票据资产作为全额本息担保的投资标，是面向用户的一款定期类理财产品";
                break;
                
            default:
                break;
        }
        
        // 1
        UILabel *label_1 = [UILabel new];
        [scrollView addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(scrollView.mas_top).offset(15);
            make.left.mas_equalTo(self.mas_left).offset(25);
            make.right.mas_equalTo(self.mas_right).offset(-25);
            //                make.height.
        }];
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:13];
        label_1.textColor = [UIColor colorWithRGBString:@"707070"];
        NSMutableAttributedString *attributeString_1 = [[NSMutableAttributedString alloc] initWithString:string_1];
        NSMutableParagraphStyle *paragraphS_1 = [[NSMutableParagraphStyle alloc] init];
        // 行距
        [paragraphS_1 setLineSpacing:8];
        [attributeString_1 addAttribute:NSParagraphStyleAttributeName value:paragraphS_1 range:NSMakeRange(0, string_1.length)];
        // 字体
        [attributeString_1 addAttribute:NSForegroundColorAttributeName value:kDeepColor range:NSMakeRange(0, 6)];
        label_1.attributedText = attributeString_1;
        
        
        // 2
        UILabel *label_2 = [UILabel new];
        [scrollView addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_1.mas_bottom).offset(2);
            make.left.mas_equalTo(self.mas_left).offset(25);
            make.right.mas_equalTo(self.mas_right).offset(-25);
        }];
        label_2.numberOfLines = 0;
        label_2.font = [UIFont systemFontOfSize:13];
        label_2.textColor = [UIColor colorWithRGBString:@"707070"];
        NSMutableAttributedString *attributeString_2 = [[NSMutableAttributedString alloc] initWithString:string_2];
        NSMutableParagraphStyle *paragraphS_2 = [[NSMutableParagraphStyle alloc] init];
        // 行距
        [paragraphS_2 setLineSpacing:8];
        [attributeString_2 addAttribute:NSParagraphStyleAttributeName value:paragraphS_1 range:NSMakeRange(0, string_2.length)];
        // 字体
        [attributeString_2 addAttribute:NSForegroundColorAttributeName value:kDeepColor range:NSMakeRange(0, 6)];
        
        label_2.attributedText = attributeString_2;
        
        [scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(label_2).offset(26).priorityLow();
        }];
    }
}

- (void)tapImageView
{
    MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString:self.imageUrl];
    photo.srcImageView = self.imageV;
    NSArray *photoArray = @[photo];
    photoBrowser.photos = photoArray;
    [photoBrowser show];
    
}


- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    _imageV.userInteractionEnabled = YES;
    [_imageV addGestureRecognizer:tapGes];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
