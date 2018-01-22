//
//  UIImage+color.m
//  showTime
//
//  Created by msj on 16/8/24.
//  Copyright © 2016年 msj. All rights reserved.
//

#import "UIImage+color.h"

@implementation UIImage (color)
+ (UIImage *)ms_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize {
    
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

+ (UIImage *)ms_scaleToSize:(UIImage *)img ratio:(float)ratio {
    
    UIGraphicsBeginImageContext(CGSizeMake(img.size.width*ratio, img.size.height*ratio));
    [img drawInRect:CGRectMake(0, 0, img.size.width*ratio, img.size.height*ratio)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}

+ (UIImage *)createImageFromColors:(NSArray*)colors withSize:(CGSize)imageSize ByGradientType:(GradientType)gradientType {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imageSize.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imageSize.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imageSize.width, imageSize.height);
            break;
        case 3:
            start = CGPointMake(imageSize.width, 0.0);
            end = CGPointMake(0.0, imageSize.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
