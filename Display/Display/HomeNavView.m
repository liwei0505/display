//
//  HomeNavView.m
//  Display
//
//  Created by lee on 2017/10/16.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "HomeNavView.h"
#import "UIImage+color.h"

@interface HomeNavView()
@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UIButton *btnScan;
@end

@implementation HomeNavView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        NSArray *colorArray = @[[UIColor ms_colorWithHexString:@"FF6600"], [UIColor ms_colorWithHexString:@"FF2020"]];
        self.backImageView.image = [UIImage createImageFromColors:colorArray withSize:frame.size ByGradientType:upleftTolowRight];
        [self addSubview:self.backImageView];
        
        float size = 44;
        self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, STATUS_BAR_HEIGHT, size, size)];
        [self.backButton setImage:[UIImage imageNamed:@"account_nor"] forState:UIControlStateNormal];
        [self.backButton addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backImageView addSubview:self.backButton];
        
        self.btnScan = [[UIButton alloc] initWithFrame:CGRectMake(80, STATUS_BAR_HEIGHT, size, size)];
        [self.btnScan setImage:[UIImage imageNamed:@"account_nor"] forState:UIControlStateNormal];
        [self.btnScan addTarget:self action:@selector(backClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backImageView addSubview:self.btnScan];
    }
    return self;
}

- (void)setBackgroundAlpha:(CGFloat)backgroundAlpha {
    self.backImageView.alpha = backgroundAlpha;
}

- (void)backClick:(UIButton *)sender {
    NSLog(@"home nav view");
    if (self.buttonBlock) {
        self.buttonBlock();
    }
}

@end
