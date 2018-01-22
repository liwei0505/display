//
//  LoadingView.h
//  Display
//
//  Created by lee on 17/4/19.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LoadingViewType_line,
    LoadingViewType_pie,
    LoadingViewType_text
} LoadingViewType;

@interface LoadingView : UIView
@property (assign, nonatomic) CGFloat progress;
@property (assign, nonatomic) LoadingViewType loadingViewType;
@end
