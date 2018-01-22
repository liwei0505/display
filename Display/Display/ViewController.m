//
//  ViewController.m
//  Display
//
//  Created by lee on 17/2/15.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "ViewController.h"
#import "PattenController.h"
#import "HeaderImageController.h"
#import "SkinViewController.h"
#import "MSScrollView.h"
#import "SubViewController1.h"
#import "WaterFlowLayoutController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
*/
    [self prepareUI];
    [self headerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tabBarController.selectedIndex == 0) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.tabBarController.selectedIndex == 0) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)prepareUI {

    self.navigationController.navigationBar.alpha = 0.0;
    self.automaticallyAdjustsScrollViewInsets = NO;//不设置tableview会下沉一块
    self.view.backgroundColor = [UIColor whiteColor];
    self.list = @[@"WaterFlow",@"PatternLock(UIButton)",@"BlurHeaderTableView",@"ChangeSkin",@"water-progressview"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44-64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
}

- (void)headerView {
    
    MSScrollView *headerView = [[MSScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 590.f / 1080.f)];
    headerView.bannerList = @[@"pic",@"pic-2",@"banner"];
    self.tableView.tableHeaderView = headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
    cell.textLabel.text = self.list[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: {
            WaterFlowLayoutController *waterFlow = [[WaterFlowLayoutController alloc] init];
            [self.navigationController pushViewController:waterFlow animated:YES];
            break;
        }
        case 1: {
            PattenController *pattern = [[PattenController alloc] init];
            [self.navigationController pushViewController:pattern animated:YES];
            break;
        }
        case 2: {
            HeaderImageController *blur = [[HeaderImageController alloc] init];
            [self.navigationController pushViewController:blur animated:YES];
            break;
        }
        case 3: {
            UIStoryboard *skin = [UIStoryboard storyboardWithName:@"skin" bundle:nil];
            SkinViewController *skinVC = [skin instantiateInitialViewController];
            [self.navigationController pushViewController:skinVC animated:YES];
            break;
        }
        case 4: {
            SubViewController1 *sub1 = [[SubViewController1 alloc] init];
            [self.navigationController pushViewController:sub1 animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    //干什么的？nav中
    return nil;//从子vc返回时调用
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
