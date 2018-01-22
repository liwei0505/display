//
//  RotateImageView.h
//  Display
//
//  Created by lw on 2017/5/20.
//  Copyright © 2017年 mjsfax. All rights reserved.
/*
 ?是否能替换成view
 */

#import <UIKit/UIKit.h>

@interface RotateImageView : UIImageView
@property (copy, nonatomic) void(^block)(NSInteger tag);
- (RotateImageView *)initWithImage:(UIImage *)image text:(NSString *)text;
@end
