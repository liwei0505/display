//
//  BaseViewController.m
//  Display
//
//  Created by lee on 17/2/28.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "BaseViewController.h"
#import "Guidance.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    //设置内部引导
    GuidanceView *view = [[GuidanceView alloc] init];
    [view showWithClassName:NSStringFromClass([self class])];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
