//
//  NewFeatureView.m
//  Display
//
//  Created by lw on 2017/5/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "NewFeatureView.h"
#import "NewFeatureController.h"

@interface NewFeatureView()
@property (nonatomic, strong) NewFeatureController *collectionView;
@end

@implementation NewFeatureView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self == [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {

    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTintColor:[UIColor greenColor]];
    [btn setTitle:@"abcde" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    self.collectionView = [[NewFeatureController alloc] init];
    [self addSubview:self.collectionView.view];
    
    [self.collectionView.view insertSubview:btn atIndex:999];
    
}

- (void)show {

    self.rootViewController = self.collectionView;
    self.windowLevel = UIWindowLevelAlert + 1;
    self.hidden = NO;
    
}


- (void)dismiss {

    self.rootViewController = nil;
    self.hidden = YES;
    
    /*切换控制器
     [[NSUserDefaults standardUserDefaults] setObject:@"mjs" forKey:[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
     MSTabBarController *tabVC = [[MSTabBarController alloc] init];
     [UIApplication sharedApplication].keyWindow.rootViewController = tabVC;
     */
}

@end
