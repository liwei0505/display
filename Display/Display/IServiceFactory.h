//
//  IServiceFactory.h
//  Display
//
//  Created by lee on 2017/10/11.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUITestService.h"

@protocol IServiceFactory <NSObject>
- (id<IUITestService>)createUITestService;
@end
