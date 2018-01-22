//
//  NextViewController.m
//  Display
//
//  Created by lee on 17/2/16.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "NextViewController.h"
#import "SkinUtils.h"
#import "MSTextView.h"

typedef NS_ENUM(NSUInteger, myState) {
    STATE_ONE   = 1 << 0,
    STATE_TWO   = 1 << 1,
    STATE_THREE = 1 << 2,
};

@interface NextViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet MSTextView *textView;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.placeHolder = @"textView测试";
    
    myState a=STATE_ONE;
    switch (a) {
        case STATE_ONE: {
            NSLog(@"one");
            break;
        }
        case STATE_TWO: {
            NSLog(@"two");
            break;
        }
        case STATE_THREE: {
            NSLog(@"three");
            break;
        }
//        default:      //不加default如果state不全则会报警告，状态未全部处理
//            break;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.image.image = [SkinUtils skinWithImageName:@"home"];
}



@end
