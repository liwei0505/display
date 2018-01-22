//
//  ProgressView2.h
//  Display
//
//  Created by lee on 17/4/17.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ProgressViewType_showProgressLabel,
    ProgressViewType_showPreogressButton
} ProgressViewType;

/*
 * progress < 0        -->>  显示  0%
 * 0 <= progress < 1   -->>  0% <=  显示 < 100%
 * 1 <= progress < 10  -->>  100% <=  显示 < 1000%
 * 10 <= progress      -->>  显示  ≥999%
 */

@interface ProgressView2 : UIView
@property (assign, nonatomic) CGFloat progress;
@property (assign, nonatomic) ProgressViewType progressViewType;
@end
