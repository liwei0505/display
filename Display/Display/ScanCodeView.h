//
//  ScanCodeView.h
//  Display
//
//  Created by lee on 17/4/17.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol ScanCodeViewDelegate <NSObject>
- (void)scanCodeViewCompleteCallBack:(NSString *)stringValue;
@end

@interface ScanCodeView : UIView<AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) id<ScanCodeViewDelegate> delegate;
- (void)startScan;
- (void)stopScan;
@end
