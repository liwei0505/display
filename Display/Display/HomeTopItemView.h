//
//  HomeTopItemView.h
//  Display
//
//  Created by lee on 2017/10/9.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTopItemView : UIView
@property (assign, nonatomic) float contentAlpha;
@property (copy, nonatomic) void(^buttonClickBlock)(NSInteger index);
@end
