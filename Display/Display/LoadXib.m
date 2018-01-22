//
//  LoadXib.m
//  Display
//
//  Created by lee on 2017/5/17.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "LoadXib.h"

@implementation LoadXib

+ (UIView *)instance {

    NSArray *nibView = [[NSBundle mainBundle] loadNibNamed:@"LoadXib" owner:nil options:nil].firstObject;
    return [nibView objectAtIndex:0];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //add your ---
    }
    return self;
}

@end
