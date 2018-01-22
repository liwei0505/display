//
//  PhotoView.m
//  Display
//
//  Created by lee on 17/4/20.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "PhotoView.h"
#import "LoadingView.h"
#import "UIImageView+WebCache.h"

@interface PhotoView()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) LoadingView *loadingView;
@property (strong, nonatomic) UIButton *reloadButton;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) UIImage *placeHolderImage;

@property (strong, nonatomic) UITapGestureRecognizer *doubleTap;
@property (strong, nonatomic) UITapGestureRecognizer *singleTap;
@property (assign, nonatomic) BOOL hasLoadedImage;

@end

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.hasLoadedImage = NO;
        self.beginLoadingImage = NO;
        [self addSubviews];
        [self addGestureRecognizer:self.singleTap];
        [self addGestureRecognizer:self.doubleTap];
        
    }
    return self;
}

- (void)addSubviews {

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.maximumZoomScale = 2;//最大缩放比例
    //self.scrollView.minimumZoomScale 最小缩放比例 默认都是1
    [self addSubview:self.scrollView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-100)*0.5, (self.frame.size.height-100)*0.5, 100, 100)];
    self.imageView.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.imageView];
    
    self.loadingView = [[LoadingView alloc] initWithFrame:CGRectMake((self.frame.size.width-50)*0.5, (self.frame.size.height-50)*0.5, 50, 50)];
    self.loadingView.loadingViewType = LoadingViewType_text;
    self.loadingView.hidden = YES;
    [self addSubview:self.loadingView];
    
    self.reloadButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width-200)*0.5, (self.frame.size.height-40)*0.5, 200, 40)];
    self.reloadButton.layer.cornerRadius = 2;
    self.reloadButton.clipsToBounds = YES;
    self.reloadButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.reloadButton.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f];
    [self.reloadButton setTitle:@"原图加载失败，点击重新加载" forState:UIControlStateNormal];
    [self.reloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.reloadButton addTarget:self action:@selector(reloadImage) forControlEvents:UIControlEventTouchUpInside];
    self.reloadButton.hidden = YES;
    [self addSubview:self.reloadButton];
    
}

#pragma mark - setImage

- (void)reloadImage {
    [self setImageWithUrl:self.imageUrl placeholderImage:self.placeHolderImage];
}

- (void)reset {
    [self.scrollView setZoomScale:1.0 animated:YES];
}

- (void)setImageWithUrl:(NSURL *)url placeholderImage:(UIImage *)placeholder {

    self.reloadButton.hidden = YES;
    self.loadingView.hidden = NO;
    _imageUrl = url;
    _placeHolderImage = placeholder;
    
    __weak typeof(self)weakSelf = self;
    [self.imageView sd_setImageWithURL:url placeholderImage:placeholder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        CGFloat progress = (CGFloat)receivedSize / expectedSize;
        if (progress <= 0) {
            weakSelf.loadingView.progress = 0.01;
        } else {
            weakSelf.loadingView.progress = progress;
        }
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        weakSelf.loadingView.hidden = YES;
        if (error) {
            weakSelf.reloadButton.hidden = NO;
            weakSelf.hasLoadedImage = NO;
        } else {
            weakSelf.hasLoadedImage = YES;
            weakSelf.reloadButton.hidden = YES;
            [self adjustFrameWithImage:image];
        }
    }];
    
}

- (void)adjustFrameWithImage:(UIImage *)image {

    CGFloat imageViewHeight = self.frame.size.width * (image.size.height / image.size.width);
    if (imageViewHeight > self.frame.size.height) {
        self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, imageViewHeight);
    } else {
        self.imageView.frame = CGRectMake(0, (self.frame.size.height - imageViewHeight) / 2, self.frame.size.width, imageViewHeight);
    }
    self.scrollView.contentSize = self.imageView.frame.size;
}

#pragma mark - recognizer

- (UITapGestureRecognizer *)singleTap {

    if (!_singleTap) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        _singleTap.numberOfTapsRequired = 1;
        _singleTap.numberOfTouchesRequired = 1;
    }
    return _singleTap;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {

    if (self.singleTapBlock) {
        self.singleTapBlock(recognizer);
    }
    
}

- (UITapGestureRecognizer *)doubleTap {
    
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _doubleTap;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer {

    if (!self.hasLoadedImage) {
        return;
    }
    CGPoint touchPoint = [recognizer locationInView:self];
    if (self.scrollView.zoomScale <= 1.0) {
        CGFloat scaleX = touchPoint.x + self.scrollView.contentOffset.x;
        CGFloat scaleY = touchPoint.y + self.scrollView.contentOffset.y;
        [self.scrollView zoomToRect:CGRectMake(scaleX, scaleY, 1, 1) animated:YES];
    } else {
        [self reset];
    }
}

#pragma mark - ScrollView delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.imageView.center = [self centerOfScrollViewContent:scrollView];
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {

    //contentSize < bounds return contentSize (x,y) 计算center
    //contentSize > bounds return contentSize 的center
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width)*0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height)*0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
    
}

@end
