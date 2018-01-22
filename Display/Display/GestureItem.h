//
//  GestureItem.h
//  Display
//
//  Created by lee on 17/4/18.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GestureItem_normal,
    GestureItem_error,
    GestureItem_success
} GestureItemType;

@interface GestureItem : UIView
@property (assign, nonatomic) GestureItemType gestureItemType;
@end
