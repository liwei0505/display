//
//  LoadingView.m
//  Display
//
//  Created by lee on 17/4/19.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView()
@property (strong, nonatomic) UILabel *lbTitle;
@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, (frame.size.height - 10)*0.5, frame.size.width, 10)];
        self.lbTitle.font = [UIFont systemFontOfSize:10];
        self.lbTitle.backgroundColor = [UIColor clearColor];
        self.lbTitle.textAlignment = NSTextAlignmentCenter;
        self.lbTitle.textColor = [UIColor whiteColor];
        self.lbTitle.text = @"0.0%";
        [self addSubview:self.lbTitle];
        self.lbTitle.hidden = YES;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = frame.size.width * 0.5;
        self.loadingViewType = LoadingViewType_line;
        
        self.progress = 0.01;
    }
    return self;
}

- (void)setProgress:(CGFloat)progress {

    _progress = progress;
    
    if (self.loadingViewType == LoadingViewType_text) {
        self.lbTitle.hidden = NO;
        if (progress == 1) {
            self.lbTitle.text = @"100%";
        } else {
            self.lbTitle.text = [NSString stringWithFormat:@"%.1f%%",progress*100];
        }
    } else {
        self.lbTitle.hidden = YES;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor whiteColor] set];
    CGFloat x = rect.size.width * 0.5;
    CGFloat y = rect.size.height * 0.5;
    CGFloat radius = rect.size.width * 0.5 - 4;
    CGFloat startAngle = - M_PI_2;
    CGFloat endAngle = - M_PI_2 + self.progress * M_PI * 2;
    
    if (self.loadingViewType == LoadingViewType_line || self.loadingViewType == LoadingViewType_text) {
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineJoin(context, kCGLineJoinRound);
        CGContextSetLineWidth(context, 2);
        CGContextAddArc(context, x, y, radius, startAngle, endAngle, 0);
        CGContextStrokePath(context);
    } else {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        CGContextMoveToPoint(context, x, y);
        CGContextAddLineToPoint(context, x, y-radius);
        CGContextAddArc(context, x, y, radius, startAngle, endAngle, 0);
        CGContextClosePath(context);
        CGContextFillPath(context);
    }
}

@end

