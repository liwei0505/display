//
//  UITestProtocolStub.m
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "UITestProtocolStub.h"

@interface UITestProtocolStub(){
    SessionManager *_sessionManager;//用于httpProxy请求
}
@end

@implementation UITestProtocolStub
- (instancetype)initWithSessionManager:(SessionManager *)sessionManager {
    if (self = [super init]) {
        _sessionManager = sessionManager;
    }
    return self;
}

- (void)testUIData {
    NSLog(@"%s",__func__);
}

@end
