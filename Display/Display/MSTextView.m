//
//  MSTextView.m
//  Display
//
//  Created by lee on 17/4/19.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "MSTextView.h"

@interface MSTextView()<UITextViewDelegate>
@property (strong, nonatomic) UILabel *lbPlaceHolder;
@end

@implementation MSTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {

    _lbPlaceHolder = [[UILabel alloc] init];
    _lbPlaceHolder.font = self.font;
    _lbPlaceHolder.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.2];
    _lbPlaceHolder.numberOfLines = 0;
    
    [self addSubview:_lbPlaceHolder];
    self.alwaysBounceVertical = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];

    self.delegate = self;
    
}

- (void)textDidChange {

    if (self.text.length) {
        [self.lbPlaceHolder removeFromSuperview];
    } else {
        [self addSubview:_lbPlaceHolder];
    }
}

- (void)setPlaceHolder:(NSString *)placeHolder {

    _placeHolder = placeHolder;
    
    if (placeHolder && placeHolder.length > 0) {
        CGSize size = [placeHolder boundingRectWithSize:CGSizeMake(self.frame.size.width-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_lbPlaceHolder.font} context:nil].size;
        _lbPlaceHolder.frame = CGRectMake(20, 10, size.width, size.height);
        _lbPlaceHolder.text = placeHolder;
    }

}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    _lbPlaceHolder.textColor = placeHolderColor;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self endEditing:YES];
}

@end
