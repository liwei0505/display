//
//  XWToplineViewController.m
//  新闻
//
//  Created by lw on 15/9/16.
//  Copyright © 2015年 lw. All rights reserved.
//

#import "XWToplineViewController.h"
#import "PhotoBrowserController.h"
#import "PhotoModel.h"

@interface XWToplineViewController ()
@property (nonatomic, strong) NSArray *srcStringArray;
@end

@implementation XWToplineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    _srcStringArray = @[
                        @"https://ww2.sinaimg.cn/bmiddle/9ecab84ejw1emgd5nd6eaj20c80c8q4a.jpg",
                        @"http://ww2.sinaimg.cn/bmiddle/642beb18gw1ep3629gfm0g206o050b2a.gif",
                        @"https://ww4.sinaimg.cn/bmiddle/9e9cb0c9jw1ep7nlyu8waj20c80kptae.jpg"
                        ];
    /*,
    @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr1xydcj20gy0o9q6s.jpg",
    @"http://ww2.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
    @"http://ww4.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
    @"http://ww3.sinaimg.cn/bmiddle/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
    @"http://ww2.sinaimg.cn/bmiddle/677febf5gw1erma104rhyj20k03dz16y.jpg",
    @"http://ww4.sinaimg.cn/bmiddle/677febf5gw1erma1g5xd0j20k0esa7wj.jpg"
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    PhotoBrowserController *photoBrowser = [[PhotoBrowserController alloc] init];
    photoBrowser.type = PhotoBrowser_present;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<self.srcStringArray.count; i++) {
        PhotoModel *model = [[PhotoModel alloc] init];
        model.pic_name = self.srcStringArray[i];
        [arr addObject:model];
    }
    photoBrowser.photoItems = arr;
    photoBrowser.currentIndex = 0;
    /*
     UIModalPresentationFullScreen = 0,
     UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
     UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
     UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
     UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
     UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
     UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
     UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
     UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
     
     UIModalTransitionStyleCoverVertical = 0,
     UIModalTransitionStyleFlipHorizontal __TVOS_PROHIBITED,
     UIModalTransitionStyleCrossDissolve,
     UIModalTransitionStylePartialCurl NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
     */
    photoBrowser.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:photoBrowser animated:YES completion:nil];
    
    
    //测试会不会调用 不在nav下 之后在其他vc测试
//    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
//        [self setNeedsStatusBarAppearanceUpdate];
//    }

}

#pragma mark - status bar after ios9
//将View controller-based status bar appearance设置为YES
//则[UIApplication sharedApplication].statusBarStyle 无效

//方法1.vc中重写
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

//- (UIViewController *)childViewControllerForStatusBarStyle {
//    
//}

//方法 在viewDidload中调用：[self setNeedsStatusBarAppearanceUpdate];
/*
 但是，当vc在nav中时，上面方法没用 ，vc中的preferredStatusBarStyle方法根本不用被调用。
 原因是，[self setNeedsStatusBarAppearanceUpdate]发出后，
 只会调用navigation controller中的preferredStatusBarStyle方法，
 vc中的preferredStatusBarStyley方法跟本不会被调用
*/
//解决一、
/*
 设置navbar的barStyle 属性会影响status bar 的字体和背景色
 self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
 */

//解决二、
/*
 自定义一个nav bar的子类，在这个子类中重写preferredStatusBarStyle方法
 Nav* nav = [[Nav alloc] initWithRootViewController:vc];
 self.window.rootViewController = nav;
 @implementation Nav
 - (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
 }
 */

@end
