//
//  LBChanPinDetail.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  产品详情

#import "LBChanPinDetail.h"
#import <MJPhotoBrowser.h>

#define kCell @"LBChanPinDetailCell"

@interface LBChanPinDetail () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, assign) NSInteger gcId;

@end

@implementation LBChanPinDetail

- (instancetype)initWithGCID:(NSInteger)gcId
{
    self = [super init];
    if (self) {
        _gcId = gcId;
        [self addTableViewInThisView];
    }
    return self;
}

- (void)refreshThisView
{
    if (_gcId == 10) {
        _titleArray = @[@"承兑银行", @"回款方式", @"停售日期", @"结息日期"];
        [self.tableView reloadData];
    } else {
        
    }
}

// 添加tableView
- (void)addTableViewInThisView
{
    if (_gcId == 10) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        tableView.bounces = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(self);
        }];
        self.tableView = tableView;
    } else {
        self.backgroundColor = [UIColor whiteColor];
        double edge = KAutoHDiv2(36);
        // 1.回款方式
        UILabel *label_1 = [UILabel new];
        [label_1 setText:@"回款方式" textColor:UIColorFromHexString(@"404040", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightRegular]];
        [self addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(KAutoHDiv2(26));
            make.top.mas_equalTo(self).offset(KAutoHDiv2(38));
            make.left.mas_equalTo(self).offset(edge);
        }];
        
        // 2.项目审核
        UILabel *label_2 = [UILabel new];
        [label_2 setText:@"项目审核" textColor:UIColorFromHexString(@"404040", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightRegular]];
        [self addSubview:label_2];
        [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(KAutoHDiv2(26));
            make.top.mas_equalTo(label_1.mas_bottom).offset(KAutoHDiv2(32));
            make.left.mas_equalTo(label_1);
        }];
        
        // 3. 到期本息自动返还至账户
        UILabel *label_3 = [UILabel new];
        [label_3 setText:@"到期本息自动返还至账户" textColor:UIColorFromHexString(@"666666", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightLight]];
        [self addSubview:label_3];
        [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(KAutoHDiv2(26));
            make.centerY.mas_equalTo(label_1);
            make.right.mas_equalTo(self).offset(KAutoHDiv2(-edge - KAutoHDiv2(10)));
        }];
        
        // 4. 票据展示 >
        UIButton *button_4 = [UIButton buttonWithNormalColor:kNavBarColor highColor:kNavBarColor backgroundColor:[UIColor clearColor] fontSize:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightLight] title:@"票据展示 >"];
        [self addSubview:button_4];
        [button_4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(label_3);
            make.centerY.mas_equalTo(label_2);
        }];
        [[button_4 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            // -点击button
            if (_imgUrl) {
                MJPhotoBrowser *photoBrowser = [[MJPhotoBrowser alloc] init];
                MJPhoto *photo = [[MJPhoto alloc] init];
                photo.url = _imgUrl;
                [photo setValue:[UIImage imageNamed:@"image_placeHolder"] forKey:@"placeholder"];
                NSArray *photoArray = @[photo];
                photoBrowser.photos = photoArray;
                [photoBrowser show];
            }
        }];
        
        // 5. 巴拉巴拉巴拉....
        UILabel *label_5 = [UILabel new];
        [label_5 setText:@"平台所有票据均由浙商银行检验真伪，并委托保管至到期托收，彻底杜绝一票两融，确保投资者本息安全。" textColor:UIColorFromHexString(@"666666", 1) font:[UIFont pingfangWithFloat:KAutoHDiv2(26) weight:UIFontWeightLight]];
        [self addSubview:label_5];
        label_5.numberOfLines = 0;
        [label_5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(label_2.mas_bottom).offset(KAutoHDiv2(25));
            make.centerX.mas_equalTo(self);
            make.width.mas_equalTo(kScreenWidth - 2 * edge);
        }];
        [label_5 changeLineDistance:KAutoHDiv2(15)];
    }
}
#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCell];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont pingfangWithFloat:KAutoHDiv2(30) weight:UIFontWeightLight];
    [cell.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KAutoHDiv2(40));
        make.centerY.mas_equalTo(cell.contentView);
    }];
    if (!self.dataArray) {
        cell.detailTextLabel.text = @"--";
    } else {
        cell.detailTextLabel.text = self.dataArray[indexPath.row];
    }
    cell.textLabel.textColor = kColor_707070;
    cell.detailTextLabel.textColor = kColor_707070;
    
    cell.detailTextLabel.font = [UIFont pingfangWithFloat:KAutoHDiv2(30) weight:UIFontWeightLight];
    [cell.detailTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-KAutoHDiv2(40));
        make.centerY.mas_equalTo(cell.contentView);
        make.width.mas_equalTo(170);
    }];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    
    NSString *theString = _dataArray[indexPath.row];
    cell.detailTextLabel.text = theString;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end











