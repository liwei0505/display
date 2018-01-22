//
//  SkinUtils.h
//  Display
//
//  Created by lee on 17/2/16.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkinUtils : NSObject

+ (void)setSkinColor:(NSString *)color;
+ (UIImage *)skinWithImageName:(NSString *)name;
+ (UIColor *)skinLabelBackgroundColor;

@end
