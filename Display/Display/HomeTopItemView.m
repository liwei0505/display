//
//  HomeTopItemView.m
//  Display
//
//  Created by lee on 2017/10/9.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "HomeTopItemView.h"

@interface HomeTopItemView()

@property (strong, nonatomic) UIButton *btnScan;
@property (strong, nonatomic) UILabel *lbScan;

@end

@implementation HomeTopItemView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor ms_colorWithHexString:@"FF6600"];
    self.btnScan = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *img = [[UIImage imageNamed:@"add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.btnScan setImage:img forState:UIControlStateNormal];
    [self.btnScan addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btnScan];
    
    self.lbScan = [[UILabel alloc] init];
    self.lbScan.textColor = [UIColor whiteColor];
    self.lbScan.textAlignment = NSTextAlignmentCenter;
    self.lbScan.font = [UIFont systemFontOfSize:16];
    self.lbScan.text = @"扫一扫";
    [self addSubview:self.lbScan];
    
}

- (void)click:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(sender.tag);
    }
}

- (void)layoutSubviews {
    float height = self.bounds.size.height-16-20;
    self.btnScan.frame = CGRectMake(20, 8, height, height);
    self.lbScan.frame = CGRectMake(16, CGRectGetMaxY(self.btnScan.frame), height+8, 20);
}

- (void)setContentAlpha:(float)contentAlpha {
    self.alpha = contentAlpha;
    self.btnScan.alpha = contentAlpha;
}

@end
