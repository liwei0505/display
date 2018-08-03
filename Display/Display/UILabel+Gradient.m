//
//  UILabel+Gradient.m
//  test
//
//  Created by lee on 2018/8/3.
//  Copyright © 2018年 mjsfax. All rights reserved.
//

#import "UILabel+Gradient.h"

@implementation UILabel (Gradient)
- (void)gradientColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.frame;
    gradientLayer.colors = colors;
    gradientLayer.startPoint =startPoint;
    gradientLayer.endPoint = endPoint;
    [self.superview.layer addSublayer:gradientLayer];
    gradientLayer.mask = self.layer;
    self.frame = gradientLayer.bounds;
}
@end
