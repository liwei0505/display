//
//  PhotoView.h
//  Display
//
//  Created by lee on 17/4/20.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface PhotoView : UIView
@property (copy, nonatomic) void (^singleTapBlock)(UITapGestureRecognizer *recognizer);
@property (assign, nonatomic) BOOL beginLoadingImage;
@property (strong, nonatomic) PhotoModel *model;
@property (strong, nonatomic) UIImageView *imageView;
- (void)setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)reset;
@end
