//
//  SkinUtils.m
//  Display
//
//  Created by lee on 17/2/16.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "SkinUtils.h"

static NSString *kSkinColor = @"skin_color";

@interface SkinUtils()

@end

@implementation SkinUtils

static NSString *_color;

- (instancetype)init {

    if (self = [super init]) {
        _color = [[NSUserDefaults standardUserDefaults] objectForKey:kSkinColor];
        if (!_color) {
            _color = @"blue";
        }
    }
    return self;
}

+ (void)setSkinColor:(NSString *)color {

    _color = color;
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:kSkinColor];

}

+ (UIImage *)skinWithImageName:(NSString *)name {
    
    NSString *imageName = [NSString stringWithFormat:@"skin/%@/%@", _color, name];
    return [UIImage imageNamed:imageName];
    
}

+ (UIColor *)skinLabelBackgroundColor {
    
    //获取配置plist文件
    NSString *filePath = [NSString stringWithFormat:@"skin/%@/bgColor.plist",_color];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:filePath ofType:nil];
    NSDictionary *colorDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSString *bgStr = colorDict[@"label_color"];
    //截取颜色rgb
    NSArray *bgArray = [bgStr componentsSeparatedByString:@","];
    CGFloat red = [bgArray[0] floatValue];
    CGFloat green = [bgArray[1] floatValue];
    CGFloat blue = [bgArray[2] floatValue];
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}


@end
