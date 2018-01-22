//
//  ServiceManager.m
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ServiceManager.h"
#import "IServiceManager.h"
#import "UITestService.h"

@interface ServiceManager (){
    UITestService *_uiTestService;
    
//    HttpProxy *_httpProxy;
}

@end
@implementation ServiceManager

- (instancetype)initWithServiceFactory:(id<IServiceFactory>)serviceFactory {
    if (self = [super init]) {
        _uiTestService = [serviceFactory createUITestService];
    }
    return self;
}

- (void)testUIData {
    [_uiTestService testUIData];
}

@end
