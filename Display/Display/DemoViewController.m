//
//  DemoViewController.m
//  Display
//
//  Created by lee on 2017/5/10.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "DemoViewController.h"
#import "RotateView.h"
#import "MSPhotoSelector.h"
#import "MSSliderView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "UILabel+Gradient.h"

@interface DemoViewController ()
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) MSSliderView *sliderView;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self testSlider];
    
    UILabel* testLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 400, 50)];
    testLabel.text = @"文字渐变Demo";
    testLabel.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:testLabel];
    [testLabel gradientColors:@[(id)[UIColor redColor].CGColor, (id)[UIColor greenColor].CGColor] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[AppDelegate serviceManager] testUIData];
}

- (void)testSlider {
    self.sliderView = [[MSSliderView alloc] initWithFrame:CGRectMake(10, 200, self.view.bounds.size.width - 60, 50)];
    self.sliderView.block = ^(NSInteger currentIndex) {
        NSLog(@"currentIndex=============%ld",currentIndex);
    };
    self.sliderView.termCategories = @[@1, @3, @5, @7, @9, @11, @13, @15];
    [self.view addSubview:self.sliderView];
    
}



@end
