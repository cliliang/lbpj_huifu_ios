//
//  LBXiangMuShenHe.h
//  LuoBoPiaoJu
//
//  Created by 庞仕山 on 16/5/24.
//  Copyright © 2016年 庞仕山. All rights reserved.
//  项目审核

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LBXiangMuShenHe_Luobokuaizhuan,
    LBXiangMuShenHe_XinShou,
    LBXiangMuShenHe_LuoBoDingtou,
    LBXiangMuShenHe_YinPiaoMiao,
} LBXiangMuShenHeStyle;

@interface LBXiangMuShenHe : UIView

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) NSString *imageUrl;

- (instancetype)initWithStyle:(LBXiangMuShenHeStyle)style;

- (void)refreshWithStyle:(LBXiangMuShenHeStyle)style;

@end
