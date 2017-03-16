//
//  LBXinShouKuaiZhuanCell.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/20.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBXinShouKuaiZhuanCell.h"

@interface LBXinShouKuaiZhuanCell ()

@property (weak, nonatomic) IBOutlet UIView *view_back;
@property (nonatomic, strong) PSSCircleProgressView *circleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_zuoBian; // 年化收益左侧
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_baifenbi; // 百分比左边
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_time;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_xiaoShouJinDu; // 销售进度label顶部
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *right_xiaoShouJinDu; // 销售进度label右侧距离

@property (weak, nonatomic) IBOutlet UILabel *label_baiFenHao;
@property (weak, nonatomic) IBOutlet UILabel *label_nianHuaShouYe_zi;
@property (weak, nonatomic) IBOutlet UILabel *label_liCaiQiXian_zi;
@property (weak, nonatomic) IBOutlet UILabel *label_tian_zi;

@property (nonatomic, strong) UILabel *label_timeCount;
@property (nonatomic, strong) UILabel *label_timeCountTitle;

@property (nonatomic, strong) UIImageView *imgV_kuaiZhuan;

@property (nonatomic, strong) UIImageView *imageV_new;

@end

@implementation LBXinShouKuaiZhuanCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
//    self.view_back.layer.cornerRadius = 5;
    self.contentView.backgroundColor = kBackgroundColor;
    // 颜色
    self.label_title.textColor = kDeepColor;
    self.label_bankCardName.textColor = kLightColor;
    self.label_centerNumber.textColor = kLightColor;
    self.label_nianHuaShouYe.textColor = kNavBarColor;
    self.label_nianHuaShouYe_zi.textColor = kLightColor;
    self.label_baiFenHao.textColor = kLightColor;
    self.label_liCaiQiXian_zi.textColor = kLightColor;
    
    
    UIView *centerView = [UIView new];
    [self.view_back addSubview:centerView];
    
    UILabel *label_time = [UILabel new];
    [label_time setText:@"" textColor:kColor_707070 font:[UIFont pingfangWithFloat:30 weight:UIFontWeightLight]];
    [centerView addSubview:label_time];
    [label_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.label_nianHuaShouYe);
        make.height.mas_equalTo(27);
    }];
    self.label_time = label_time;
    
    UILabel *label_tian = [UILabel new];
    [label_tian setText:@"天" textColor:kLightColor font:[UIFont pingfangWithFloat:11 weight:UIFontWeightLight]];
    [centerView addSubview:label_tian];
    self.label_tian_zi = label_tian;
    [label_tian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_time.mas_right).offset(-1);
        make.bottom.mas_equalTo(label_time.mas_bottom).offset(0);
    }];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(label_time);
        make.right.mas_equalTo(label_tian);
        make.centerX.mas_equalTo(self.view_back);
    }];
    
    
    CGFloat top = kDiv2(250 / 2); // 圆点距离顶部
    CGFloat right = 75.0 / 2 + 15; // 圆点距离右边
    CGFloat width = 75;
    UILabel *label1 = [UILabel new];
    [label1 setText:@"" textColor:kDeepColor font:[UIFont systemFontOfSize:15 weight:UIFontWeightLight]];
    self.label_centerNumber = label1;
    [self.view_back addSubview:label1];
    
    
    
    CGFloat value1 = -8; // 数字上移
    if (kIPHONE_5s) {
        width = 70;
        right = right - 10;
        [self.label_centerNumber mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view_back.mas_right).offset(-right - 5);
            make.centerY.mas_equalTo(self.view_back.mas_top).offset(top + value1);
            make.height.mas_equalTo(13);
        }];
    } else {
        [self.label_centerNumber mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view_back.mas_right).offset(-right - 5);
            make.centerY.mas_equalTo(self.view_back.mas_top).offset(top + value1);
            make.height.mas_equalTo(13);
        }];
    }
    
    // 剩余(元)
    UILabel *label2 = [UILabel new];
    [label2 setText:@"剩余(元)" textColor:kLightColor font:[UIFont pingfangWithFloat:11 weight:UIFontWeightLight]];
    [self.view_back addSubview:label2];
    self.label_shengYu = label2;
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(label1.mas_bottom).offset(5);
        make.centerX.mas_equalTo(label1);
    }];
    
    UILabel *label3 = [UILabel new];
    [label3 setText:@"抢光" textColor:[UIColor colorWithRGBString:@"e6e6e6"] font:[UIFont pingfangWithFloat:16 weight:UIFontWeightRegular]];
    [self.view_back addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view_back.mas_right).offset(-right - 5);
        make.centerY.mas_equalTo(self.view_back.mas_top).offset(top);
        make.height.mas_equalTo(15);
    }];
    self.label_qiangGuang = label3;
    label3.hidden = YES;
    
    CGFloat x = kScreenWidth - (right + width / 2 + 15);
    CGFloat y = top - width / 2;
    
    if (_circleView == nil) {
        _circleView = [[PSSCircleProgressView alloc] initWithFrame:CGRectMake(x, y, width, width) lineWidth:3.5 unfinishedColor:[UIColor colorWithRGBString:@"e6e6e6"] finishedColor:kNavBarColor];
        _circleView.strokeStart = 0;
        _circleView.strokeEnd = 0.5;
        [self addSubview:_circleView];
    }
    
    // 倒计时title
    UILabel *label5 = [UILabel new];
    [label5 setText:@"抢购倒计时" textColor:kNavBarColor font:[UIFont pingfangWithFloat:11 weight:UIFontWeightLight]];
    [self.view_back addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view_back).offset(-(right - width / 2 + 23));
        make.top.mas_equalTo(self.label_liCaiQiXian_zi);
        make.height.mas_equalTo(11);
    }];
    label5.hidden = YES;
    _label_timeCountTitle = label5;
    
    // 倒计时
    UILabel *label4 = [UILabel new];
    [label4 setText:@"" textColor:kNavBarColor font:[UIFont pingfangWithFloat:25 weight:UIFontWeightLight]];
    [self.view_back addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(label5);
        make.bottom.mas_equalTo(self.label_time);
        make.height.mas_equalTo(25);
    }];
    label4.hidden = YES;
    _label_timeCount = label4;
    
    
    
    UIImageView *imgV1 = [[UIImageView alloc] init];
    [self.view_back addSubview:imgV1];
    [imgV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view_back).offset(-(right - width / 2));
//        make.centerY.mas_equalTo(self.view_back.mas_top).offset(kDiv2(95 + 114.0 / 2));
        make.bottom.mas_equalTo(self.label_nianHuaShouYe_zi);
        make.width.mas_equalTo(KAutoWDiv2(198));
        make.height.mas_equalTo(KAutoWDiv2(114));
    }];
    self.imgV_kuaiZhuan = imgV1;
    imgV1.hidden = YES;
    imgV1.image = [UIImage imageNamed:@"img_shouye_kuaizhuan"];
    
    UIImageView *imageV_new = [UIImageView new];
    imageV_new.image = [UIImage imageNamed:@"image_shouye_new"];
    [self.view_back addSubview:imageV_new];
    [imageV_new mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.label_title);
        make.left.mas_equalTo(self.label_title.mas_right).offset(KAutoHDiv2(22));
        make.width.height.mas_equalTo(KAutoHDiv2(30));
    }];
    imageV_new.hidden = YES;
    self.imageV_new = imageV_new;
}

- (void)animationWithTime:(CGFloat)time
{
    if (_circleView) {
        [_circleView animationWithTime:time];
    }
}

- (void)setGoodModel:(LBGoodsModel *)goodModel
{
    _goodModel = goodModel;
    _label_title.text = goodModel.goodName;
    _label_nianHuaShouYe.text = [NSString stringWithFormat:@"%.2lf", goodModel.proceeds];
    _label_time.text = [NSString stringWithFormat:@"%ld", (long)goodModel.investTime];
    CGFloat progress = (goodModel.buyMoney - goodModel.surplusMoney) / goodModel.buyMoney;
    _circleView.strokeEnd = progress;
    _label_centerNumber.text = [NSString stringWithFormat:@"%ld", (long)goodModel.surplusMoney];
    
    NSString *theString = goodModel.payLabel;
    if (theString.length > 8) {
        theString = [theString substringWithRange:NSMakeRange(3, theString.length - 8)];
        if (theString.length > 12) {
            NSString *string1 = [theString substringWithRange:NSMakeRange(0, 12)];
            theString = [NSString stringWithFormat:@"%@...", string1];
        }
    }
    self.label_bankCardName.text = theString;
    
    self.circleView.hidden = NO;
    
    if (progress == 1) {
        self.label_qiangGuang.hidden = NO;
        self.label_centerNumber.hidden = YES;
        self.label_shengYu.hidden = YES;
        _imageV_new.hidden = YES;
    } else {
        self.label_qiangGuang.hidden = YES;
        self.label_centerNumber.hidden = NO;
        self.label_shengYu.hidden = NO;
        _imageV_new.hidden = NO;
    }
    

    if (goodModel.buyflg1 != 4) {
        _circleView.strokeEnd = 1.0;
        self.label_qiangGuang.hidden = NO;
        self.label_centerNumber.hidden = YES;
        self.label_shengYu.hidden = YES;
        _imageV_new.hidden = YES;
    }
    
    self.imgV_kuaiZhuan.hidden = YES;
    self.label_liCaiQiXian_zi.hidden = NO;
    self.label_tian_zi.text = @"天";
    if (goodModel.gcId == 13) {
        self.label_centerNumber.hidden = YES;
        self.label_qiangGuang.hidden = YES;
        self.label_shengYu.hidden = YES;
        self.circleView.hidden = YES;
        self.imgV_kuaiZhuan.hidden = NO;
        
        self.label_liCaiQiXian_zi.hidden = YES;
        self.label_time.text = @"100";
        self.label_tian_zi.text = @"元起投";
        _imageV_new.hidden = YES;
    }
    
    self.label_timeCount.hidden = YES;
    self.label_timeCountTitle.hidden = YES;
    self.userInteractionEnabled = YES;
    if (goodModel.onLineTimeStamp > 0) {
        self.label_centerNumber.hidden = YES;
        self.label_qiangGuang.hidden = YES;
        self.label_shengYu.hidden = YES;
        self.circleView.hidden = YES;
        self.label_timeCount.hidden = NO;
        self.label_timeCountTitle.hidden = NO;
        self.userInteractionEnabled = NO;
        _imageV_new.hidden = YES;
    }
}

- (NSString *)stringWithTimeCount:(NSInteger)timeCount
{
    NSInteger second = timeCount % 60;
    NSInteger minute = timeCount / 60 % 60;
    NSInteger hour = timeCount / 3600;
    NSString *resStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hour, (long)minute, (long)second];
    self.label_timeCount.text = resStr;
    return resStr;
}

- (void)refreshTableView
{
    
}

@end
