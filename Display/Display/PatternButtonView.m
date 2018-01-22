//
//  unlockButtonView.m
//  手势解锁
//
//  Created by lw on 15/9/7.
//  Copyright © 2015年 lw. All rights reserved.
//

#import "PatternButtonView.h"

#define LineColor [UIColor colorWithRed:0.0 green:170/255.0 blue:255/255.0 alpha:1.0]

@interface PatternButtonView()

@property (nonatomic,strong) NSArray *unlockBtn;
//纪录被选中按钮
@property (nonatomic,strong) NSMutableArray *selectedBtn;
@property (nonatomic,strong) UIColor *lineColor;

@end

@implementation PatternButtonView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//重写drawrect方法 绘制连线
- (void)drawRect:(CGRect)rect {

    if (self.selectedBtn.count <= 1) {
        return;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.selectedBtn.count; i++) {
        UIButton *btn = self.selectedBtn[i];
        if (i == 0) {
            [path moveToPoint:[btn center]];
        }else{
        
            [path addLineToPoint:[btn center]];
            
        }
    }
    [self.lineColor set];
    [path stroke];
}

- (void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:self];
    //判断当前位置是否在按钮内部
    for (UIButton *btn in self.unlockBtn) {
         //按钮在触摸区域 && 按钮状态没有被选中 才将按钮添加到被选中数据 等待被连线
        if (CGRectContainsPoint(btn.frame, loc) && !btn.selected) {
            btn.selected = YES;
            [self.selectedBtn addObject:btn];
        }
    }
}

- (void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

    UITouch *touch = touches.anyObject;
    CGPoint loc = [touch locationInView:self];
    //判断当前位置是否在按钮内部
    for (UIButton *btn in self.unlockBtn) {
        if (CGRectContainsPoint(btn.frame, loc) && !btn.selected) {
            btn.selected = YES;
            [self.selectedBtn addObject:btn];
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

    NSMutableString *password = [[NSMutableString alloc]init];
    for (UIButton *btn in self.selectedBtn) {
        [password appendFormat:@"%@",@(btn.tag)];
    }
    NSLog(@"%@",password);
    BOOL isOK = NO;
    if ([self.delegate respondsToSelector:@selector(checkUnlockButton:withPassword:)]) {
        isOK = [self.delegate checkUnlockButton:self withPassword:password];
    }
    if (isOK == YES) {
        [self clear];
    }else{
    
        for (UIButton *btn in self.selectedBtn) {
            btn.selected = NO;
            btn.enabled = NO;
        }
        self.lineColor = [UIColor redColor];
        [self setNeedsDisplay];
        self.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.5*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self clear];
            self.userInteractionEnabled = YES;
        });
    }
    
}

- (void)clear {

    self.lineColor = LineColor;
    for (UIButton *btn in self.selectedBtn) {
        btn.selected = NO;
        btn.enabled = YES;
    }
    [self.selectedBtn removeAllObjects];
    [self setNeedsDisplay];

    
}

//布局解锁按钮
- (void)layoutSubviews {
    
    [super layoutSubviews];
        int count = 3;
        CGFloat btnW = 74;
        CGFloat btnH = btnW;
        CGFloat margin = (self.bounds.size.width - btnW * count) / (count - 1);
    
        for (int i = 0; i < self.unlockBtn.count; i++) {
            CGFloat x = (btnW + margin) * (i % count);
            CGFloat y = (btnH + margin) * (i / count);
    
            UIButton *btn = self.unlockBtn[i];
            btn.frame = CGRectMake(x, y, btnW, btnH);
        }
    
}

- (UIColor *)lineColor {

    if (_lineColor == nil) {
        _lineColor = LineColor;
    }
    return _lineColor;
}
- (NSMutableArray *)selectedBtn {

    if (_selectedBtn == nil) {
        _selectedBtn = [NSMutableArray array];
    }
    return _selectedBtn;
}
//懒加载按钮
- (NSArray *)unlockBtn {
    
    if (_unlockBtn == nil) {
        NSMutableArray *temp = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.tag = i;
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
            //设置按钮不与用户交互：按钮与用户交互会拦截触摸事件 导致父控件不响应触摸事件 触摸没有反应
            btn.userInteractionEnabled = NO;
            [self addSubview:btn];
            [temp addObject:btn];
        }
        _unlockBtn = temp;
    }
    return _unlockBtn;
}

@end
