//
//  Config.h
//  Display
//
//  Created by lee on 17/4/17.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <Foundation/Foundation.h>

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define NAVIGATION_BAR_HEIGHT 44
//#define NAVIGATION_BAR_HEIGHT [UIApplication sharedApplication].keyWindow.rootViewController.navigationController.navigationBar.frame.size.height
#define TAB_BAR_HEIGHT 49
#define IPHONEX_BOTTOM 34
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

#define DEVICE_iPhoneX  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//currentMode 根据启动图大小变化

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGB(r,g,b)  [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1];
#define CG_RGB(r,g,b)  [[UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1] CGColor];
