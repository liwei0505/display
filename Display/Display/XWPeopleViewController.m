//
//  XWPeopleViewController.m
//  新闻
//
//  Created by lw on 15/9/16.
//  Copyright © 2015年 lw. All rights reserved.
//

#import "XWPeopleViewController.h"
#import "FoldLineView.h"
#import "NSDate+Add.h"

@interface XWPeopleViewController ()
@property (strong, nonatomic) FoldLineView *foldview;
@end

@implementation XWPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
}

- (void)prepare {
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.foldview = [[FoldLineView alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, 250)];
    [self.view addSubview:self.foldview];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    NSMutableArray *x = [[NSMutableArray alloc] initWithCapacity:7];
    NSMutableArray *y = [[NSMutableArray alloc] initWithCapacity:7];
    for (int i = 0; i < 7; ++i) {
        
        long time = (long)([[NSDate date] timeIntervalSince1970]) - 86400 * (7 - i);
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
        [x addObject:[NSString stringWithFormat:@"%02ld-%02ld",(long)date.month,(long)date.day]];
        double point = ((arc4random() % 10000)*1.0/5001 + 1) / 100;
        [y addObject:@(point)];
    }
    //@[@"02-06", @"02-07",@"02-08",@"02-09",@"02-10"]
    //@[@0.015,@0.025,@0.031,@0.025,@0,@0.025,@0.0271]
    [self.foldview updateMinValue:0 maxValue:0.05 lineCount:5 brokenLineColor:[UIColor ms_colorWithHexString:@"#333092"] marksX:x marksY:y mask:YES animation:YES];
    
}

@end
