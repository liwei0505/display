//
//  Guidance.h
//  Display
//
//  Created by lee on 17/2/28.
//  Copyright © 2017年 mjsfax. All rights reserved.
/*
    功能：进入页面弹出功能指引
         文件配置不同的页面通过不同的图片切换显示指引图片
    GuidanceView:点击替换图片功能，无法切换
*/

#import <UIKit/UIKit.h>

@interface Guidance : NSObject

+ (void)initGuidanceData;
+ (NSArray *)getGuidanceDataWithClassName:(NSString *)className;
+ (void)deleteGuidanceDataWithClassName:(NSString *)className;

@end

@interface GuidanceView : UIView
//直接设置图片数组方式，用不到Guidance
- (void)showWithImageArray:(NSArray *)array;
//利用Guidance文件模式可实现动态设置图片
- (void)showWithClassName:(NSString *)className;
@end
