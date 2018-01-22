//
//  AppDelegate.m
//  Display
//
//  Created by lee on 17/2/15.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "AppDelegate.h"
#import "MSTabBarController.h"
#import "Guidance.h"
#import "SessionManager.h"
#import "NewFeatureView.h"
#import "ServiceFactory.h"
#import "FingerprintUnlock.h"

@interface AppDelegate ()
@property (nonatomic, strong) NewFeatureView *guide;
@property (strong, nonatomic) ServiceManager *serviceManager;
@end

@implementation AppDelegate

+ (AppDelegate *)instance {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (ServiceManager *)serviceManager {
    return [AppDelegate instance].serviceManager;
}

//动画启动页
- (void)launchStartPage {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchView = vc.view;
    launchView.frame = self.window.frame;
    [self.window.rootViewController.view addSubview:launchView];
    
    [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
        [FingerprintUnlock unlock];
    }];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
//  显示欢迎页
//    if (![[NSUserDefaults standardUserDefaults] objectForKey:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]) {
//        self.guide = [[NewFeatureView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        [self.guide show];
//    }
    [self initialize];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   
    int flag = 0;
    if (flag) {
        //加载内部指引资源
        [Guidance initGuidanceData];
    } else {
        MSTabBarController *tab = [[MSTabBarController alloc] init];
        self.window.rootViewController = tab;
    }

    [self launchStartPage];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initialize {
    SessionManager *sessionManager = [[SessionManager alloc] init];
    ServiceFactory *serviceFactory = [[ServiceFactory alloc] initWithSessionManager:sessionManager];
    _serviceManager = [[ServiceManager alloc] initWithServiceFactory:serviceFactory];
}

@end
