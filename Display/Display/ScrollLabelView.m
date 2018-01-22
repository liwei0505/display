//
//  ScrollLabelView.m
//  Display
//
//  Created by lee on 2017/10/18.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ScrollLabelView.h"

@interface ScrollLabelView()
@property (strong, nonatomic) UILabel *label;
@end

@implementation ScrollLabelView

- (instancetype)init {
    if (self = [super init]) {
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        [self setup];
    }
    return self;
}

- (void)setup {
    self.label.textColor = [UIColor redColor];
    self.label.font = [UIFont systemFontOfSize:16];
    [self addSubview:self.label];
}

- (void)startWithText:(NSString *)text {
    
    self.label.text = text;
    
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]}];
//    Rect rect = text boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(nullable NSDictionary<NSAttributedStringKey,id> *)#> context:<#(nullable NSStringDrawingContext *)#>
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:15.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:999999];
    CGRect frame = self.label.frame;
    frame.origin.x = -size.width;
    self.label.frame = frame;
    [UIView commitAnimations];
    
}

@end
