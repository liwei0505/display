//
//  PhotoBrowserController.m
//  Display
//
//  Created by lee on 17/4/19.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "PhotoBrowserController.h"
#import "PhotoView.h"
#import "TopHintView.h"

@interface PhotoBrowserController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *lbTitle;
@property (strong, nonatomic) UIButton *btnSave;
@end

@implementation PhotoBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addSubviews];
}

- (void)addSubviews {

    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.photoItems.count * self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:CGPointMake(self.currentIndex * self.scrollView.frame.size.width, 0) animated:YES];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<self.photoItems.count; i++) {
        PhotoView *photoView = [[PhotoView alloc] initWithFrame:CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
        photoView.model = self.photoItems[i];
        [self.scrollView addSubview:photoView];
        photoView.singleTapBlock = ^(UITapGestureRecognizer *recogniser){
            if (self.type == PhotoBrowser_present) {
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        };
    }
    
    self.lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.frame.size.height-40, 200, 20)];
    self.lbTitle.textColor = [UIColor whiteColor];
    self.lbTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:self.lbTitle];
    self.lbTitle.text = [NSString stringWithFormat:@"%d/%lu",self.currentIndex+1,(unsigned long)self.photoItems.count];
    
    self.btnSave = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-60, self.view.frame.size.height-40, 40, 20)];
    [self.btnSave setTitle:@"保存" forState:UIControlStateNormal];
    [self.btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnSave addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnSave];
    
    [self downLoadImageOfPhotoViewForIndex:self.currentIndex];
    
}

- (void)saveImage {

    int index = _scrollView.contentOffset.x / _scrollView.bounds.size.width;
    PhotoView *currentView = _scrollView.subviews[index];
    UIImageWriteToSavedPhotosAlbum(currentView.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {

    if (error) {
        [TopHintView show:@"失败"];
    } else {
        [TopHintView show:@"成功"];
    }
}

- (void)downLoadImageOfPhotoViewForIndex:(NSInteger)index {

    PhotoView *photoView = self.scrollView.subviews[index];
    if (photoView.beginLoadingImage) {
        return;
    }
    photoView.beginLoadingImage = YES;
    [photoView setImageWithUrl:[NSURL URLWithString:photoView.model.pic_name] placeholderImage:nil];
    
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    int index = scrollView.contentOffset.x / _scrollView.bounds.size.width + 0.5;
    long left = index - 1;
    long right = index + 1;
    left = left > 0 ? left : 0;
    right = right > self.photoItems.count ? self.photoItems.count : right;
    self.lbTitle.text = [NSString stringWithFormat:@"%d/%lu",index+1,(unsigned long)self.photoItems.count];
    for (long i = left; i < right; i++) {
        [self downLoadImageOfPhotoViewForIndex:i];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    for (PhotoView *photoView in self.scrollView.subviews) {
        [photoView reset];
    }
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
