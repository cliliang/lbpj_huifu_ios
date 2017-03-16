//
//  LBSignRecordView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/9/25.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBSignRecordView : UIView

@property (nonatomic, strong) NSDictionary *recordDict;

@property (nonatomic, strong) NSDate *nowDate;
@property (nonatomic, strong) NSDate *showingDate;

// 加载子视图
- (void)loadTheSubviews;


@end










