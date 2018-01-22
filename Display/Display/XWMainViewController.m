//
//  XWMainViewController.m
//  新闻
//
//  Created by lw on 15/9/16.
//  Copyright © 2015年 lw. All rights reserved.
//

#import "XWMainViewController.h"
#import "XWToplineViewController.h"
#import "XWCurrentViewController.h"
#import "XWPeopleViewController.h"
#import "XWLifeViewController.h"

@interface XWMainViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property(nonatomic,weak)UIViewController *currentVc;
@end

@implementation XWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//添加子控制器
    [self addChildViewController:[[XWToplineViewController alloc]init]];
    [self addChildViewController:[[XWPeopleViewController alloc]init]];
    [self addChildViewController:[[XWCurrentViewController alloc]init]];
    [self addChildViewController:[[XWLifeViewController alloc]init]];
    
}

//单击切换控制器
- (IBAction)topLine:(id)sender {
    [self switchVC:0];
    NSLog(@"0");
}

- (IBAction)current:(id)sender {
    [self switchVC:1];
        NSLog(@"1");
}
- (IBAction)people:(id)sender {
    [self switchVC:2];
        NSLog(@"2");
}
- (IBAction)life:(id)sender {
    [self switchVC:3];
    NSLog(@"3");
}

//切换控制器的实现
-(void)switchVC:(int)index{

    UIViewController *newVC = self.childViewControllers[index];
    if (newVC == self.currentVc) {
        return;
    }

    CGRect newFrame = self.contentView.bounds;
    newFrame.origin.x = self.contentView.frame.size.width;
    newVC.view.frame = newFrame;
    [self.contentView addSubview:newVC.view];
    
    [UIView animateWithDuration:1.0 animations:^{
        
        CGRect oldFrame = self.contentView.bounds;
        oldFrame.origin.x = -self.contentView.bounds.size.width;
        self.currentVc.view.frame = oldFrame;
        
        newVC.view.frame = self.contentView.bounds;
        
    } completion:^(BOOL finished) {
        [self.currentVc.view removeFromSuperview];
        self.currentVc = newVC;
    }];
        
}


@end
