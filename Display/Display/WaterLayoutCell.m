//
//  WaterLayoutCell.m
//  Display
//
//  Created by lw on 2017/5/7.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "WaterLayoutCell.h"
#import "UIImageView+WebCache.h"

@interface WaterLayoutCell()
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation WaterLayoutCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}

- (void)setModel:(WaterLayoutModel *)model {

    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    
}

@end
