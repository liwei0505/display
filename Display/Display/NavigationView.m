//
//  NavigationView.m
//  Display
//
//  Created by lee on 2017/8/29.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "NavigationView.h"
#import "UIImage+color.h"

@interface NavigationView()

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIButton *backButton;

@end

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        self.backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        NSArray *colorArray = @[[UIColor ms_colorWithHexString:@"FF6600"], [UIColor ms_colorWithHexString:@"FF2020"]];
        self.backImageView.image = [UIImage createImageFromColors:colorArray withSize:frame.size ByGradientType:upleftTolowRight];
        [self addSubview:self.backImageView];
        
        self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, STATUS_BAR_HEIGHT, 40, 40)];
        [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [self.backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backImageView addSubview:self.backButton];
    }
    return self;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
//    self.backgroundColor = [UIColor colorWithWhite:1 alpha:backgroundAlpha];
    self.backImageView.alpha = backgroundAlpha;
}

- (void)backClick:(UIButton *)sender {
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
