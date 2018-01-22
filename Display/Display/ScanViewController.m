//
//  ScanViewController.m
//  Display
//
//  Created by lee on 17/4/17.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ScanViewController.h"
#import "ScanCodeView.h"

@interface ScanViewController ()<ScanCodeViewDelegate>
@property (strong, nonatomic) ScanCodeView *scanCodeView;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanCodeView = [[ScanCodeView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scanCodeView];
    self.scanCodeView.delegate = self;
    [self.scanCodeView startScan];
    
}

- (void)scanCodeViewCompleteCallBack:(NSString *)stringValue {

    NSLog(@"%@",stringValue);
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
