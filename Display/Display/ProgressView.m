//
//  ProgressView.m
//  Display
//
//  Created by lee on 17/2/21.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()
{
    UIView *_progressView;
}

@end

@implementation ProgressView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {

    [super awakeFromNib];
    [self setup];
}

- (void)setup {//1

    self.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 3.f;
    _progressView = [[UIView alloc] init];
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = 3.f;
    _progressView.backgroundColor = [UIColor colorWithRed:167/255.0 green:222/255.0 blue:124/255.0 alpha:1.0];
    [self addSubview:_progressView];
    
}

- (void)drawRect:(CGRect)rect {//3
    CGFloat progress = self.progress / 100.f;//除以的区间为传入的progress范围
    [UIView animateWithDuration:0.5 animations:^{
        _progressView.frame = CGRectMake(0, 0, self.frame.size.width * progress, self.frame.size.height);
    }];
}

- (void)setProgress:(double)progress {//2
    _progress = progress;
    _progressView.frame = CGRectMake(0, 0, 0, self.frame.size.height);
    [self setNeedsDisplay];//调用drawRect
}

@end
