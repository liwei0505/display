//
//  Layer.m
//  Display
//
//  Created by lee on 2017/5/27.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "Layer.h"

@implementation Layer

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)draw {
    
    //设置frame方式
    CAShapeLayer *layer = [CAShapeLayer layer];
    /*
     layer.frame = CGRectMake(110, 100, 150, 100);
     layer.backgroundColor = [UIColor redColor].CGColor;
     */
    /*
     通过UIBezierPath完成任意形状
     注意不能用backgroundColor,用fillColor和strokeColor：前者设置Layer填充色，后者设置边框色
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(110, 100, 150, 100)];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor redColor].CGColor;
    layer.strokeColor = [UIColor greenColor].CGColor;
    [self.layer addSublayer:layer];
    
}

@end
