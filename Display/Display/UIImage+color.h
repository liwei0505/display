//
//  UIImage+color.h
//  showTime
//
//  Created by msj on 16/8/24.
//  Copyright © 2016年 msj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    topToBottom = 0,//从上到下
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
} GradientType;

@interface UIImage (color)
+ (UIImage *)ms_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;
+ (UIImage *)ms_scaleToSize:(UIImage *)img ratio:(float)ratio;
+ (UIImage *)createImageFromColors:(NSArray*)colors withSize:(CGSize)imageSize ByGradientType:(GradientType)gradientType;
@end
