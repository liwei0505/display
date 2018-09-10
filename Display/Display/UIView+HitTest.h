//
//  UIView+HitTest.h
//  Display
//
//  Created by lee on 2018/9/10.
//  Copyright © 2018年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView * (^HitTestViewBlock)(CGPoint point, UIEvent *event, BOOL *returnSuper);
typedef BOOL (^PointInsideBlock)(CGPoint point, UIEvent *event, BOOL *returnSuper);

@interface UIView (HitTest)
@property(nonatomic, strong) HitTestViewBlock hitTestBlock;
@property(nonatomic, strong) PointInsideBlock pointInsideBlock;
@end
