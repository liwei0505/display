//
//  WaterRipple.h
//  Display
//
//  Created by lee on 17/4/14.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterRipple : UIView

@property (assign, nonatomic) CGFloat waterTime;
@property (assign, nonatomic) CGFloat waterSpeed;
@property (assign, nonatomic) CGFloat waterAngularVelocity;
@property (strong, nonatomic) UIColor *waterColor;

- (void)startAnimation;
- (void)stopAnimation;

@end
