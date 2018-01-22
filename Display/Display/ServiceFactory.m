//
//  ServiceFactory.m
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ServiceFactory.h"
#import "UITestProtocolStub.h"
#import "UITestProtocolStub.h"
#import "UITestService.h"

@interface ServiceFactory() {
    SessionManager *_sessionManager;
    id<IUITestProtocol> _protocol;
}
@end

@implementation ServiceFactory

- (instancetype)initWithSessionManager:(SessionManager *)sessionManager {
    if (self = [super init]) {
        _sessionManager = sessionManager;
        _protocol = [[UITestProtocolStub alloc] initWithSessionManager:sessionManager];
    }
    return self;
}

- (id<IUITestService>)createUITestService {
    return [[UITestService alloc] initWithProtocol:_protocol];
}
@end
