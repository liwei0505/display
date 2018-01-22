//
//  GestureView.h
//  Display
//
//  Created by lee on 17/4/18.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GestureView;

typedef enum {
    GestureView_normal,
    GestureView_error
} GestureViewType;

@protocol GestureViewDelegate <NSObject>
@optional
- (void)gestureView:(GestureView *)gestureView didSelectedPassword:(NSString *)password;
@end

@interface GestureView : UIView
@property (weak, nonatomic) id<GestureViewDelegate> delegate;
@property (assign, nonatomic) GestureViewType gestureViewType;
@end
