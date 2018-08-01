//
//  SubViewController1.m
//  Display
//
//  Created by lee on 17/4/14.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "SubViewController1.h"
#import "WaterRipple.h"
#import "ProgressView.h"
#import "Sub1ViewCell.h"

static NSString *reuseId = @"Sub1ViewCell";

@interface SubViewController1 ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) WaterRipple *water;
@property (strong, nonatomic) UIView *waterTop;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation SubViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
    
    NSArray *arr = @[@(13.000),@(13.943),@(13.099),@(99.000),@(99.345),@(99.789),@(100.000)];
    for (NSNumber *progress in arr) {
        NSLog(@"old===%@====new===%@",progress.stringValue,[NSString stringWithFormat:@"%.1f",floor(progress.doubleValue*10)/10]);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)prepare {

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.alwaysBounceVertical = YES;
    //self.scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.waterTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.waterTop.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:self.waterTop];
    
    self.water = [[WaterRipple alloc] initWithFrame:CGRectMake(0, 45, self.view.bounds.size.width, 5)];
    [self.scrollView addSubview:self.water];
    [self.water startAnimation];
    
    ProgressView *progressView = [[ProgressView alloc] initWithFrame:CGRectMake(20, 55, self.view.bounds.size.width-50, 20)];
    [self.scrollView addSubview:progressView];
    progressView.progress = 50;
    
    [self.scrollView addSubview:self.tableView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.water stopAnimation];
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Sub1ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId forIndexPath:indexPath];
    cell.progress = [self.dataArray[indexPath.row] doubleValue];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat contentOffsetY = scrollView.contentOffset.y+64;
//    NSLog(@"====%f",scrollView.contentOffset.y);
    if (contentOffsetY < 0) {
        //[scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
        CGFloat scale = -contentOffsetY/100.0 ;
        scale = scale >= 1 ? 1 : scale;
        self.waterTop.backgroundColor = [UIColor colorWithRed:255/256.0 green:0/256.0 blue:0/256.0 alpha:scale];
    } else {
        self.waterTop.backgroundColor = [UIColor redColor];
    }
}

#pragma mark - private

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height-50) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[Sub1ViewCell class] forCellReuseIdentifier:reuseId];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {//0-20 间隔0.2
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        for (int i = 0; i < 100; i++) {
            [_dataArray addObject:@(0.2 * i)];
        }
    }
    return _dataArray;
}

@end
