//
//  TopHintView.m
//  Display
//
//  Created by lee on 17/4/20.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "TopHintView.h"
#import <SpriteKit/SpriteKit.h>

@implementation TopHintView
static bool isShow = NO;
+ (TopHintView *)sharedInstance {

    static dispatch_once_t onceToken;
    static TopHintView *instance;
    dispatch_once(&onceToken, ^{
        instance = [[TopHintView alloc] initWithFrame:CGRectMake(0, -40, [UIScreen mainScreen].bounds.size.width, 40)];
    });
    return instance;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        self.lbHint = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.lbHint.textColor = [UIColor whiteColor];
        self.lbHint.textAlignment = NSTextAlignmentCenter;
        self.lbHint.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.lbHint];
    }
    return self;
}

+ (void)show:(NSString *)message {

    if (isShow) {
        return;
    }
    
    isShow = YES;
    TopHintView *hintView = [TopHintView sharedInstance];
    hintView.lbHint.text = message;
    [UIView animateWithDuration:1.0 animations:^{
        hintView.transform = CGAffineTransformMakeTranslation(0, 40);
        [[UIApplication sharedApplication].keyWindow addSubview:hintView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:hintView];
    
    } completion:^(BOOL finished) {
       
        [UIView animateWithDuration:1.0 animations:^{
            hintView.transform = CGAffineTransformIdentity;
            isShow = NO;
        } completion:^(BOOL finished) {
            [hintView removeFromSuperview];
        }];
        
    }];
    
}

@end
