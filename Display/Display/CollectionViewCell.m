//
//  CollectionViewCell.m
//  ReadDemo
//
//  Created by lee on 16/12/1.
//  Copyright © 2016年 mjsfax. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;


@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitle:(NSString *)title {

    self.titleLab.text = title;
    
}

@end
