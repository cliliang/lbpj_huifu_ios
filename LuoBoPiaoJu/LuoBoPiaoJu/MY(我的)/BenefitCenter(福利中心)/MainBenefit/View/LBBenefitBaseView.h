//
//  LBBenefitBaseView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBBenefitBaseView : UIView

- (instancetype)initWithTitleArray:(NSArray *)titleArray;

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSArray *typeArray;
- (void)setDatas;

- (void)refreshThisView;

@end
