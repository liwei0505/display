//
//  LayoutViewController.m
//  demo
//
//  Created by lw on 17/3/30.
//  Copyright © 2017年 lw. All rights reserved.
//

#import "LayoutViewController.h"
#import "LayoutView.h"

@interface LayoutViewController ()

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
}

- (void)test1 {

    LayoutView *view = [LayoutView new];
    view.frame = self.view.bounds;
    [self.view addSubview:view];
    
}

@end
