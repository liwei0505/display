//
//  MSScrollView.m
//  Display
//
//  Created by lee on 17/4/13.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "MSScrollView.h"
#import "ScrollView.h"

@interface MSScrollView()<ScrollViewDelegate>

@property (strong, nonatomic) ScrollView *scrollView;

@end

@implementation MSScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {

    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    ScrollView *scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    scrollView.delegate = self;
    scrollView.placeHolderImage = @"meitupian";
    self.scrollView = scrollView;
    [self addSubview:self.scrollView];
    
}

- (void)scrollView:(ScrollView *)scrollView didSelectAtIndex:(NSInteger)index {

    NSLog(@"index:%ld",(long)index);
}

- (void)setBannerList:(NSArray *)bannerList {

    _bannerList = bannerList;
    self.scrollView.urlArray = bannerList;
}

@end
