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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSMutableArray *result;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
*/
    [self prepareUI];
//    [self headerView];
    [self searchView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:!self.tabBarController.selectedIndex];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:self.tabBarController.selectedIndex];
}

- (void)prepareUI {

//    self.navigationController.navigationBar.alpha = 0.0;
//    self.automaticallyAdjustsScrollViewInsets = NO;//不设置tableview会下沉一块
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

- (void)headerView {
    MSScrollView *headerView = [[MSScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 590.f / 1080.f)];
    headerView.bannerList = @[@"pic",@"pic-2",@"banner"];
    self.tableView.tableHeaderView = headerView;
}

- (void)searchView {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

#pragma mark - delegate
//被电击高亮之前就调用
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return nil;
    }
    return indexPath;
}

//指定缩进某些行
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return self.result.count;
    }
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.searchController.active) {
        cell.textLabel.text = self.result[indexPath.row];
    } else {
        cell.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:15];
        cell.textLabel.text = self.list[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.searchController.active) {
        return;
    }
    
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
        case 5: {
            UISearchController *s = [[UISearchController alloc] init];
            [self.navigationController pushViewController:s animated:YES];
            return;
        }
            
        default:
            break;
    }
}

#pragma mark - searchBar
//自定义导航栏需要自己实现隐藏导航栏的动画效果 利用这两个代理方法实现

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}

#pragma mark - searchContoller

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *inputS = searchController.searchBar.text;
    if (self.result.count) {
        [self.result removeAllObjects];
    }
    /*
    for (NSString *str in self.list) {
        if ([str.lowercaseString rangeOfString:inputS.lowercaseString].location != NSNotFound) {
            [self.result addObject:str];
        }
    }
     */
    
    /**/
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSRange range = [evaluatedObject rangeOfString:searchController.searchBar.text options:NSCaseInsensitiveSearch];
        return range.location != NSNotFound;
    }];
    for (NSString *str in self.list) {
        NSArray *matches = [self.list filteredArrayUsingPredicate:predicate];
        [self.result addObjectsFromArray:matches];
    }
    
    [self.tableView reloadData];
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    //干什么的？nav中
    return nil;//从子vc返回时调用
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - lazy

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSMutableArray *)result {
    if (!_result) {
        _result = [NSMutableArray array];
    }
    return _result;
}

- (NSArray *)list {
    if (!_list) {
        _list = @[@"WaterFlow",@"PatternLock(UIButton)",@"BlurHeaderTableView",@"ChangeSkin",@"water-progressview",@"searchController"];
    }
    return _list;
}

@end
