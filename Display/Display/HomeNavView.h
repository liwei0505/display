//
//  HomeNavView.h
//  Display
//
//  Created by lee on 2017/10/16.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeNavView : UIView
@property (assign, nonatomic) CGFloat backgroundAlpha;
@property (copy, nonatomic) void(^buttonBlock)(void);
@end
