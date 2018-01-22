//
//  AppDelegate.h
//  Display
//
//  Created by lee on 17/2/15.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)instance;
+ (ServiceManager *)serviceManager;

@end

