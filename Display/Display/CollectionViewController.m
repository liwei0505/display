//
//  CollectionViewController.m
//  ReadDemo
//
//  Created by lee on 16/12/1.
//  Copyright © 2016年 mjsfax. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "ReaderModel.h"

typedef NS_ENUM(NSInteger, ItemNumber) {
    ITEM_ONE = 0,
    ITEM_TOW = 1,
    ITEM_THREE = 2,
};

@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonnull, strong) UIPanGestureRecognizer *pan;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareUI];
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        ReaderModel *model = [[ReaderModel alloc] init];
        model.title = [NSString stringWithFormat:@"第%d个页面",i];
        [data addObject:model];
    }
    self.data = data;
    self.currentIndex = 0;
    self.collectionView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    
}

- (instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
}

#pragma mark - UI

- (void)prepareUI {
    self.collectionView.backgroundColor = [UIColor whiteColor];
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.pan = [[UIPanGestureRecognizer alloc] init];
    [self.collectionView addGestureRecognizer:self.pan];
    self.pan.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.pan) {
        CGPoint point = [self.pan velocityInView:self.collectionView];
        if (point.x > 0) {
            return YES;
        }else{
            NSIndexPath *indexpath = self.collectionView.indexPathsForVisibleItems.firstObject;
            ReaderModel *model = self.data[indexpath.item];
            if (model.isSelected) {
                if (self.collectionView.dragging && self.collectionView.decelerating) {
                    return NO;
                }else{
                    return YES;
                }
            } else {
                return NO;
            }
        }
    }
    return YES;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger indexLeft = (self.currentIndex + self.data.count - 1) % self.data.count;
    NSInteger indexRight = (self.currentIndex + 1) % self.data.count;
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (indexPath.row == ITEM_TOW) {
        cell.backgroundColor = [UIColor grayColor];
        ReaderModel *model = self.data[self.currentIndex];
        cell.title = model.title;
    } else if (indexPath.row == ITEM_THREE) {
        cell.backgroundColor = [UIColor blueColor];
        ReaderModel *model = self.data[indexRight];
        cell.title = model.title;
    } else if (indexPath.row == ITEM_ONE) {
        cell.backgroundColor = [UIColor orangeColor];
        ReaderModel *model = self.data[indexLeft];
        cell.title = model.title;
    }
    return cell;
}

#pragma mark <UICollectionViewDelegate>

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self performCycle];
}

#pragma mark - private
- (void)performCycle {
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    if (contentOffsetX > self.view.frame.size.width) {
        self.currentIndex = (self.currentIndex + 1) % self.data.count;
        self.collectionView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
//        NSLog(@"%ld",(long)self.currentIndex);
    } else if (contentOffsetX < self.view.frame.size.width) {
        self.currentIndex = (self.currentIndex + self.data.count - 1) % self.data.count;
//        NSLog(@"%ld",(long)self.currentIndex);
        self.collectionView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    }
    [self.collectionView reloadData];
}

@end
