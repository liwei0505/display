//
//  ScanSurfaceView.m
//  Display
//
//  Created by lee on 17/4/18.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ScanSurfaceView.h"
#import <AVFoundation/AVFoundation.h>

#define left_width (self.frame.size.width*3.0/16.0)
#define scanRect_width (self.frame.size.width*10.0/16.0)
#define scanRect_height (self.frame.size.width*10.0/16.0)
#define top_height ((self.frame.size.height-scanRect_height)/2-60)
#define bottom_height (self.frame.size.height - top_height - scanRect_height)
#define back_color [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define yellow_line_length 18
#define yellow_line_stroke 3

@interface ScanSurfaceView()<CAAnimationDelegate>
@property (strong, nonatomic) UIButton *btnFlashlight;
@end

@implementation ScanSurfaceView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.scanRect = CGRectMake(left_width, top_height, scanRect_width, scanRect_height);
        isAnimation = YES;
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, top_height)];
        topView.backgroundColor = back_color;
        [self addSubview:topView];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getY:topView], left_width, scanRect_height)];
        leftView.backgroundColor = back_color;
        [self addSubview:leftView];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-left_width, [self getY:topView], left_width, scanRect_height)];
        rightView.backgroundColor = back_color;
        [self addSubview:rightView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, [self getY:leftView], self.frame.size.width, bottom_height)];
        bottomView.backgroundColor = back_color;
        [self addSubview:bottomView];
        
        UIView *boardView = [[UIView alloc] initWithFrame:self.scanRect];
        boardView.backgroundColor = [UIColor clearColor];
        boardView.layer.borderColor = [[UIColor whiteColor] CGColor];
        boardView.layer.borderWidth = 1.0;
        [self addSubview:boardView];
        
        //二维码边框：左上
        [self createYellowHLineWithX:left_width withY:top_height];
        [self createYellowVLineWithX:left_width withY:top_height];
        //右上
        [self createYellowHLineWithX:self.frame.size.width-left_width-yellow_line_length withY:top_height];
        [self createYellowVLineWithX:self.frame.size.width-left_width-yellow_line_stroke withY:top_height];
        //左下
        [self createYellowHLineWithX:left_width withY:top_height+scanRect_height-yellow_line_stroke];
        [self createYellowVLineWithX:left_width withY:top_height+scanRect_height-yellow_line_length];
        //右下
        [self createYellowHLineWithX:self.frame.size.width-left_width-yellow_line_length withY:top_height+scanRect_height-yellow_line_stroke];
        [self createYellowVLineWithX:self.frame.size.width-left_width-yellow_line_stroke withY:top_height+scanRect_height-yellow_line_length];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, self.frame.size.width-20, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Heiti SC" size:12];
        label.textColor = [UIColor whiteColor];
        label.text = @"将二维码/条码放入框内，即可自动扫描";
        [bottomView addSubview:label];
        
        self.btnFlashlight = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+10, self.frame.size.width, 20)];
        [self.btnFlashlight setTitle:@"手电筒" forState:UIControlStateNormal];
        [self.btnFlashlight addTarget:self action:@selector(flashlight) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:self.btnFlashlight];
        
        baselineLayer = [[CALayer alloc] init];
        [baselineLayer setBounds:CGRectMake(left_width, top_height, scanRect_width, 2)];
        [baselineLayer setBackgroundColor:[[UIColor redColor] CGColor]];
        
    }
    return self;
}

- (void)flashlight {//手电筒
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    if (device.torchMode == AVCaptureTorchModeOff) {
        [device setTorchMode:AVCaptureTorchModeOn];
    } else if (device.torchMode == AVCaptureTorchModeOn) {
        [device setTorchMode:AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];
}

#pragma mark - animate

- (void)startBaseLineAnimation {

    if (!baselineLayer.superlayer) {
        [self.layer addSublayer:baselineLayer];
    }
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(left_width+scanRect_width/2, top_height)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(left_width+scanRect_width/2, top_height+scanRect_height)]];
    [animation setDuration:2];
    [baselineLayer addAnimation:animation forKey:nil];
    
}

- (void)stopBaseLineAnimation {
    isAnimation = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (isAnimation) {
        [self startBaseLineAnimation];
    } else {
        [baselineLayer removeFromSuperlayer];
        isAnimation = YES;
    }
}

- (void)animationDidStart:(CAAnimation *)anim {

}

#pragma mark - draw line

- (void)createYellowHLineWithX:(float)x withY:(float)y {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, yellow_line_length, yellow_line_stroke)];
    line.backgroundColor = [UIColor yellowColor];
    [self addSubview:line];
}

- (void)createYellowVLineWithX:(float)x withY:(float)y {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, y, yellow_line_stroke, yellow_line_length)];
    line.backgroundColor = [UIColor yellowColor];
    [self addSubview:line];
}

#pragma mark - private

- (float)getY:(UIView *)view {
    return view.frame.origin.y + view.frame.size.height;
}

@end
