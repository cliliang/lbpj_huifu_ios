//
//  LBBenefitItemView.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/8/11.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBBenefitItemView : UIView

@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) NSInteger type;
- (void)reloadDate;

- (void)startHeaderRefresh;

@end
