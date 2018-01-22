//
//  ScrollView.m
//  Display
//
//  Created by lw on 17/4/12.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ScrollView.h"
#define PAGE_NUMBER 3

@interface ScrollView()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView *imageViewLeft;
@property (strong, nonatomic) UIImageView *imageViewCenter;
@property (strong, nonatomic) UIImageView *imageViewRight;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        float width = self.frame.size.width;
        float height = self.frame.size.height;
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        scrollView.pagingEnabled = YES;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.contentSize = CGSizeMake(PAGE_NUMBER * width, 0);
        scrollView.contentOffset = CGPointMake(width, 0);
        scrollView.delegate = self;
        self.scrollView = scrollView;
        [self addSubview:self.scrollView];
        
        UIImageView *left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        left.contentMode = UIViewContentModeScaleToFill;
        left.clipsToBounds = YES;
        self.imageViewLeft = left;
        [self.scrollView addSubview:self.imageViewLeft];
        
        UIImageView *center = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
        center.contentMode = UIViewContentModeScaleToFill;
        center.clipsToBounds = YES;
        self.imageViewCenter = center;
        [self.scrollView addSubview:self.imageViewCenter];
        
        UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectMake(width * 2, 0, width, height)];
        right.contentMode = UIViewContentModeScaleToFill;
        right.clipsToBounds = YES;
        self.imageViewRight = right;
        [self.scrollView addSubview:self.imageViewRight];
        
        self.pageControl = [[UIPageControl alloc] init];
        self.pageControl.backgroundColor = [UIColor clearColor];
        self.pageControl.hidesForSinglePage = YES;
        [self addSubview:self.pageControl];
        
        self.currentIndex = 0;
        
        [self addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)tap {

    if (!self.urlArray || !self.urlArray.count ) {
        return;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollView:didSelectAtIndex:)]) {
        [self.delegate scrollView:self didSelectAtIndex:self.currentIndex];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self start];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stop];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self reload];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reload];
}

#pragma mark - timer

- (void)start {

    __weak typeof(self)weakSelf = self;
//    [NSTimer timerWithTimeInterval:<#(NSTimeInterval)#> target:<#(nonnull id)#> selector:<#(nonnull SEL)#> userInfo:<#(nullable id)#> repeats:<#(BOOL)#>]
    self.timer = [NSTimer timerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
       [UIView animateWithDuration:0.3 animations:^{
           [weakSelf.scrollView setContentOffset:CGPointMake(weakSelf.frame.size.width*2, 0) animated:YES];
       }];
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stop {

    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - data

- (void)reload {
    if (!self.urlArray || !self.urlArray.count) {
        return;
    }
    
    float width = self.frame.size.width;
    NSInteger indexLeft, indexRight;
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    if (contentOffsetX > width) {
        self.currentIndex = (self.currentIndex + 1) % self.urlArray.count;
    } else if (contentOffsetX < width) {
        self.currentIndex = (self.currentIndex + self.urlArray.count - 1) % self.urlArray.count;
    }
    
    self.pageControl.currentPage = self.currentIndex;
    [self.imageViewCenter setImage:[UIImage imageNamed:self.urlArray[self.currentIndex]]];
    self.scrollView.contentOffset = CGPointMake(width, 0);
    
    indexLeft = (self.currentIndex + self.urlArray.count - 1) % self.urlArray.count;
    indexRight = (self.currentIndex + 1) % self.urlArray.count;
    [self.imageViewLeft setImage:[UIImage imageNamed:self.urlArray[indexLeft]]];
    [self.imageViewRight setImage:[UIImage imageNamed:self.urlArray[indexRight]]];
    
}

- (void)setUrlArray:(NSArray<NSString *> *)urlArray {

    [self stop];
    
    _urlArray = urlArray;
    
    self.pageControl.numberOfPages = urlArray.count;
    CGSize size = [self.pageControl sizeForNumberOfPages:urlArray.count];
    self.pageControl.frame = CGRectMake(self.bounds.size.width-size.width-12, self.bounds.size.height-30, size.width, 30);
    
    if (!self.urlArray || !self.urlArray.count) {
        self.userInteractionEnabled = NO;
        return;
    }
    
    self.userInteractionEnabled = YES;
    
    self.currentIndex = 0;
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    self.pageControl.currentPage = self.currentIndex;
    
    NSInteger indexLeft = (self.currentIndex + urlArray.count - 1) % urlArray.count;
    NSInteger indexRight = (self.currentIndex + 1) % urlArray.count;
    
    [self.imageViewCenter setImage:[UIImage imageNamed:self.urlArray[self.currentIndex]]];
    [self.imageViewRight setImage:[UIImage imageNamed:self.urlArray[indexRight]]];
    [self.imageViewLeft setImage:[UIImage imageNamed:self.urlArray[indexLeft]]];
    
    [self start];
}


@end
