//
//  GestureView.m
//  Display
//
//  Created by lee on 17/4/18.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "GestureView.h"
#import "GestureItem.h"

@interface GestureView()
@property (strong, nonatomic) NSMutableArray *items;//密码
@property (assign, nonatomic) CGPoint currentPoint;
@end

@implementation GestureView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addItems];
    }
    return self;
}

- (void)addItems {

    for (int i=0; i<9; i++) {
        GestureItem *item = [[GestureItem alloc] init];
        item.userInteractionEnabled = NO;
        item.tag = i + 1;
        [self addSubview:item];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemMargin = 43;
    CGFloat itemW = (self.frame.size.width - itemMargin * 2) / 3.0;
    CGFloat itemH = itemW;
    
    for (int i=0; i<9; i++) {
        CGFloat itemX = (i % 3) * (itemW + itemMargin);
        CGFloat itemY = (i / 3) * (itemH + itemMargin);
        GestureItem *item = self.subviews[i];
        item.frame = CGRectMake(itemX, itemY, itemW, itemH);
        item.gestureItemType = GestureItem_normal;
    }
}

- (void)drawRect:(CGRect)rect {

    if (self.items.count == 0) {
        return;
    }
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (int i=0; i<self.items.count; i++) {
        GestureItem *item = self.items[i];
        if (i == 0) {
            CGContextMoveToPoint(ctx, item.center.x, item.center.y);
        } else {
            CGContextAddLineToPoint(ctx, item.center.x, item.center.y);
        }
    }
    
    if (self.items.count != 0) {
        CGContextAddLineToPoint(ctx, self.currentPoint.x, self.currentPoint.y);
    }
    
    UIColor *color;
    if (self.gestureViewType == GestureView_normal) {
        color = [UIColor colorWithRed:51/255.0 green:48/255.0 blue:146/255.0 alpha:1];
    } else {
        color = [UIColor colorWithRed:218/255.0 green:27/255.0 blue:39/255.0 alpha:1];
    }
    [color set];
    CGContextSetLineWidth(ctx, 4);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextStrokePath(ctx);
    
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    CGPoint point = [self getCurrentTouchPoint:touches];
    GestureItem *item = [self getCurrentItemWithPoint:point];
    if (item) {
        item.gestureItemType = GestureItem_success;
        [self.items addObject:item];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    CGPoint point = [self getCurrentTouchPoint:touches];
    GestureItem *item = [self getCurrentItemWithPoint:point];
    
    if (item && item.gestureItemType == GestureItem_normal) {
        item.gestureItemType = GestureItem_success;
        [self.items addObject:item];
    }
    
    self.currentPoint = point;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSMutableString *password = [NSMutableString string];
    for (GestureItem *item in self.items) {
        [password appendFormat:@"%d",(int)item.tag];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(gestureView:didSelectedPassword:)]) {
        [self.delegate gestureView:self didSelectedPassword:password];
    }
}

#pragma mark - private

- (void)setGestureViewType:(GestureViewType)gestureViewType {

    _gestureViewType = gestureViewType;
    if (gestureViewType == GestureView_normal) {
        self.userInteractionEnabled = YES;
        self.currentPoint = CGPointZero;
        [self.items enumerateObjectsUsingBlock:^(GestureItem *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.gestureItemType = GestureItem_normal;
        }];
        
        [self.items removeAllObjects];
    } else {
        self.userInteractionEnabled = NO;
        for (GestureItem *item in self.items) {
            item.gestureItemType = GestureItem_error;
        }
    }
    [self setNeedsDisplay];
}

- (GestureItem *)getCurrentItemWithPoint:(CGPoint)point {

    for (GestureItem *item in self.subviews) {
        if (CGRectContainsPoint(item.frame, point)) {
            return item;
        }
    }
    return nil;
}

- (CGPoint)getCurrentTouchPoint:(NSSet <UITouch *> *)touches {

    UITouch *touch = [touches anyObject];
    return [touch locationInView:touch.view];
}

- (NSMutableArray *)items {

    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
