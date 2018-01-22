//
//  FoldLineView.m
//  Display
//
//  Created by lee on 2017/5/26.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "FoldLineView.h"
#import "DrawLine.h"

#define LEFTMARGIN      65
#define RIGHTMARGIN     18
#define TOPMARGIN       10
#define BOTTOMMARGIN    TOPMARGIN
#define ROWSPACE      ((self.chartView.bounds.size.height - TOPMARGIN - BOTTOMMARGIN) / (self.lineCount - 1))

@interface FoldLineView()<CAAnimationDelegate>

@property (strong, nonatomic) UIView *chartView;
@property (strong, nonatomic) CAShapeLayer *lineLayer;
@property (strong, nonatomic) CAShapeLayer *maskLayer;
@property (strong, nonatomic) NSMutableArray *coordX;
@property (strong, nonatomic) NSMutableArray *coordY;
@property (strong, nonatomic) NSArray *marksX;
@property (strong, nonatomic) NSArray *marksY;
@property (strong, nonatomic) NSMutableArray *titleY;

@property (assign, nonatomic) NSInteger lineCount;
@property (assign, nonatomic) CGFloat minValue;
@property (assign, nonatomic) CGFloat maxValue;
@property (assign, nonatomic) CGPoint lastPoint;
@property (strong, nonatomic) UIColor *lineColor;

@end
@implementation FoldLineView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.lineCount = 5;
        self.backgroundColor = [UIColor whiteColor];
        self.lineColor = [UIColor greenColor];
        [self drawDefaultChartView];
    }
    return self;
}

- (void)drawDefaultChartView {
    [self updateMinValue:0 maxValue:0.05 lineCount:5 brokenLineColor:[UIColor grayColor] marksX:@[@"02-06", @"02-08"] marksY:@[@0,@0.025,@0.05,@0.025,@0,@0.025,@0.05] mask:NO animation:NO];
}

- (void)updateMinValue:(CGFloat)min maxValue:(CGFloat)max lineCount:(NSInteger)lineCount brokenLineColor:(UIColor *)brokenLineColor marksX:(NSArray *)x marksY:(NSArray *)y mask:(BOOL)mask animation:(BOOL)animation {

    if (min >= max) {
        NSLog(@"minTrend 和 maxTrend大小不对");
        return;
    }
    
    if (!x || x.count == 0) {
        NSLog(@"x轴没数据");
        return;
    }
    
    if (!y || y.count == 0) {
        NSLog(@"y没有数据");
        return;
    }
    
    self.minValue = min;
    self.maxValue = max;
    self.lineCount = lineCount;
    self.marksX = x;
    self.marksY = y;
    self.lineColor = brokenLineColor;
    
    [self clear];
    [self addChartView];

    [self drawWithMin:self.minValue max:self.maxValue points:y mask:mask animation:animation];
}

- (void)addChartView {

    CGFloat width = self.bounds.size.width;
    self.chartView = [[UIView alloc] initWithFrame:CGRectMake(0, TOPMARGIN, width, self.bounds.size.height-5)];
    [self addSubview:self.chartView];
    for (int i=0; i<self.lineCount; i++) {
        //横线两侧的坐标点
        NSArray *rowPoints = @[NSStringFromCGPoint(CGPointMake(LEFTMARGIN,ROWSPACE*i+TOPMARGIN)),
                               NSStringFromCGPoint(CGPointMake(width-RIGHTMARGIN, ROWSPACE*i+TOPMARGIN))];
        CALayer *layer = nil;
        if (i == self.lineCount-1) {
            layer = [DrawLine drawSolidLineWidth:0.5 lineColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1] points:rowPoints];
        } else {
            layer = [DrawLine drawDotLineWidth:4 lineSpace:4 lineColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1] points:rowPoints];
        }
        [self.chartView.layer addSublayer:layer];
        //Y轴title
        UILabel *lbTrend = [[UILabel alloc] initWithFrame:CGRectMake(0, (ROWSPACE * i + TOPMARGIN + 0.5/2.0 - 11/2.0), 50, 11)];
        lbTrend.font = [UIFont systemFontOfSize:11];
        lbTrend.textAlignment = NSTextAlignmentRight;
        lbTrend.textColor = [UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
        [self.chartView addSubview:lbTrend];
        [self.titleY addObject:lbTrend];
    }
    
    for (int i=0; i<self.marksX.count; i++) {
        //X轴title
    }
    
}

- (void)drawWithMin:(CGFloat)min max:(CGFloat)max points:(NSArray *)points mask:(BOOL)mask animation:(BOOL)animation {
    
    NSMutableArray *pointArray = [NSMutableArray array];
    
    CGFloat width = self.bounds.size.width;
    CGFloat spaceX = (width-LEFTMARGIN-RIGHTMARGIN-15) / (points.count-1);
    CGFloat spaceY = (max-min)/(self.lineCount-1);
    
    [points enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = idx*spaceX+LEFTMARGIN;
        CGFloat y = (max-obj.floatValue)/spaceY * ROWSPACE;
        CGPoint point = CGPointMake(x, y);
        [pointArray addObject:NSStringFromCGPoint(point)];
        if (idx == points.count-1) {
            self.lastPoint = point;
        }
    }];
    
    [self.titleY enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            obj.text = [NSString stringWithFormat:@"%.2f%%",max * 100];
        } else if (idx == self.titleY.count-1) {
            obj.text = [NSString stringWithFormat:@"%.2f%%",min * 100];
        } else {
            obj.text = [NSString stringWithFormat:@"%.2f%%",(max - idx*spaceY) * 100];
        }
    }];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [pointArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = CGPointFromString(obj);
        if (idx == 0) {
            [path moveToPoint:point];
        } else {
            [path addLineToPoint:point];
        }
    }];
    
    self.lineLayer.path = path.CGPath;
    self.lineLayer.strokeColor = self.lineColor.CGColor;
    [self.chartView.layer addSublayer:self.lineLayer];
    
    if (animation) {
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        ani.duration = 1.25;
        ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        ani.fromValue = [NSNumber numberWithFloat:0.0f];
        ani.toValue = [NSNumber numberWithFloat:1.0];
        ani.autoreverses = NO;
        ani.fillMode = kCAFillModeForwards;
        ani.delegate = self;
        [self.lineLayer addAnimation:ani forKey:nil];
    }
    
    if (!mask) {
        return;
    }
    
    [pointArray addObject:NSStringFromCGPoint(CGPointMake(LEFTMARGIN+(pointArray.count-1)*spaceX, self.chartView.bounds.size.height-BOTTOMMARGIN))];
    [pointArray addObject:NSStringFromCGPoint(CGPointMake(LEFTMARGIN, (self.chartView.bounds.size.height-BOTTOMMARGIN)))];
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    [pointArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint point = CGPointFromString(obj);
        if (idx == 0) {
            [maskPath moveToPoint:point];
        } else {
            [maskPath addLineToPoint:point];
        }
    }];
    [maskPath closePath];
    self.maskLayer.path = maskPath.CGPath;
    self.maskLayer.fillColor = self.lineColor.CGColor;
    [self.chartView.layer addSublayer:self.maskLayer];
    
    if (animation) {
        CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
        ani.duration = 1.25;
        ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        ani.fromValue = @0;
        ani.toValue = @0.05;
        ani.autoreverses = NO;
        ani.fillMode = kCAFillModeForwards;
        [self.maskLayer addAnimation:ani forKey:nil];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    circle.center = self.lastPoint;
    circle.backgroundColor = [UIColor whiteColor];
    circle.layer.cornerRadius = 5;
    circle.layer.borderColor = self.lineColor.CGColor;
    circle.layer.borderWidth = 2;
    circle.layer.masksToBounds = YES;
    circle.alpha = 0;
    [self.chartView addSubview:circle];
    
    [UIView animateWithDuration:0.25 animations:^{
        circle.alpha = 1;
    }];
}

- (void)clear {
    [self.chartView removeFromSuperview];
    [self.titleY removeAllObjects];
    [self.lineLayer removeFromSuperlayer];
    [self.lineLayer removeAllAnimations];
    self.lineLayer = nil;
    [self.maskLayer removeFromSuperlayer];
    [self.maskLayer removeAllAnimations];
    self.maskLayer = nil;
}

- (CAShapeLayer *)lineLayer {
    if (!_lineLayer) {
        _lineLayer = [CAShapeLayer layer];
        _lineLayer.lineWidth = 1;
        _lineLayer.lineJoin = kCALineJoinRound;
        _lineLayer.lineCap = kCALineCapRound;
        _lineLayer.fillColor = [UIColor clearColor].CGColor;
    }
    return _lineLayer;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.strokeColor = [UIColor clearColor].CGColor;
        _maskLayer.opacity = 0.05;
    }
    return _maskLayer;
}

- (NSMutableArray *)titleY {

    if (!_titleY) {
        _titleY = [NSMutableArray array];
    }
    return _titleY;
}


@end
