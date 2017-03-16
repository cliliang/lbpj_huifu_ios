//
//  HYScratchCardView.m
//  Test
//
//  Created by Shadow on 14-5-23.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "HYScratchCardView.h"

@interface HYScratchCardView ()

@property (nonatomic, strong) UIImageView *surfaceImageView;

@property (nonatomic, strong) CALayer *imageLayer;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, assign) CGMutablePathRef path;

@property (nonatomic, assign, getter = isOpen) BOOL open;

@property (nonatomic, assign) BOOL completeBool; // 保证 返回的block 之调用一次


@end

@implementation HYScratchCardView

- (void)dealloc
{
    if (self.path) {
        CGPathRelease(self.path);
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.surfaceImageView = [[UIImageView alloc] initWithFrame:self.bounds];
//        self.surfaceImageView.image = [self imageByColor:[UIColor darkGrayColor]];
        
        [self addSubview:self.surfaceImageView];
        
        self.theImageV = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.theImageV];
        self.imageLayer = self.theImageV.layer;
        self.imageLayer.frame = self.bounds;
        [self.layer addSublayer:self.imageLayer];
        
        // 10元 -- 本金红包
        CGFloat x1 = 0;
        CGFloat y1 = KAutoWDiv2(74);
        CGFloat w1 = self.bounds.size.width;
        CGFloat h1 = KAutoWDiv2(50);
        UILabel *label_money = [[UILabel alloc] initWithFrame:CGRectMake(x1, y1, w1, h1)];
        label_money.textAlignment = NSTextAlignmentCenter;
        [label_money setText:@"10元" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:KAutoWDiv2(50)]];
        [label_money pingFangFont:KAutoWDiv2(50)];
        [self.theImageV addSubview:label_money];


        CGFloat x2 = 0;
        CGFloat y2 = KAutoWDiv2(74 + 50 + 28);
        CGFloat w2 = self.bounds.size.width;
        CGFloat h2 = KAutoWDiv2(30);
        UILabel *label_hongbao = [[UILabel alloc] initWithFrame:CGRectMake(x2, y2, w2, h2)];
        label_hongbao.textAlignment = NSTextAlignmentCenter;
        [label_hongbao setText:@"本金红包" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:KAutoWDiv2(30)]];
        [label_hongbao pingFangFont:KAutoWDiv2(30)];
        [self.theImageV addSubview:label_hongbao];
        
        _label_title = label_hongbao;
        _label_content = label_money;
        
        self.shapeLayer = [CAShapeLayer layer];
        self.shapeLayer.frame = self.bounds;
        self.shapeLayer.lineCap = kCALineCapRound;
        self.shapeLayer.lineJoin = kCALineJoinRound;
        self.shapeLayer.lineWidth = 30.f;
        self.shapeLayer.strokeColor = [UIColor blueColor].CGColor;
        self.shapeLayer.fillColor = nil;
        
        [self.layer addSublayer:self.shapeLayer];
        self.imageLayer.mask = self.shapeLayer;
        
        self.path = CGPathCreateMutable();
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.completion) {
        if (self.completeBool == NO) {
            self.completion(self.userInfo);
        }
    }
    
    if (!self.isOpen) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGPathMoveToPoint(self.path, NULL, point.x, point.y);
        CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
        self.shapeLayer.path = path;
        CGPathRelease(path);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (!self.isOpen) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        CGPathAddLineToPoint(self.path, NULL, point.x, point.y);
        CGMutablePathRef path = CGPathCreateMutableCopy(self.path);
        self.shapeLayer.path = path;
        CGPathRelease(path);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    if (!self.isOpen) {
        [self checkForOpen];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    if (!self.isOpen) {
        [self checkForOpen];
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageLayer.contents = (id)image.CGImage;
}

- (void)setSurfaceImage:(UIImage *)surfaceImage
{
    _surfaceImage = surfaceImage;
    self.surfaceImageView.image = surfaceImage;
}

- (void)reset
{
    if (self.path) {
        CGPathRelease(self.path);
    }
    self.open = NO;
    self.path = CGPathCreateMutable();
    self.shapeLayer.path = NULL;
    self.imageLayer.mask = self.shapeLayer;
}

- (void)checkForOpen
{
    CGRect rect = CGPathGetPathBoundingBox(self.path);
    
    NSArray *pointsArray = [self getPointsArray];
    for (NSValue *value in pointsArray) {
        CGPoint point = [value CGPointValue];
        if (!CGRectContainsPoint(rect, point)) {
            return;
        }
    }
    
    self.open = YES;
    self.imageLayer.mask = NULL;
    
//    if (self.completion) {
//        self.completion(self.userInfo);
//    }
}

- (NSArray *)getPointsArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    CGFloat insetH = height  * 2 / 5;
    CGFloat insetW = width  * 2 / 5;
    
    CGPoint topPoint = CGPointMake(width/2, insetH);
    CGPoint leftPoint = CGPointMake(insetW, height/2);
    CGPoint bottomPoint = CGPointMake(width/2, height-insetH);
    CGPoint rightPoint = CGPointMake(width-insetW, height/2);
//    CGPoint topPoint = CGPointMake(width/2, 0);
//    CGPoint leftPoint = CGPointMake(0, height/2);
//    CGPoint bottomPoint = CGPointMake(width/2, height);
//    CGPoint rightPoint = CGPointMake(width, height/2);
    
    [array addObject:[NSValue valueWithCGPoint:topPoint]];
    [array addObject:[NSValue valueWithCGPoint:leftPoint]];
    [array addObject:[NSValue valueWithCGPoint:bottomPoint]];
    [array addObject:[NSValue valueWithCGPoint:rightPoint]];
    
    return array;
}

- (UIImage *)imageByColor:(UIColor *)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
