//
//  PlainFlowLayout.m
//  Display
//
//  Created by lee on 2017/5/10.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "CollectionViewPlainFlowLayout.h"

@implementation CollectionViewPlainFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        self.topMargin = 64.0;
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *superArray = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSMutableIndexSet *noneHeaderSections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *attribut in superArray) {
        if (attribut.representedElementCategory == UICollectionElementCategoryCell) {
            [noneHeaderSections addIndex:attribut.indexPath.section];
        }
    }
    
    for (UICollectionViewLayoutAttributes *attribute in superArray) {
        if ([attribute.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            [noneHeaderSections removeIndex:attribute.indexPath.section];
        }
    }
    
    [noneHeaderSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (attribute) {
            [superArray addObject:attribute];
        }
    }];
    
    for (UICollectionViewLayoutAttributes *attribute in superArray) {
        if ([attribute.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            NSInteger numberOfItemsInSection = [self.collectionView numberOfItemsInSection:attribute.indexPath.section];
            NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attribute.indexPath.section];
            NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemsInSection-1) inSection:attribute.indexPath.section];
            UICollectionViewLayoutAttributes *firstItemAttribute, *lastItemAttribute;
            if (numberOfItemsInSection > 0) {
                firstItemAttribute = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                lastItemAttribute = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
            } else {
                firstItemAttribute = [UICollectionViewLayoutAttributes new];
                CGFloat y = CGRectGetMaxY(attribute.frame) + self.sectionInset.top;
                firstItemAttribute.frame = CGRectMake(0, y, 0, 0);
                lastItemAttribute = firstItemAttribute;
            }
            
            CGRect rect = attribute.frame;
            
            /**
             *     算法
             */
            //当前的滑动距离 + 因为导航栏产生的偏移量，默认为64（如果app需求不同，需自己设置）
            CGFloat offset = self.collectionView.contentOffset.y + self.topMargin;
            //第一个cell的y值 - 当前header的高度 - 可能存在的sectionInset的top
            CGFloat headerY = firstItemAttribute.frame.origin.y - rect.size.height - self.sectionInset.top;
            
            //哪个大取哪个，保证header悬停
            //针对当前header基本上都是offset更加大，针对下一个header则会是headerY大，各自处理
            CGFloat maxY = MAX(offset,headerY);
            
            //最后一个cell的y值 + 最后一个cell的高度 + 可能存在的sectionInset的bottom - 当前header的高度
            //当当前section的footer或者下一个section的header接触到当前header的底部，计算出的headerMissingY即为有效值
            CGFloat headerMissingY = CGRectGetMaxY(lastItemAttribute.frame) + self.sectionInset.bottom - rect.size.height;
            
            //给rect的y赋新值，因为在最后消失的临界点要跟谁消失，所以取小
            rect.origin.y = MIN(maxY,headerMissingY);
            //给header的结构信息的frame重新赋值
            attribute.frame = rect;
            
            //如果按照正常情况下,header离开屏幕被系统回收，而header的层次关系又与cell相等，如果不去理会，会出现cell在header上面的情况
            //通过打印可以知道cell的层次关系zIndex数值为0，我们可以将header的zIndex设置成1，如果不放心，也可以将它设置成非常大，这里随便填了个7
            attribute.zIndex = 7;
            
        }
    }
    return [superArray copy];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
