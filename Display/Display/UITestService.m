//
//  UITestService.m
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "UITestService.h"

@interface UITestService(){
    id<IUITestProtocol> _protocol;
}
@end

@implementation UITestService

- (instancetype)initWithProtocol:(id<IUITestProtocol>)protocol {
    if (self = [super init]) {
        _protocol = protocol;
    }
    return self;
}

- (void)testUIData {
    [_protocol testUIData];
}
@end
