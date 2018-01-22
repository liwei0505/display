//
//  FingerprintUnlock.m
//  Display
//
//  Created by lee on 2017/10/23.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "FingerprintUnlock.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface FingerprintUnlock()
@property (strong, nonatomic) LAContext *context;
@end

@implementation FingerprintUnlock

//+ (instancetype)instance {
//    static FingerprintUnlock *instance;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        instance = [[LAContext alloc] init];
//    });
//    return instance;
//}

- (instancetype)init {
    if (self = [super init]) {
        self.context = [LAContext new];
        self.context.localizedFallbackTitle = @"页面登录";
        if (@available(iOS 11.0, *)) {
            [self.context setLocalizedReason:@"指纹验证登录"];
        }
    }
    return self;
}

+ (void)unlock {
    FingerprintUnlock *fp = [[FingerprintUnlock alloc] init];
    [fp authentication];
}

- (void)authentication {
    NSError *error = nil;
    if ([self.context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"支持指纹识别");
        [self.context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功 刷新主界面");
            } else {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:{
                        NSLog(@"系统取消授权，如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:{
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:{
                        NSLog(@"授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:{
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:{
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:{
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                        break;
                    }
                    default:{
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    } else {
        NSLog(@"不支持指纹识别");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:{
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:{
                NSLog(@"A passcode has not been set");
                break;
            }
            default:{
                NSLog(@"TouchID not available");
                break;
            }
        }
        NSLog(@"%@",error.localizedDescription);
    }
}

@end
