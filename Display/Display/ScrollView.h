//
//  ScrollView.h
//  Display
//
//  Created by lw on 17/4/12.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollView;

@protocol ScrollViewDelegate <NSObject>
- (void)scrollView:(ScrollView *)scrollView didSelectAtIndex:(NSInteger)index;
@end

@interface ScrollView : UIView

@property (weak, nonatomic) id<ScrollViewDelegate> delegate;
@property (strong, nonatomic) NSArray<NSString *> *urlArray;
@property (strong, nonatomic) NSString  *placeHolderImage;

- (instancetype)init __attribute__((unavailable("init不可用，请使用initWithFrame:")));
+ (instancetype)new __attribute__((unavailable("new不可用，请使用initWithFrame:")));
@end
