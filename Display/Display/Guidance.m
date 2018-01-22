//
//  Guidance.m
//  Display
//
//  Created by lee on 17/2/28.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "Guidance.h"
#define  PATH  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"GuidanceData.strings"]
#define  SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height

@interface GuidanceView()

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSString *className;

@end

@implementation Guidance

+ (void)initGuidanceData
{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"GuidanceData" ofType:@"strings"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:file];
    [dic writeToFile:PATH atomically:YES];
}
+ (NSArray *)getGuidanceDataWithClassName:(NSString *)className
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:PATH];
    NSString *realClassName = [self convertScreen:className];
    NSString *dataStr = dic[realClassName];
    if (dataStr) {
        return [dataStr componentsSeparatedByString:@","];
    }else{
        return nil;
    }
    
}
+ (void)deleteGuidanceDataWithClassName:(NSString *)className
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:PATH];
    NSString *realClassName = [self convertScreen:className];
    [dic removeObjectForKey:realClassName];
    [dic writeToFile:PATH atomically:YES];
}

+ (NSString *)convertScreen:(NSString *)className
{
    if (SCREENHEIGHT >= 736) {
        return [NSString stringWithFormat:@"%@_6p",className];
    }else if (SCREENHEIGHT >= 667){
        return [NSString stringWithFormat:@"%@_6",className];
    }else if (SCREENHEIGHT >= 568){
        return [NSString stringWithFormat:@"%@_5",className];
    }else{
        return [NSString stringWithFormat:@"%@_4",className];
    }
}

@end

#pragma mark - Guidance

@implementation GuidanceView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        self.index = 0;
    }
    return self;
}

- (void)showWithImageArray:(NSArray *)array {

    if (!array) {
        return;
    }
    self.dataArray = array;
    [self addSubview:self.imageView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)showWithClassName:(NSString *)className
{
    self.dataArray = [Guidance getGuidanceDataWithClassName:className];
    if (!self.dataArray)  return;
    self.className = className;
    [self addSubview:self.imageView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (UIImageView *)imageView {

    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.userInteractionEnabled = YES;
        _imageView.image = [UIImage imageNamed:self.dataArray[self.index]];
        [_imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    }
    return _imageView;
}

- (void)tap {
    if (self.index > self.dataArray.count - 1) {
        [self removeFromSuperview];
    } else {
        self.imageView.image = [UIImage imageNamed:self.dataArray[self.index++]];
    }
}

@end
