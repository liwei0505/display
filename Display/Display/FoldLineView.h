//
//  FoldLineView.h
//  Display
//
//  Created by lee on 2017/5/26.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoldLineView : UIView
- (void)updateMinValue:(CGFloat)min maxValue:(CGFloat)max lineCount:(NSInteger)lineCount brokenLineColor:(UIColor *)brokenLineColor marksX:(NSArray *)x marksY:(NSArray *)y mask:(BOOL)mask animation:(BOOL)animation;
@end
