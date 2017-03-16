//
//  PSSLockView.m
//  PSSGestureLock
//
//  Created by 庞仕山 on 16/7/4.
//  Copyright © 2016年 庞仕山. All rights reserved.
//

#import "PSSLockView.h"
#import "PSSLockItemBtn.h"
#import "CoreLockConst.h"
#import "CoreArchive.h"

@interface PSSLockView ()

@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, assign) CGPoint curPoint;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIColor *lineColor;

@end

@implementation PSSLockView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [self addGestureRecognizer:panGes];
        _lineColor = kNavBarColor;
        [self addLockItems];
    }
    return self;
}
- (void)addLockItems
{
    for (int i = 0; i < 9; i++) {
        PSSLockItemBtn *button = [PSSLockItemBtn buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        [self addSubview:button];
        button.tag = i + 1;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    int cols = 3; // 3行3列
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 50;
    CGFloat h = 50;
    CGFloat margin = 42;
    CGFloat leftAndRight = (kScreenWidth - (3 * w + 2 * margin)) / 2;
    
    CGFloat col = 0;
    CGFloat row = 0;
    for (NSInteger i = 0; i < count; i++) {
        PSSLockItemBtn *btn = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = leftAndRight + col * (margin + w);
        y = row * (margin + w);
        btn.frame = CGRectMake(x, y, w, h);
        btn.userInteractionEnabled = NO;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint locPoint = [touch locationInView:self];
    _lineColor = kNavBarColor;
    if (self.selectedArray.count) {
        [self.timer invalidate];
        [self makeOriginalStatus];
        self.curPoint = locPoint;
        [self setNeedsDisplay];
    }
    
    for (PSSLockItemBtn *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, locPoint)) {
            if (btn.selected == NO) {
                [self.selectedArray addObject:btn];
                btn.selected = YES;
            }
        }
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.selectedArray.count == 1) {
        [self makeOriginalStatus];
        [self setNeedsDisplay];
    }
}

- (void)panGestureAction:(UIPanGestureRecognizer *)panGes
{
    CGPoint curPoint = [panGes locationInView:self];
    self.curPoint = curPoint;
    for (PSSLockItemBtn *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, curPoint)) {
            if (btn.selected == NO) {
                [self.selectedArray addObject:btn];
                btn.selected = YES;
            }
        }
    }
    if (panGes.state == UIGestureRecognizerStateEnded) { // 松手
        
        if (self.selectedArray.count < CoreLockLeastItem) {
            [self makeOriginalStatus];
            if (self.lessThanFourBlock) self.lessThanFourBlock();
        } else {
            switch (self.lockStyle) {
                case PSSLockStyleSet: { // 设置密码
                    if (!_firstPassword) {
                        _firstPassword = [self getGesturePassword];
                        [self makeOriginalStatus];
                        if (self.firstSettingBlock) self.firstSettingBlock(_firstPassword);
                    } else {
                        NSString *secondPW = [self getGesturePassword];
                        if ([secondPW isEqualToString:_firstPassword]) {
                            if (self.successSetBlock) self.successSetBlock(secondPW);
                            self.curPoint = ((PSSLockItemBtn *)self.selectedArray[self.selectedArray.count - 1]).center;
                        } else {
                            if (self.failureSetBlock) self.failureSetBlock();
                            [self verifyWithSuccess:NO];
                        }
                    }
                    break;
                }
                case PSSLockStyleVerify: { // 使用密码
                    if ([[self getGesturePassword] isEqualToString:[CoreArchive strForKey:kGesturePasswordKey]]) {
                        if (self.successVerifyBlock) self.successVerifyBlock();
                    } else {
                        if (self.failureVerifyBlock) self.failureVerifyBlock();
                        [self verifyWithSuccess:NO];
                    }
                    break;
                }
                case PSSLockStyleReset: { // 重置密码
                    if ([[self getGesturePassword] isEqualToString:[CoreArchive strForKey:kGesturePasswordKey]]) {
                        if (self.successAllowBlock) self.successAllowBlock();
                        [self makeOriginalStatus];
                        self.lockStyle = PSSLockStyleSet;
                    } else {
                        if (self.failureAllowBlock) self.failureAllowBlock();
                        [self verifyWithSuccess:NO];
                    }
                    break;
                }
                case PSSLockStyleRemove: { // 关闭密码
                    if ([[self getGesturePassword] isEqualToString:[CoreArchive strForKey:kGesturePasswordKey]]) {
                        if (self.successRemoveBlock) self.successRemoveBlock();
                    } else {
                        if (self.failureVerifyBlock) self.failureVerifyBlock();
                        [self verifyWithSuccess:NO];
                    }
                    break;
                }
                    
                default:
                    break;
            }
        }
        
    }
    [self setNeedsDisplay];
}
- (void)makeOriginalStatus
{
    for (PSSLockItemBtn *btn in self.subviews) {
        btn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
    }
    [self.selectedArray removeAllObjects];
}
- (NSString *)getGesturePassword
{
    NSString *password = @"";
    for (PSSLockItemBtn *btn in self.selectedArray) {
        password = [NSString stringWithFormat:@"%@%ld", password, (long)btn.tag];
    }
    return password;
}

//  验证是否成功
- (void)verifyWithSuccess:(BOOL)success
{
    if (!success) {
        [self setBtnSelectedWithImage:[UIImage imageNamed:@"gesture_node_error"]];
        _lineColor = [UIColor colorWithRGBString:@"c4c4c4"];
    }
    self.curPoint = ((PSSLockItemBtn *)self.selectedArray[self.selectedArray.count - 1]).center;
    [self setNeedsDisplay];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
- (void)timerAction:(NSTimer *)timer
{
    for (PSSLockItemBtn *btn in self.selectedArray) {
        btn.selected = NO;
    }
    [self.selectedArray removeAllObjects];
    [self setNeedsDisplay];
    [self setBtnSelectedWithImage:[UIImage imageNamed:@"gesture_node_highlighted"]];
    [timer invalidate];
}

- (void)setBtnSelectedWithImage:(UIImage *)image
{
    for (PSSLockItemBtn *btn in self.subviews) {
        [btn setImage:image forState:UIControlStateSelected];
    }
}


- (void)drawRect:(CGRect)rect
{
    if (!self.selectedArray.count) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSInteger count = self.selectedArray.count;
    for (int i = 0; i < count; i++) {
        PSSLockItemBtn *btn = self.selectedArray[i];
        if (i == 0) {
            [path moveToPoint:btn.center];
        } else {
            [path addLineToPoint:btn.center];
        }
    }
    [path addLineToPoint:self.curPoint];
    // 所有选中按钮之间都连线
    [_lineColor set];
    path.lineWidth = CoreLockLineWidth;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
}

- (NSMutableArray *)selectedArray
{
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

@end




