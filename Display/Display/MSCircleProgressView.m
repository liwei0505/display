//
//  MSCircleProgressView.m
//  circle
//
//  Created by msj on 2017/6/6.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSCircleProgressView.h"

@interface MSCircleProgressView ()
@property(nonatomic,strong)CAShapeLayer * circleLayer;
@property(nonatomic,strong)UILabel * lbProgress;
@end

@implementation MSCircleProgressView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configCircle];
        [self configLabel];
    }
    return self;
}

#pragma mark - Private
- (void)configLabel {
    self.lbProgress = [[UILabel alloc] init];
    self.lbProgress.text = @"0.0%";
    self.lbProgress.frame = self.bounds;
    self.lbProgress.textColor = [UIColor blackColor];
    self.lbProgress.center = self.center;
    self.lbProgress.font = [UIFont systemFontOfSize:10];
    self.lbProgress.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.lbProgress];
}

- (void)configCircle {
    
    CGFloat lineWidth = 2.5;
    CGFloat radius = self.bounds.size.width / 2.0 - lineWidth;
    CGRect rect = CGRectMake(lineWidth/2, lineWidth/2, radius*2, radius*2);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];

    CAShapeLayer * bgCircleLayer = [CAShapeLayer layer];
    bgCircleLayer.lineWidth = lineWidth;
    bgCircleLayer.strokeStart = 0.0f;
    bgCircleLayer.strokeEnd = 1.0f;
    bgCircleLayer.opacity = 0.25;
    bgCircleLayer.strokeColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    bgCircleLayer.path = path.CGPath;
    bgCircleLayer.fillColor = [UIColor clearColor].CGColor;
    bgCircleLayer.lineDashPattern = @[@6, @1];
    [self.layer addSublayer:bgCircleLayer];
    
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.circleLayer.path = path.CGPath;
    self.circleLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleLayer.lineWidth = lineWidth;
    self.circleLayer.lineDashPattern = @[@6, @1];
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    UIColor *color1 = [UIColor colorWithRed:245/255.0 green:74/255.0 blue:129/255.0 alpha:1];
    UIColor *color2 = [UIColor colorWithRed:105/255.0 green:152/255.0 blue:241/255.0 alpha:1];
    gradientLayer.colors = @[(id)color1.CGColor, (id)color2.CGColor];
    gradientLayer.locations = @[@0.25,@0.75];
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.mask = self.circleLayer;
    
    [self.layer addSublayer:gradientLayer];
    
}

- (void)updateCircleStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated{
    if (animated) {
        [self animationWithStrokeEnd:strokeEnd];
    } else {
        self.circleLayer.strokeEnd = floor(strokeEnd*10)/1000;
        if (strokeEnd == 100) {
            self.lbProgress.text = @"100%";
        } else {
            self.lbProgress.text = [NSString stringWithFormat:@"%.1f%%",floor(strokeEnd*10)/10];
        }
    }
}

- (void)animationWithStrokeEnd:(CGFloat)strokeEnd{
//
//    POPBasicAnimation * bAni = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
//    bAni.fromValue = @0;
//    bAni.toValue = @(floor(strokeEnd*10)/1000);
//    bAni.duration = 1;
//    bAni.removedOnCompletion = NO;
//    [self.circleLayer pop_addAnimation:bAni forKey:@"circle"];
//    
//    
//    POPBasicAnimation *labelBani = [POPBasicAnimation animation];
//    labelBani.duration = 1;
//    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count" initializer:^(POPMutableAnimatableProperty *prop) {
//        [prop setReadBlock:^(id obj, CGFloat values[]) {
//            values[0] = [[obj description] floatValue];
//        }];
//        [prop setWriteBlock:^(id obj, const CGFloat values[]) {
//            NSString * str;
//            if (strokeEnd == 100) {
//                str = [NSString stringWithFormat:@"%.0f",values[0]];
//            } else {
//                str = [NSString stringWithFormat:@"%.1f",values[0]];
//            }
//            [obj setText:[NSString stringWithFormat:@"%@%%",str]];
//        }];
//        prop.threshold = 0.01;
//    }];
//    
//    labelBani.property = prop;
//    labelBani.fromValue = @(0.0);
//    labelBani.toValue = @(floor(strokeEnd*10)/10);
//    [self.lbProgress pop_addAnimation:labelBani forKey:@"circle"];
//    
}
@end
