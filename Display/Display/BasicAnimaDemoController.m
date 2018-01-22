//
//  BasicAnimaDemoController.m
//  Display
//
//  Created by lw on 2017/8/4.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "BasicAnimaDemoController.h"

@interface BasicAnimaDemoController ()
@property (strong, nonatomic) UIView *shakeView;
@end

@implementation BasicAnimaDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)shakeViewDemo {
    
    UIView *demoView = [[UIView alloc]init];
    demoView.bounds = CGRectMake(0, 0, 50, 100);
    demoView.backgroundColor = [UIColor redColor];
    demoView.center = CGPointMake(200, 200);
    self.shakeView = demoView;
    [self.view addSubview:self.shakeView];
    [self.shakeView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(shake)]];
    
}

- (void)shake {

    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = @[@(-M_PI_4),@(M_PI_4),@(-M_PI_4)];
    anim.duration = 3;
    anim.repeatCount = MAX_CANON;
    [self.shakeView.layer addAnimation:anim forKey:@"anim"];
}

@end
