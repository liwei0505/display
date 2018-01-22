//
//  MSInputTradePasswordView.h
//  Sword
//
//  Created by lee on 2017/9/7.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSInputTradePasswordView : UIView
@property (copy, nonatomic) void(^cancelBlock)(void);
@property (copy, nonatomic) void(^inputBlock)(NSString *password);
@property (strong, nonatomic) NSString *cancelAmount;
- (void)showKeyboard;
- (void)resignKeyboard;
@end
