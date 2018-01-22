//
//  RotateImageView.m
//  Display
//
//  Created by lw on 2017/5/20.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "RotateImageView.h"

@implementation RotateImageView

- (RotateImageView *)initWithImage:(UIImage *)image text:(NSString *)text {

    if (self == [super init]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, 120, 120);
        [self addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 120, 120, 120)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:20];
        label.text = text;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        
    }
    return self;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.block) {
        self.block(self.tag);
    }
}

@end
