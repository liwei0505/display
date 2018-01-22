//
//  LayoutView.m
//  demo
//
//  Created by lw on 17/3/30.
//  Copyright © 2017年 lw. All rights reserved.
//

#import "LayoutView.h"
#import "PureLayout.h"

@implementation LayoutView

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
    
    [self toSuperView];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置子控件frame
}

#pragma mark - 父子控件间约束

- (void)toSuperView {

    //设置添加控件，添加约束
    UIView *view = [UIView newAutoLayoutView];
    [self addSubview:view];
    view.backgroundColor = [UIColor greenColor];
    
    //子控件view充满父view
    [view autoPinEdgesToSuperviewEdges];
    
    //在父控件中心点
    [view autoCenterInSuperview];
    //相对父控件水平、垂直对齐
    //[view autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    //[view autoAlignAxisToSuperviewAxis:ALAxisVertical];
    
    //==>等价于下边方法edge都为0
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 20, 20, 20);
    [view autoPinEdgesToSuperviewEdgesWithInsets:insets];
    
    //==>拆分每个约束分别设置如下：
    [view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [view autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:20];
    [view autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    
    //通过源码发现设置父子控件约束相当于设置两个控件之间的约束,所以也可以如下设置
    //注意bottom与right的offset为负值
    [view autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:20];
    
    
    //设置上、左、下，不设置右：
    UIEdgeInsets exceptRight = UIEdgeInsetsMake(10, 10, 10, 30);
    [view autoPinEdgesToSuperviewEdgesWithInsets:exceptRight excludingEdge:ALEdgeRight];
    //重新设置右约束
    [view autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:50];
    
}

- (void)sizeSelf {

    UIView *view = [[UIView alloc] initForAutoLayout];
    [self addSubview:view];
    view.backgroundColor = [UIColor purpleColor];
    
    //设置宽高
    [view autoSetDimensionsToSize:CGSizeMake(50, 50)];
//    [view autoSetDimension:<#(ALDimension)#> toSize:<#(CGFloat)#> relation:<#(NSLayoutRelation)#>]
}

#pragma mark - 设置两个控件间约束

- (void)toOtherView {

    UIView *view1 = [[UIView alloc] init];
    [view1 configureForAutoLayout];
    view1.backgroundColor = [UIColor blueColor];
    [self addSubview:view1];
    UIView *view2 = [UIView newAutoLayoutView];
    view2.backgroundColor = [UIColor redColor];
    [self addSubview:view2];
    
    //蓝色view的左边,距离红色view的右边为30
    [view1 autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:view2 withOffset:30];
    //蓝色view,红色view等宽等高
    [@[view1, view2] autoMatchViewsDimension:ALDimensionWidth];
    [@[view1, view2] autoMatchViewsDimension:ALDimensionHeight];
    //蓝色view,红色view水平对齐
    [view1 autoAlignAxis:ALAxisHorizontal toSameAxisOfView:view2];
    
    //蓝色View的高度是红色View高度的一半
    [view1 autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:view2 withMultiplier:0.5];
    
}

- (void)equalWidth {

    UIView *view1 = [UIView newAutoLayoutView];
    [self addSubview:view1];
    UIView *view2 = [UIView newAutoLayoutView];
    [self addSubview:view2];
    UIView *view3 = [UIView newAutoLayoutView];
    [self addSubview:view3];
    UIView *view4 = [UIView newAutoLayoutView];
    [self addSubview:view4];
    
    NSArray *views = @[view1, view2, view3, view4];
    [views autoSetViewsDimension:ALDimensionHeight toSize:40.f];
    //间距为10,水平对齐,依次排列
    [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:10.0 insetSpacing:YES matchedSizes:YES];
    //红色view相对于其父view水平对齐
    [view1 autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

@end
