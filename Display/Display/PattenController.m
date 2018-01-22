//
//  PattenVC.m
//  Display
//
//  Created by lee on 17/2/15.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "PattenController.h"
#import "PatternButtonView.h"
#import "GestureView.h"
#import "ScrollLabelView.h"

@interface PattenController ()<PatternButtonView, GestureViewDelegate>

@property (strong, nonatomic) PatternButtonView *patternView;
@property (strong, nonatomic) GestureView *gestureView;

@end

@implementation PattenController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self scrollLabel];
    [self prepare];
}

- (void)scrollLabel {
    ScrollLabelView *view = [[ScrollLabelView alloc] initWithFrame:CGRectMake(32, 0, SCREENWIDTH-32*2, NAVIGATION_BAR_HEIGHT)];
    self.navigationItem.titleView = view;
    [view startWithText:@"民生金服民生金服民生金服民生金服民生金服民生金服民生金服"];
}

- (void)prepare {

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(10, 70, 130, 40);
    button1.layer.borderWidth = 2;
    button1.layer.borderColor = [UIColor redColor].CGColor;
    button1.layer.cornerRadius = 8;
    [button1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button1 setTitle:@"pattern(button)" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(patternLockButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(self.view.bounds.size.width-160, 70, 130, 40);
    button2.layer.borderColor = [UIColor blueColor].CGColor;
    button2.layer.borderWidth = 1;
    button2.layer.shadowColor = [UIColor purpleColor].CGColor;
    button2.layer.shadowOffset = CGSizeMake(100, 4);
    [button2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [button2 setTitle:@"pattern(view)" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(patternLockView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
}

- (void)patternLockButton {

    if (self.gestureView) {
        __weak typeof(self)weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            [weakSelf.gestureView removeFromSuperview];
            weakSelf.gestureView = nil;
        }];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomeButtomBG"]];
        self.patternView = [[PatternButtonView alloc] initWithFrame:CGRectMake(0, 100, 300, 300)];
        [self.view addSubview:self.patternView];
        self.patternView.center = self.view.center;
        self.patternView.delegate = self;
    }];
}

- (void)patternLockView {

    if (self.patternView) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.backgroundColor = [UIColor whiteColor];
            [self.patternView removeFromSuperview];
            self.patternView = nil;
        }];
    }
    
    self.gestureView = [[GestureView alloc] initWithFrame:CGRectMake(5, 100, 300, 300)];
    self.gestureView.delegate = self;
    [self.view addSubview:self.gestureView];
    
}

#pragma mark - delegate

- (BOOL)checkUnlockButton:(PatternButtonView *)unlockButtonView withPassword:(NSMutableString *)password{
    
    NSLog(@"%@",password);
    if ([password isEqualToString:@"012"]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)gestureView:(GestureView *)gestureView didSelectedPassword:(NSString *)password {
    NSLog(@"%@",password);
    if ([password isEqualToString:@"1245"]) {
        self.gestureView.gestureViewType = GestureView_normal;
    }else{
        self.gestureView.gestureViewType = GestureView_error;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.gestureView.gestureViewType = GestureView_normal;
        });
    }

}

@end
