//
//  NavigationView.h
//  Display
//
//  Created by lee on 2017/8/29.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationView : UIView
@property (copy, nonatomic) void(^backBlock)(void);
@property (assign, nonatomic) CGFloat backgroundAlpha;
@end
