//
//  SkinViewController.m
//  Display
//
//  Created by lee on 17/2/16.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "SkinViewController.h"
#import "SkinUtils.h"

@interface SkinViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *top;
@property (weak, nonatomic) IBOutlet UIImageView *bottom;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SkinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)blue:(id)sender {
    [SkinUtils setSkinColor:@"blue"];
    [self change];
}
- (IBAction)red:(id)sender {
    [SkinUtils setSkinColor:@"red"];
    [self change];
}

- (void)change {

    self.top.image = [SkinUtils skinWithImageName:@"account"];
    self.bottom.image = [SkinUtils skinWithImageName:@"home"];
    self.label.backgroundColor = [SkinUtils skinLabelBackgroundColor];
}

@end
