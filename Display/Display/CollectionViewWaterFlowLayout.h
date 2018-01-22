//
//  CollectionViewWaterLayout.h
//  Display
//
//  Created by lw on 2017/5/7.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CollectionViewWaterFlowLayout;
@protocol CollectionViewWaterFlowLayoutDelegate <NSObject>

@required
- (CGFloat)collectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@optional
- (NSInteger)numberOfColumnInCollectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout;
- (CGFloat)columnMarginInCollectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout;
- (CGFloat)rowMarginInCollectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout;
- (UIEdgeInsets)edgeInsetsInCollectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout;

@end

@interface CollectionViewWaterFlowLayout : UICollectionViewFlowLayout
@property(weak, nonatomic) id<CollectionViewWaterFlowLayoutDelegate> delegate;
@end
