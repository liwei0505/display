//
//  RotateView.m
//  Display
//
//  Created by lw on 2017/5/20.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "RotateView.h"
#import "RotateImageView.h"

#define RADIUS 100.0
#define PHOTONUM 5
#define TAGSTART 1000
#define SCALENUMBER 1.25
int array [PHOTONUM][PHOTONUM] ={
    {0,1,2,3,4},
    {4,0,1,2,3},
    {3,4,0,1,2},
    {2,3,4,0,1},
    {1,2,3,4,0}
};

@interface RotateView()
@property (strong, nonatomic) NSArray *textArray;
@property (assign, nonatomic) NSInteger index;
@end

@implementation RotateView
CATransform3D rotationTransform1[PHOTONUM];

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"121"]];
        backImage.center = CGPointMake(backImage.center.x, backImage.center.y-10);
        backImage.alpha = 0.3;
        [self addSubview:backImage];
        
        float centery = self.center.y-50;
        float centerx = self.center.x;
        __weak typeof(self)weakSelf = self;
        for (int i=0; i<PHOTONUM; i++) {
            float tmpy = centery + RADIUS*cos(2.0*M_PI*i/PHOTONUM);
            float tmpx = centerx - RADIUS*sin(2.0*M_PI*i/PHOTONUM);
            RotateImageView *rotateView = [[RotateImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon%d",i]] text:self.textArray[i]];
            rotateView.frame = CGRectMake(0.0, 0.0, 120, 140);
            rotateView.center = CGPointMake(tmpx, tmpy);
            rotationTransform1[i] = CATransform3DIdentity;
            rotateView.tag = i+TAGSTART;
            rotateView.userInteractionEnabled = YES;
            rotateView.block = ^(NSInteger tag){
                [weakSelf rotateAtTag:tag];
            };
            
            //float Scalenumber =atan2f(sin(2.0*M_PI *i/PHOTONUM));
            float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
            if (Scalenumber<0.3) {
                Scalenumber = 0.4;
            }
            CATransform3D rotationTransform = CATransform3DIdentity;
            rotationTransform = CATransform3DScale(rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);
            rotateView.layer.transform = rotationTransform;
            [self addSubview:rotateView];
        }
        self.index = TAGSTART;
    }
    return self;
}

- (void)rotateAtTag:(NSInteger)tag {

    NSLog(@"tag:%ld",(long)tag);
    if (self.index == tag) {
        return;
    }
    NSInteger t = [self getTapIndex:tag];
    for (int i=0; i<PHOTONUM; i++) {
        UIImageView *imgView = [self viewWithTag:tag+TAGSTART];
        [imgView.layer addAnimation:[self moveWithTag:i+TAGSTART number:t] forKey:@"position"];
        [imgView.layer addAnimation:[self setScale:TAGSTART+i clickTag:tag] forKey:@"transform"];
        
    }
    self.index = tag;
    
}

- (NSInteger)getTapIndex:(NSInteger)tag {
//向一个方向旋转，计算差值
    if (self.index > tag) {
        return self.index-tag;
    } else {
        return PHOTONUM + self.index - tag;
    }
}

#pragma mark - animation
- (CAAnimation *)moveWithTag:(NSInteger)tag number:(NSInteger)num {

    UIImageView *imgView = [self viewWithTag:tag];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    NSLog(@"原点%f原点%f",imgView.layer.position.x,imgView.layer.position.y);
    CGPathMoveToPoint(path, NULL, imgView.layer.position.x, imgView.layer.position.y);
    NSInteger p = [self getTapIndex:tag];
    NSLog(@"旋转%ld",(long)p);
    float f = 2.0*M_PI - 2.0*M_PI*p/PHOTONUM;
    float h = f + 2.0*M_PI*num/PHOTONUM;
    float centery = self.center.y-50;
    float centerx = self.center.x;
    float tmpy = centery + RADIUS*cos(h);
    float tmpx = centerx - RADIUS*sin(h);
    imgView.center = CGPointMake(tmpx, tmpy);
    
    CGPathAddArc(path, nil, self.center.x, self.center.y-50, RADIUS, f+M_PI/2, f+M_PI/2+2.0*M_PI*num/PHOTONUM, 0);
    animation.path = path;
    CGPathRelease(path);
    animation.duration = 1.5;
    animation.repeatCount = 1;
    animation.calculationMode = @"paced";
    return animation;
    
}

- (CAAnimation *)setScale:(NSInteger)tag clickTag:(NSInteger)clickTag {

    int i = array[clickTag - TAGSTART][tag - TAGSTART];
    int i1 = array[self.index - TAGSTART][tag - TAGSTART];
    float Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
    float Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
    if (Scalenumber<0.3)
    {
        Scalenumber = 0.4;
    }
//    UIImageView *imgview = (UIImageView*)[self viewWithTag:tag];
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1.5;
    animation.repeatCount = 1;
    
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //imgview.layer.transform=dtmp;
    
    return animation;
    
}

- (NSArray *)textArray {

    if (!_textArray) {
        _textArray = @[@"手机银行",@"手机订票",@"影票在线",@"网点地图",@"建行商城"];
    }
    return _textArray;
}

@end
