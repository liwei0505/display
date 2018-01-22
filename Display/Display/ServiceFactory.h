//
//  ServiceFactory.h
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IServiceFactory.h"

@class SessionManager;
@interface ServiceFactory : NSObject <IServiceFactory>
- (instancetype)initWithSessionManager:(SessionManager *)sessionManager;
@end
