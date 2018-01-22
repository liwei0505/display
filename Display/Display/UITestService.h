//
//  UITestService.h
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUITestService.h"
#import "IUITestProtocol.h"

@interface UITestService : NSObject <IUITestService>
- (instancetype)initWithProtocol:(id<IUITestProtocol>)protocol;
@end
