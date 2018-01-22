//
//  ScanCodeView.m
//  Display
//
//  Created by lee on 17/4/17.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ScanCodeView.h"
#import "ScanSurfaceView.h"

@interface ScanCodeView()

@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;
@property (strong, nonatomic) ScanSurfaceView *surfaceView;

@end

@implementation ScanCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupScanner];
        [self addSurfaceView];
    }
    return self;
}

- (void)setupScanner {

    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    // 条码类型
    self.output.metadataObjectTypes = @[AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeQRCode];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = self.bounds;
    [self.layer insertSublayer:self.preview atIndex:0];
    
}

- (void)addSurfaceView {

    self.surfaceView = [[ScanSurfaceView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self setScanRect:self.surfaceView.scanRect];
    [self addSubview:self.surfaceView];
    
}

- (void)setScanRect:(CGRect)rect {
    
    self.output.rectOfInterest = CGRectMake(rect.origin.y/self.frame.size.height, rect.origin.x/self.frame.size.width, rect.size.height/self.frame.size.height, rect.size.width/self.frame.size.width);
}

- (void)startScan {
    [self.session startRunning];
    [self.surfaceView startBaseLineAnimation];
}

- (void)stopScan {
    [self.session stopRunning];
    [self.surfaceView stopBaseLineAnimation];
}

#pragma mark - delegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    NSString *string = nil;
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        string = metadataObject.stringValue;
    }
    [self stopScan];
    
    if ([self.delegate respondsToSelector:@selector(scanCodeViewCompleteCallBack:)]) {
        [self.delegate scanCodeViewCompleteCallBack:string];
    }
}

@end
