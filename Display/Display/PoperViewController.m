//
//  PoperViewController.m
//  Display
//
//  Created by lee on 2017/6/14.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "PoperViewController.h"

@interface PoperViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *colorArray;
@end

@implementation PoperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepare];
}

- (void)prepare {

    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.colorArray = [[NSMutableArray alloc] initWithObjects:@"green",@"gray", @"blue",@"purple", @"yellow", nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.poperSelectedBlock) {
        self.poperSelectedBlock(indexPath.row);
    }
}

//重写preferredContentSize（iOS7之后）来返回最合适的大小，如果不重写，会返回一整个tableview尽管下面一部分cell是没有内容的，重写后只会返回有内容的部分，我这里还修改了宽，让它窄一点。可以尝试注释这一部分的代码来看效果，通过修改返回的size得到你期望的popover的大小。
- (CGSize)preferredContentSize {

    if (self.presentingViewController && self.tableView != nil) {
        CGSize tempSize = self.presentingViewController.view.bounds.size;
        tempSize.width = 150;
        //sizeThatFits返回的是最合适的尺寸，但不会改变控件的大小
        CGSize size = [self.tableView sizeThatFits:tempSize];
        return size;
    }else {
        return [super preferredContentSize];
    }

}

- (void)setPreferredContentSize:(CGSize)preferredContentSize {
    super.preferredContentSize = preferredContentSize;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colorArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.colorArray[indexPath.row];
    return cell;
}



@end
