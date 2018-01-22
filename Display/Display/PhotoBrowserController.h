//
//  PhotoBrowserController.h
//  Display
//
//  Created by lee on 17/4/19.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PhotoBrowserType) {
    PhotoBrowser_push,
    PhotoBrowser_present
};

@interface PhotoBrowserController : UIViewController

@property (strong, nonatomic) NSArray *photoItems;
@property (assign, nonatomic) int currentIndex;
@property (assign, nonatomic) PhotoBrowserType type;
 
@end
