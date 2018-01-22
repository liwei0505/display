//
//  UITestProtocolStub.h
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUITestProtocol.h"

@class SessionManager;

@interface UITestProtocolStub : NSObject<IUITestProtocol>
- (instancetype)initWithSessionManager:(SessionManager *)sessionManager;
@end
