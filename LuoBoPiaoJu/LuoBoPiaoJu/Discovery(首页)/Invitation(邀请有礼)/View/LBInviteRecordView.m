//
//  LBInviteRecordView.m
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/10.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "LBInviteRecordView.h"
#import "LBInviteRecordTVCell.h"
#import "LBInvitedRecordModel.h"

@interface LBInviteRecordView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LBInviteRecordView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        _tableView = tableView;
        [tableView becomeCircleWithR:4];
        tableView.backgroundColor = [UIColor whiteColor];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
            make.width.mas_equalTo(KAutoWDiv2(570));
            make.height.mas_equalTo(KAutoHDiv2(633));
        }];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, KAutoHDiv2(74))];
        [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LBInviteRecordTVCell class]) bundle:nil] forCellReuseIdentifier:kCellID];
        
        UILabel *label = [UILabel new];
        [label setText:@"邀请记录" textColor:kDeepColor font:[UIFont systemFontOfSize:15]];
        [label pingFangFont:15];
        [tableView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(KAutoHDiv2(22));
            make.centerX.mas_equalTo(tableView);
        }];
        
        UIImageView *imageV = [[UIImageView alloc] init];
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(tableView.mas_bottom).offset(KAutoHDiv2(30));
            make.width.height.mas_equalTo(KAutoWDiv2(70));
            make.centerX.mas_equalTo(self);
        }];
//        imageV.backgroundColor = kNavBarColor;
        imageV.image = [UIImage imageNamed:@"icon_yaoqingyouli_quxiao"];
        imageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancel)];
        [imageV addGestureRecognizer:tapges];
    }
    return self;
}
- (void)clickCancel
{
    [self removeFromSuperview];
}

#pragma mark - tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBInviteRecordTVCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray) {
        LBInvitedRecordModel *model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KAutoHDiv2(111.5);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end







