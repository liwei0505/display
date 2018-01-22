//
//  TopHintView.h
//  Display
//
//  Created by lee on 17/4/20.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopHintView : UIView
@property (strong, nonatomic) UILabel *lbHint;
+ (instancetype)sharedInstance;
+ (void)show:(NSString *)message;
@end
