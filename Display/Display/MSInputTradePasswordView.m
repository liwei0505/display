//
//  MSInputTradePasswordView.m
//  Sword
//
//  Created by lee on 2017/9/7.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "MSInputTradePasswordView.h"
#import "MSSetTradePasswordView.h"

@interface MSInputTradePasswordView()<MSSetTradePasswordViewDelegate>

@property (strong, nonatomic) UILabel *lbCancelAmount;
@property (strong, nonatomic) MSSetTradePasswordView *passwordView;

@end

@implementation MSInputTradePasswordView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        float width = self.bounds.size.width;
        self.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        [btnCancel setImage:[UIImage imageNamed:@"pay_cancel"] forState:UIControlStateNormal];
        [btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCancel];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (SCREENWIDTH-200)*0.5, 200, 40)];
        label.text = @"支付密码";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:14];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
        [self addSubview:label];
        
        UIButton *forget = [[UIButton alloc] initWithFrame:CGRectMake(width-66, 0, 50, 43)];
        [forget setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forget setTitleColor:[UIColor ms_colorWithHexString:@"4229B3"] forState:UIControlStateNormal];
        forget.titleLabel.font = [UIFont systemFontOfSize:12];
        [forget addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:forget];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, width, 1)];
        [self addSubview:line];
        
        self.lbCancelAmount = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, width, 20)];
        self.lbCancelAmount.font = [UIFont systemFontOfSize:14];
        self.lbCancelAmount.textAlignment = NSTextAlignmentCenter;
        self.lbCancelAmount.textColor = [UIColor ms_colorWithHexString:@"666666"];
        [self addSubview:self.lbCancelAmount];
        
        float itemSize = (width - 5*8-2*24) / 6.0;
        self.passwordView = [[MSSetTradePasswordView alloc] initWithFrame:CGRectMake(24, 96, width-2*24, itemSize)];
        self.passwordView.delegate = self;
        [self addSubview:self.passwordView];
    }
    return self;
}

- (void)tap {
    
}

- (void)passWordDicChange:(MSSetTradePasswordView *)view {

}

- (void)passWordCompleteInput:(NSString *)password {
    if (self.inputBlock) {
        self.inputBlock(password);
    }
}

- (void)forgetPassword {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)showKeyboard {
    [self.passwordView becomeFirstResponder];
}

- (void)resignKeyboard {
    [self.passwordView resignFirstResponder];
}

- (void)cancel {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)setCancelAmount:(NSString *)cancelAmount {
    _cancelAmount = cancelAmount;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"退保%@",self.cancelAmount]];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:243/255.0 green:9/255.0 blue:28/255.0 alpha:1/1.0] range:NSMakeRange(2, attri.length-3)];
    self.lbCancelAmount.attributedText = attri;
}

@end
