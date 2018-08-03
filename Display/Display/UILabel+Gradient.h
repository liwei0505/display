//
//  UILabel+Gradient.h
//  test
//
//  Created by lee on 2018/8/3.
//  Copyright © 2018年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Gradient)
- (void)gradientColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;
@end
