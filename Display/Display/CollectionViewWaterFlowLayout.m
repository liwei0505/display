//
//  CollectionViewWaterLayout.m
//  Display
//
//  Created by lw on 2017/5/7.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "CollectionViewWaterFlowLayout.h"

const NSInteger MARGIN = 5;

@interface CollectionViewWaterFlowLayout()
@property (strong, nonatomic) NSMutableArray *attributesArray;
@property (strong, nonatomic) NSMutableArray *maxHeightArray;

- (NSInteger)columnNumber;
- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (UIEdgeInsets)edgeInsets;

@end

@implementation CollectionViewWaterFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    [self.attributesArray removeAllObjects];
    [self.maxHeightArray removeAllObjects];
    
    for (int i = 0; i < self.columnNumber; i++) {
        [self.maxHeightArray addObject:@0];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i=0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attributesArray addObject:attributes];
    }
    
    UICollectionViewLayoutAttributes *layoutHeader = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    layoutHeader.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    [self.attributesArray addObject:layoutHeader];
    
    UICollectionViewLayoutAttributes *layoutFooter = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    layoutHeader.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    [self.attributesArray addObject:layoutFooter];
}

#pragma mark - 自定义flowlayout重写以下方法

- (CGSize)collectionViewContentSize {
/*
    //返回大于或者等于指定表达式的最小整数
    int rowItems = 2;
    CGFloat height = ceil([self.collectionView numberOfItemsInSection:0]/rowItems) * [UIScreen mainScreen].bounds.size.width * 0.5;
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, height);//contentsize总大小
*/
    CGFloat maxColumnHeight = [self.maxHeightArray[0] doubleValue];
    for (NSInteger i = 1; i < self.maxHeightArray.count; i++) {
        if ([self.maxHeightArray[i] doubleValue] > maxColumnHeight) {
            maxColumnHeight = [self.maxHeightArray[i] doubleValue];
        }
    }
    return CGSizeMake(0, maxColumnHeight + self.edgeInsets.bottom + self.edgeInsets.top);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;//自定义布局必须YES
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //返回所有cell的布局属性
/* 参考
 NSArray *array = [super layoutAttributesForElementsInRect:rect];
 NSMutableArray* attributes = [NSMutableArray array];
 for (NSInteger i=0 ; i < [array count]; i++) {
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
    [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
 }
 return attributes;
 */
    return self.attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    //返回每个cell的布局属性
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger minColumn = 0;
    CGFloat minColumnHeight = [self.maxHeightArray[0] doubleValue];
    for (NSInteger i = 1; i<self.maxHeightArray.count; i++) {
        if ([self.maxHeightArray[i] doubleValue] < minColumnHeight) {
            minColumnHeight = [self.maxHeightArray[i] doubleValue];
            minColumn = i;
        }
    }
    
    CGFloat w = (self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right - (self.columnNumber - 1)*self.columnMargin) / self.columnNumber;
    CGFloat h = [self.delegate collectionViewWaterLayout:self heightForItemAtIndexPath:indexPath itemWidth:w];
    CGFloat x = self.edgeInsets.left + minColumn * (w + self.columnMargin);
    CGFloat y = 0;
    
    if (minColumnHeight == 0) {
        y = self.edgeInsets.top;
        self.maxHeightArray[minColumn] = @(h);
    } else {
        y = self.edgeInsets.top + minColumnHeight + self.rowMargin;
        self.maxHeightArray[minColumn] = @(h + minColumnHeight + self.rowMargin);
    }
    attributes.frame = CGRectMake(x, y, w, h);
    return attributes;
    
}

#pragma mark - private

- (NSInteger)columnNumber {

    if ([self.delegate respondsToSelector:@selector(numberOfColumnInCollectionViewWaterLayout:)]) {
        return [self.delegate numberOfColumnInCollectionViewWaterLayout:self];
    } else {
        return 2;
    }
}

- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginInCollectionViewWaterLayout:)]) {
        return [self.delegate rowMarginInCollectionViewWaterLayout:self];
    } else {
        return MARGIN;
    }
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginInCollectionViewWaterLayout:)]) {
        return [self.delegate columnMarginInCollectionViewWaterLayout:self];
    } else {
        return MARGIN;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInCollectionViewWaterLayout:)]) {
        return [self.delegate edgeInsetsInCollectionViewWaterLayout:self];
    } else {
        return UIEdgeInsetsMake(MARGIN, 0, MARGIN, 0);
    }
}

- (NSMutableArray *)attributesArray {

    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (NSMutableArray *)maxHeightArray {

    if (!_maxHeightArray) {
        _maxHeightArray = [NSMutableArray array];
    }
    return _maxHeightArray;
}

@end
