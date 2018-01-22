//
//  MSSliderView.m
//  MSSliderView
//
//  Created by msj on 2017/7/6.
//  Copyright © 2017年 msj. All rights reserved.
//

#import "MSSliderView.h"
#import "UIView+FrameUtil.h"

@interface MSSliderView ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat maxFont;
@property (assign, nonatomic) CGFloat minFont;
@property (assign, nonatomic) CGFloat minAlpha;

@property (strong, nonatomic) NSMutableArray *lbTextArray;
@end

@implementation MSSliderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.lbTextArray = [NSMutableArray array];
        
        self.maxFont = 28;
        self.minFont = 15;
        self.minAlpha = 0.2;
    
        self.scrollView = [[UIScrollView alloc] init];
        [self addSubview:self.scrollView];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.alwaysBounceHorizontal = YES;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.clipsToBounds = NO;
        self.scrollView.delegate = self;
    }
    return self;
}

- (void)setTermCategories:(NSArray *)termCategories {
    _termCategories = termCategories;
    
    if (self.lbTextArray && self.lbTextArray.count > 0) {
        [self.lbTextArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.lbTextArray removeAllObjects];
    }
    
    CGFloat scrollViewW = self.width / 5.0;
    CGFloat scrollViewH = self.maxFont;
    CGFloat scrollViewX = (self.width - scrollViewW)/2.0;
    CGFloat scrollViewY = (self.height - self.maxFont)/2.0;
    self.scrollView.contentSize = CGSizeMake(termCategories.count * scrollViewW, 0);
    self.scrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    
    NSUInteger selectedIndex = 0;
    if (termCategories.count % 2 == 0) {
        selectedIndex = termCategories.count / 2;
    } else {
        selectedIndex = (termCategories.count - 1) / 2;
    }
    self.scrollView.contentOffset = CGPointMake(selectedIndex * scrollViewW, 0);
    
    for (int i = 0; i < termCategories.count; i++) {
        UILabel *lbText = [[UILabel alloc] init];
        lbText.text = [NSString stringWithFormat:@"%d期",[termCategories[i] intValue]];
        lbText.textAlignment = NSTextAlignmentCenter;
        [self.scrollView addSubview:lbText];
        [self.lbTextArray addObject:lbText];
        
        CGFloat offsetRatio = [self getOffsetRatioWith:scrollViewW * i contentOffsetX:self.scrollView.contentOffset.x];
        CGFloat font = fmax(self.maxFont * (1-offsetRatio), self.minFont);
        CGFloat height = font;
        
        lbText.font = [UIFont systemFontOfSize:font];
        lbText.frame = CGRectMake(scrollViewW * i, self.scrollView.height - height, scrollViewW, height);
        
        lbText.textColor = (i == selectedIndex) ? [UIColor redColor] : [UIColor greenColor];
        lbText.alpha = fmax(1 * (1-offsetRatio), self.minAlpha);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger count  = contentOffsetX / scrollView.width + 0.5;
    count = MIN(count, self.lbTextArray.count - 1);
    
    if (self.block) {
        self.block(count);
    }
    
    for (int i = 0;  i < self.lbTextArray.count; i++) {
        
        UILabel *lbText = self.lbTextArray[i];
        CGFloat offsetRatio = [self getOffsetRatioWith:lbText.x contentOffsetX:contentOffsetX];
        CGFloat font = fmax(self.maxFont * (1-offsetRatio), self.minFont);
        CGFloat height = font;
        
        lbText.font = [UIFont systemFontOfSize:font];
        lbText.frame = CGRectMake(lbText.x, self.scrollView.height - height, lbText.width, height);
        lbText.alpha = fmax(1 * (1-offsetRatio), self.minAlpha);
        lbText.textColor = (i != count) ? [UIColor greenColor] : [UIColor redColor];
    }
}

- (CGFloat)getOffsetRatioWith:(CGFloat)x contentOffsetX:(CGFloat)contentOffsetX {
    CGFloat distanceFromCenterX = x - contentOffsetX;
    CGFloat offsetRatio = fabs(distanceFromCenterX) / CGRectGetWidth(self.frame);
    return fmin(offsetRatio, 1);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if ([view isEqual:self]) {
        for (UIView *subview in self.lbTextArray) {
            
            CGFloat pointX = point.x - self.scrollView.x + self.scrollView.contentOffset.x - subview.x;
            CGFloat pointY = point.y - self.scrollView.y + self.scrollView.contentOffset.y - subview.y;
            CGPoint offset = CGPointMake(pointX, pointY);
            
            if ((view = [subview hitTest:offset withEvent:event])) {
                return view;
            }
        }
        return self.scrollView;
    }
    return view;
}

@end
