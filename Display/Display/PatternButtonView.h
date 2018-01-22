//
//  unlockButtonView.h
//  手势解锁
//
//  Created by lw on 15/9/7.
//  Copyright © 2015年 lw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PatternButtonView;
@protocol PatternButtonView <NSObject>

- (BOOL)checkUnlockButton:(PatternButtonView *)PatternButtonView withPassword:(NSMutableString *)password;

@end

@interface PatternButtonView : UIView

@property (nonatomic,assign)id<PatternButtonView> delegate;

@end
