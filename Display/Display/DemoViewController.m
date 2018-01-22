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

@interface DemoViewController ()
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) MSSliderView *sliderView;
@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testSlider];

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
