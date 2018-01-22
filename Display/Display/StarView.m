//
//  ProgressView3.m
//  Display
//
//  Created by lee on 2017/5/3.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "StarView.h"

@interface StarView()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end
@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.frame = (CGRect){CGPointMake(0, 0), CGSizeMake(200, 200)};
        _shapeLayer.position = self.center;
        _shapeLayer.path = [self getStar1BezierPath].CGPath;
        _shapeLayer.strokeColor = [UIColor greenColor].CGColor;
        _shapeLayer.lineWidth = 2.f;
        [self.layer addSublayer:_shapeLayer];
//        _timer = 
        
    }
    return self;
}

- (void)animation {

    [UIView animateWithDuration:2 animations:^{
        
    }];
    
}

#pragma mark - 贝塞尔曲线1
- (UIBezierPath *)getStar1BezierPath {

    UIBezierPath *starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint:CGPointMake(10, self.frame.size.height*0.5)];
    [starPath addLineToPoint:CGPointMake(self.frame.size.width-10, self.frame.size.height*0.5)];
    [starPath closePath];
    return starPath;
    
}


#pragma mark - 贝塞尔曲线2

@end
