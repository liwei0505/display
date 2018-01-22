//
//  ScanSurfaceView.h
//  Display
//
//  Created by lee on 17/4/18.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanSurfaceView : UIView {

    CALayer *baselineLayer;
    BOOL isAnimation;
}

@property (assign, nonatomic) CGRect scanRect;

- (void)startBaseLineAnimation;
- (void)stopBaseLineAnimation;

@end
