//
//  PoperViewController.h
//  Display
//
//  Created by lee on 2017/6/14.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PoperViewController : UIViewController
@property (copy, nonatomic) void(^poperSelectedBlock)(NSInteger index);
@end
