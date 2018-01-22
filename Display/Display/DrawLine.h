//
//  DrawLine.h
//  Display
//
//  Created by lee on 2017/5/26.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawLine : NSObject
+ (CALayer *)drawDotLineWidth:(CGFloat)lineWidth lineSpace:(CGFloat)lineSpace lineColor:(UIColor *)lineColor points:(NSArray<NSString *> *)points;
+ (CALayer *)drawSolidLineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor points:(NSArray<NSString *> *)points;
@end
