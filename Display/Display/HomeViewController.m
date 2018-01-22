//
//  HomeViewController.m
//  Display
//
//  Created by lee on 2017/10/9.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "HomeViewController.h"
#import "NavigationView.h"
#import "HomeTopItemView.h"
#import "HomeNavView.h"
#import "ScanViewController.h"
#import "PoperViewController.h"

@interface HomeViewController()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,UIPopoverPresentationControllerDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NavigationView *naviView;
@property (strong, nonatomic) HomeTopItemView *topView;
@property (strong, nonatomic) HomeNavView *homeNav;
@property (strong, nonatomic) PoperViewController *itemPopVC;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavView];
    [self prepare];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setupNavView {
    
    self.homeNav = [[HomeNavView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVIGATION_BAR_HEIGHT+STATUS_BAR_HEIGHT)];
    self.homeNav.backgroundAlpha = 0;
    [self.view addSubview:self.homeNav];
    
    self.naviView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, NAVIGATION_BAR_HEIGHT+STATUS_BAR_HEIGHT)];
    [self.view addSubview:self.naviView];
    
    //poper view controller
    UIButton *poperButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    poperButton.frame = CGRectMake(SCREENWIDTH-80, STATUS_BAR_HEIGHT, 40, 40);
    poperButton.showsTouchWhenHighlighted = YES;
    [poperButton addTarget:self action:@selector(poperView:) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:poperButton];
    
}

- (void)prepare {
    [self.view addSubview:self.scrollView];
}

- (void)topViewItemClick:(NSInteger)index {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        NSLog(@"请在iPhone的'设置-隐私-相机'选项中,允许APP访问你的相机");
        return;
    } else {
        ScanViewController *scanVc = [[ScanViewController alloc] init];
        [self.navigationController pushViewController:scanVc animated:YES];
    }
}

- (void)poperView:(UIButton *)sender {
    self.itemPopVC = [[PoperViewController alloc] init];
    self.itemPopVC.modalPresentationStyle = UIModalPresentationPopover;
    //rect参数是以view的左上角为坐标原点（0，0）
    self.itemPopVC.popoverPresentationController.sourceView = sender;
    //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    //popoverPresentationController.barButtonItem:箭头方向,如果是baritem不设置方向，会默认up，up的效果也是最理想的
    self.itemPopVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUnknown;
    self.itemPopVC.popoverPresentationController.delegate = self;
    __weak typeof(self)weakSelf = self;
    self.itemPopVC.poperSelectedBlock = ^(NSInteger index) {
        NSLog(@"%ld",index);//处理popover上的talbe的cell点击
        if (weakSelf.itemPopVC) {
            //我暂时使用这个方法让popover消失，但我觉得应该有更好的方法，因为这个方法并不会调用popover消失的时候会执行的回调。
            [weakSelf.itemPopVC dismissViewControllerAnimated:YES completion:nil];
            weakSelf.itemPopVC = nil;
        }
    };
    [self presentViewController:self.itemPopVC animated:YES completion:nil];
}

#pragma mark - delegate

//UIPopoverPresentationControllerDelegate,只有返回UIModalPresentationNone才可以让popover在手机上按照我们在preferredContentSize中返回的size显示。这是一个枚举，可以尝试换成其他的值尝试。
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    //no点击蒙版popover不消失， 默认yes
    return NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.topView.contentAlpha = 1-self.scrollView.contentOffset.y/100;
    self.naviView.backgroundAlpha = 1-self.scrollView.contentOffset.y/100;
    self.homeNav.backgroundAlpha = self.scrollView.contentOffset.y/100;
    if (self.scrollView.contentOffset.y>=100) {
        self.tableView.scrollEnabled = YES;
    } else {
        self.tableView.scrollEnabled = NO;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"home"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"home"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%d行",(int)indexPath.row];
    return cell;
}

#pragma mark - lazy

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+STATUS_BAR_HEIGHT, SCREENWIDTH, SCREENHEIGHT-NAVIGATION_BAR_HEIGHT-STATUS_BAR_HEIGHT-TAB_BAR_HEIGHT)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [_scrollView addSubview:self.topView];
        [_scrollView addSubview:self.tableView];
        _scrollView.contentSize = CGSizeMake(0, SCREENHEIGHT+100);
    }
    return _scrollView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREENWIDTH, SCREENHEIGHT)];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (HomeTopItemView *)topView {
    if (!_topView) {
        _topView = [[HomeTopItemView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
        __weak typeof(self)weakSelf = self;
        _topView.buttonClickBlock = ^(NSInteger index) {
            [weakSelf topViewItemClick:index];
        };
    }
    return _topView;
}

@end
