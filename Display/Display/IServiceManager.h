//
//  IServiceManager.h
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IServiceFactory.h"

@protocol IServiceManager <NSObject>
- (instancetype)initWithServiceFactory:(id<IServiceFactory>)serviceFactory;
- (void)testUIData;
@end
