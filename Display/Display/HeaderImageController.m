
//  Created by lee on 16/11/16.
//  Copyright © 2016年 lw. All rights reserved.
/*
 利用 UIVisualEffect这类实现毛玻璃效果， 这是一个抽象的类，不能直接使用,需通过它子类(UIBlurEffect, UIVibrancyEffect ) 外加 UIVisualEffectView 一起实现
 */

#import "HeaderImageController.h"
#import "UIImage+color.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanViewController.h"

const int HEIGHT = 200;

@interface HeaderImageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation HeaderImageController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.alpha = 0.0;//无返回按钮了
    [self prepareNav];
    [self prepareTableview];
    [self prepareImage];
}

- (void)prepareNav {

    UIImage *image = [UIImage ms_createImageWithColor:[UIColor clearColor] withSize:CGSizeMake(self.view.bounds.size.width, 64)];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = image;
}

- (void)prepareTableview {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor redColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.contentInset = UIEdgeInsetsMake(HEIGHT, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.bouncesZoom = NO;
    [self.view addSubview:self.tableView];
}

- (void)prepareImage {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -HEIGHT, self.view.bounds.size.width, HEIGHT)];
    imageView.image = [UIImage imageNamed:@"banner"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    /*
     注意⚠️
        超出部分裁剪掉，如果不裁剪掉 有可能挡住第一个cell一部分
     */
    imageView.clipsToBounds = YES;
    
    imageView.tag = 101;
    [self.tableView addSubview:imageView];  //这样第一个cell会被挡住一部分
//    [self.tableView insertSubview:imageView atIndex:0]; //只有这种方法第一个cell不会被挡住 ？？？？
//    [self.tableView insertSubview:imageView aboveSubview:self.view];
//    self.tableView.tableHeaderView = imageView;
    
    //添加毛玻璃效果
    /*
     iOS7的实现依靠UIToolbar，创建一个UIToolbar实例，然后设置属性 barStyle对应的属性值，然后添加到父视图上就好了！
     UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:frame];
     toolbar.barStyle = UIBarStyleBlackOpaque;// 设置毛玻璃样式
     */
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectView.frame = imageView.frame;
    self.effectView = effectView;
    [self.tableView addSubview:effectView];
    
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //改变图片大小 从而使其放大 缩小
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%@",NSStringFromCGPoint(point));
    if (point.y < -HEIGHT) {
        CGRect rect = [self.tableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        [self.tableView viewWithTag:101].frame = rect;
        
        //调整毛玻璃效果
        self.effectView.alpha = 1 + (point.y + HEIGHT) / HEIGHT;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (indexPath.row == 0) {
    
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"123";
    } else {
        cell.textLabel.text = @"123";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
   
    } else if (indexPath.row == 1) {
    
    } else {
//        MSViewController4 *v = [[MSViewController4 alloc] init];
//        //    v.fd_interactivePopDisabled = YES;
//        //    v.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge = 100;
//        v.navigationItem.title = @"测试";
//        [self.navigationController pushViewController:v animated:YES];
    }
    
}

@end
