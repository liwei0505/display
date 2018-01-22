//
//  MSSetTradePassword.m
//  Sword
//
//  Created by lee on 16/12/22.
//  Copyright © 2016年 mjsfax. All rights reserved.
//

#import "MSSetTradePassword.h"
#import "MSCheckInfoUtils.h"
#import "MSSetTradePasswordView.h"
#import "MSToast.h"

@interface MSSetTradePassword ()<MSSetTradePasswordViewDelegate>

@property (strong, nonatomic) UILabel *lbTitle;
@property (strong, nonatomic) MSSetTradePasswordView *passwordView;
@property (copy, nonatomic) NSString *passwordString;

@end

@implementation MSSetTradePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    [self setUpLeftItem];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

#pragma mark - UI
- (void)prepare {

    self.title = NSLocalizedString(@"str_title_set_trade_password", @"");
//    if (self.type == TRADE_PASSWORD_SET) {
//        self.title = NSLocalizedString(@"str_title_set_trade_password", @"");
//    } else if (self.type == TRADE_PASSWORD_RESET) {
//        self.title = NSLocalizedString(@"str_title_reset_trade_password", @"");
//    }
    
    float width = self.view.bounds.size.width;
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 56, width, 20)];
    lbTitle.text = @"请设置交易密码，用于交易验证";
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    lbTitle.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    self.lbTitle = lbTitle;
    [self.view addSubview:self.lbTitle];
    
    float itemSize = (width - 2*24 - 5*8) / 6.0;
    self.passwordView = [[MSSetTradePasswordView alloc] initWithFrame:CGRectMake(24, CGRectGetMaxY(lbTitle.frame)+16, width-2*24, itemSize)];
    self.passwordView.delegate = self;
    [self.view addSubview:self.passwordView];

}

- (void)setUpLeftItem {

    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:(@selector(pop))];
    self.navigationItem.leftBarButtonItem = left;
}

#pragma mark - action

- (void)pop {
    if (self.backBlock) {
        self.backBlock();
        [self popSelf];
    } else {
        [self popSelf];
    }
}

- (void)completeButtonClick {
    [self userSetTradePassword:self.passwordString];
//    [self userResetTradePassword:self.passwordString];
}

#pragma mark - deletage

- (void)passWordCompleteInput:(NSString *)password {
    
    if (!self.passwordString) {
        if ([MSCheckInfoUtils tradePasswordCheckout:password]) {
            [MSToast show:NSLocalizedString(@"hint_alert_trade_password_simple", @"")];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.passwordView clear];
            });
            return;
        }
        self.passwordString = password;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.lbTitle.text = @"请确认交易密码";
            [self.passwordView clear];
        });
        return;
    }
    
    if ([self.passwordString isEqualToString:password]) {
        [self completeButtonClick];
        
    } else {
        [MSToast show:NSLocalizedString(@"hint_alert_password_diff", @"")];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.passwordView clear];
        });
    }
    
}

#pragma mark - private
- (void)userSetTradePassword:(NSString *)password {
}

- (void)userResetTradePassword:(NSString *)password {
}

//跳转成功页
- (void)setTradePasswordResult:(NSError *)result {
}

- (void)popSelf {
    __block NSUInteger index;
    [self.navigationController.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == self) {
            index = idx;
        }
    }];
    [self.navigationController popToViewController:self.navigationController.childViewControllers[index-1] animated:YES];
}

@end
