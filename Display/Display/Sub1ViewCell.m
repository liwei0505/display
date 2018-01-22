//
//  Sub1ViewCell.m
//  Display
//
//  Created by lw on 17/4/16.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "Sub1ViewCell.h"
#import "ProgressView2.h"

@interface Sub1ViewCell()
@property (strong, nonatomic) ProgressView2 *progressView;
@end
@implementation Sub1ViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.progressView = [[ProgressView2 alloc] initWithFrame:CGRectMake(20, (self.frame.size.height-3)/2.0, self.frame.size.width-40, 20)];
        self.progressView.progressViewType = ProgressViewType_showPreogressButton;
        [self.contentView addSubview:self.progressView];
    }
    return self;
}

+ (Sub1ViewCell *)cellWithTableView:(UITableView *)tableView {

    NSString *reuseId = @"Sub1ViewCell";
    Sub1ViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[Sub1ViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    }
    return cell;
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.progressView.progress = progress;
}

@end
