//
//  Cus_View.m
//  Display
//
//  Created by lw on 17/3/30.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "Cus_View.h"

@implementation Cus_View

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    //设置添加控件，添加约束
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置子控件frame
}


@end
