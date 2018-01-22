//
//  WaterLayoutController.m
//  Display
//
//  Created by lw on 2017/5/7.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "WaterFlowLayoutController.h"
#import "CollectionViewWaterFlowLayout.h"
#import "WaterLayoutCell.h"
#import "WaterLayoutModel.h"

@interface WaterFlowLayoutController ()<UICollectionViewDelegate, UICollectionViewDataSource, CollectionViewWaterFlowLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation WaterFlowLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CollectionViewWaterFlowLayout *waterLayout = [[CollectionViewWaterFlowLayout alloc] init];
    waterLayout.delegate = self;
//    waterLayout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 20);
//    waterLayout.footerReferenceSize = CGSizeMake(self.view.bounds.size.width, 20);

    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:waterLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[WaterLayoutCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
}

#pragma mark - datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WaterLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //cell.model = self.dataArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random_uniform(256)/255.0) green:(arc4random_uniform(256)/255.0) blue:(arc4random_uniform(256/255.0)) alpha:1.0];
    return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.backgroundColor = [UIColor redColor];
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.backgroundColor = [UIColor redColor];
        return view;
    }
    
}

#pragma mark - delegate

- (CGFloat)collectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {

    WaterLayoutModel *model = self.dataArray[indexPath.row];
    return model.h.doubleValue / model.w.doubleValue * itemWidth;
    
}

- (NSInteger)numberOfColumnInCollectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout {
    return 2;
}

- (CGFloat)columnMarginInCollectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout {
    return 5;
}

- (CGFloat)rowMarginInCollectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout {
    return 5;
}

- (UIEdgeInsets)edgeInsetsInCollectionViewWaterLayout:(CollectionViewWaterFlowLayout *)waterLayout {
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

#pragma mark - collection view flow layout delegate 

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeMake(self.view.bounds.size.width, 20);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeMake(self.view.bounds.size.width, 20);
//}

#pragma mark - private

- (NSMutableArray *)dataArray {

    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"1.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        _dataArray = [NSMutableArray array];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            WaterLayoutModel *model = [[WaterLayoutModel alloc] init];
            model.price = dic[@"price"];
            model.img = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494223878171&di=b2eb6cc437f789357e4b059132e31f39&imgtype=0&src=http%3A%2F%2Fwww.js10086.com%2Fuploads%2Fallimg%2F130729%2F1-130H91613200-L.jpg";
            //        dic[@"img"];
            model.w = dic[@"w"];
            model.h = dic[@"h"];
            [_dataArray addObject:model];
        }];
    }
    return [_dataArray copy];//建立一个不可变数组，外界无法修改，防止通过id其他方法修改数组内容
}


@end
