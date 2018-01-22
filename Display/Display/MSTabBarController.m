//
//  TabBarController.m
//  Display
//
//  Created by lee on 17/2/27.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "MSTabBarController.h"
#import "MSNavigationController.h"
#import "ViewController.h"
#import "ViewController2.h"

@interface MSTabBarController ()<UITabBarControllerDelegate>
@property (assign, nonatomic) NSInteger index;
@end

@implementation MSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareTabbar];
    [self prepare];
}

- (void)prepare {

    self.view.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    [self addChildVC];
}

- (void)prepareTabbar {

    self.tabBar.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.tabBar.bounds];
    self.tabBar.layer.shadowPath = path.CGPath;
    self.tabBar.layer.shadowColor = [UIColor grayColor].CGColor;
    self.tabBar.layer.shadowOffset = CGSizeMake(1, -1);
    self.tabBar.layer.shadowRadius = 5;
    self.tabBar.layer.shadowOpacity = 0.4;
    self.tabBar.clipsToBounds = NO;
    
    UITabBarItem *item = [UITabBarItem appearance];
    NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor colorWithRed:216/255.0 green:58/255.0 blue:48/255.0 alpha:1.0],NSFontAttributeName:[UIFont systemFontOfSize:12]};
    [item setTitleTextAttributes:attribute forState:UIControlStateSelected];
    
}

#pragma mark - tabbar



#pragma mark - add children controller

- (void)addChildVC {
    
    NSArray *children = @[@"DemoViewController",@"HomeViewController",@"ViewController",@"ViewController2"];
    NSArray *image = @[@"home_sel",@"home_nor",@"home_nor",@"account_nor"];
    NSArray *selectedImage = @[@"home_nor",@"home_sel",@"home_sel",@"account_sel"];
    NSArray *title = @[@"DEMO",@"首页",@"理财",@"我的"];
    for (int i=0; i<children.count; i++) {
        [self addChildController:children[i] image:image[i] selectedImage:selectedImage[i] title:title[i]];
    }
}

- (void)addChildController:(NSString *)viewController image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {

    Class child = NSClassFromString(viewController);
    if (child) {
        UIViewController *vc = [[child alloc] init];
        vc.title = title;
        vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        MSNavigationController *nav = [[MSNavigationController alloc] initWithRootViewController:vc];
        [self addChildViewController:nav];
    }
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.index != index) {
        [self animationWithIndex:index];
    }
}

- (void)animationWithIndex:(NSInteger) index {
    
    NSMutableArray *tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
    
    self.index = index;
    
}

@end
