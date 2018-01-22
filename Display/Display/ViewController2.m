//
//  ViewController2.m
//  Display
//
//  Created by lee on 17/2/27.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ViewController2.h"
#import "XWMainViewController.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
}

- (void)prepare {

    UIStoryboard *transBoard = [UIStoryboard storyboardWithName:@"tans" bundle:nil];
    XWMainViewController *trans = [transBoard instantiateInitialViewController];
    [self addChildViewController:trans];
    [self.view addSubview:trans.view];
    
}



@end
