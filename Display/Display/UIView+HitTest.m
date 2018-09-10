//
//  UIView+HitTest.m
//  Display
//
//  Created by lee on 2018/9/10.
//  Copyright © 2018年 mjsfax. All rights reserved.
//

#import "UIView+HitTest.h"
#import <objc/runtime.h>

@implementation UIView (HitTest)


const static NSString *HitTestViewBlockKey = @"HitTestViewBlockKey";
const static NSString *PointInsideBlockKey = @"PointInsideBlockKey";

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(hitTest:withEvent:)),
                                   class_getInstanceMethod(self, @selector(st_hitTest:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pointInside:withEvent:)),
                                   class_getInstanceMethod(self, @selector(st_pointInside:withEvent:)));
}

- (UIView *)st_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSMutableString *spaces = [NSMutableString stringWithCapacity:20];
    UIView *superView = self.superview;
    while (superView) {
        [spaces appendString:@"----"];
        superView = superView.superview;
    }
    NSLog(@"%@%@:[hitTest:withEvent:]", spaces, NSStringFromClass(self.class));
    UIView *deliveredView = nil;
    // 如果有hitTestBlock的实现，则调用block
    if (self.hitTestBlock) {
        BOOL returnSuper = NO;
        deliveredView = self.hitTestBlock(point, event, &returnSuper);
        if (returnSuper) {
            deliveredView = [self st_hitTest:point withEvent:event];
        }
    } else {
        deliveredView = [self st_hitTest:point withEvent:event];
    }
    //    NSLog(@"%@%@:[hitTest:withEvent:] Result:%@", spaces, NSStringFromClass(self.class), NSStringFromClass(deliveredView.class));
    return deliveredView;
}

- (BOOL)st_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSMutableString *spaces = [NSMutableString stringWithCapacity:20];
    UIView *superView = self.superview;
    while (superView) {
        [spaces appendString:@"----"];
        superView = superView.superview;
    }
    NSLog(@"%@%@:[pointInside:withEvent:]", spaces, NSStringFromClass(self.class));
    BOOL pointInside = NO;
    if (self.pointInsideBlock) {
        BOOL returnSuper = NO;
        pointInside =  self.pointInsideBlock(point, event, &returnSuper);
        if (returnSuper) {
            pointInside = [self st_pointInside:point withEvent:event];
        }
    } else {
        pointInside = [self st_pointInside:point withEvent:event];
    }
    return pointInside;
}

- (void)setHitTestBlock:(HitTestViewBlock)hitTestBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(HitTestViewBlockKey), hitTestBlock, OBJC_ASSOCIATION_COPY);
}

- (HitTestViewBlock)hitTestBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(HitTestViewBlockKey));
}

- (void)setPointInsideBlock:(PointInsideBlock)pointInsideBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(PointInsideBlockKey), pointInsideBlock, OBJC_ASSOCIATION_COPY);
}

- (PointInsideBlock)pointInsideBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(PointInsideBlockKey));
}


@end
