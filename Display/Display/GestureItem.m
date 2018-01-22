//
//  GestureItem.m
//  Display
//
//  Created by lee on 17/4/18.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "GestureItem.h"

@implementation GestureItem

- (instancetype)init {

    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setGestureItemType:(GestureItemType)gestureItemType {

    _gestureItemType = gestureItemType;
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect {
    
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    self.layer.masksToBounds = YES;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat x = rect.size.width * 0.5;
    CGFloat y = rect.size.height * 0.5;
    CGFloat outerRadius = rect.size.width * 0.5 - 1;
    CGFloat innerRadius = self.frame.size.width / 5.0;
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = M_PI * 3 / 2;
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineWidth(context, 1);
    [[self outerCircleColor] set];
    CGContextAddArc(context, x, y, outerRadius, startAngle, endAngle, 0);
    CGContextStrokePath(context);
    
    [[self innerCircleColor] set];
    CGContextAddArc(context, x, y, innerRadius, startAngle, endAngle, 0);
    CGContextFillPath(context);
    
}

#pragma mark - private

- (UIColor *)outerCircleColor {
    
    switch (self.gestureItemType) {
        case GestureItem_success:
            return [UIColor colorWithRed:51/255.0 green:48/255.0 blue:146/255.0 alpha:1];
        case GestureItem_error:
            return [UIColor colorWithRed:218/255.0 green:27/255.0 blue:39/255.0 alpha:1];
        case GestureItem_normal:
        default:
            return [UIColor colorWithRed:175/255.0 green:176/255.0 blue:168/255.0 alpha:1];
    }
    
}

- (UIColor *)innerCircleColor {

    switch (self.gestureItemType) {
        case GestureItem_success:
            return [UIColor colorWithRed:51/255.0 green:48/255.0 blue:146/255.0 alpha:1];
        case GestureItem_error:
            return [UIColor colorWithRed:218/255.0 green:27/255.0 blue:39/255.0 alpha:1];
        case GestureItem_normal:
        default:
            return [UIColor clearColor];
    }
}

@end









