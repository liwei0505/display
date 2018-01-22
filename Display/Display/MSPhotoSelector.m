//
//  MSPhotoSelector.m
//  Display
//
//  Created by lee on 2017/5/31.
//  Copyright © 2017年 mjsfax. All rights reserved.
//

#import "MSPhotoSelector.h"
#define imageH 100
#define kMaxColumn 3
#define MaxImageCount 9

@interface MSPhotoSelector()<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSInteger editTag;//标识被编辑的按钮:-1为点击添加新的按钮 否则为已添加的按钮的tag
}
@property (strong, nonatomic) NSMutableArray *images;
@end

@implementation MSPhotoSelector

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [self createButtonWithImage:[UIImage imageNamed:@""] selector:@selector(addNewButton:)];
        [self addSubview:btn];
    }
    return self;
}

- (void)addNewButton:(UIButton *)btn {
    
    //添加新图片
    if (![self deleteClose:btn]) {
        editTag = -1;
        [self callImagePicker];
    }
}


- (UIButton *)createButtonWithImage:(UIImage *)image selector:(SEL)selector {

    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor redColor];
    [addBtn setImage:image forState:UIControlStateNormal];
    [addBtn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = self.subviews.count;
    
    if (addBtn.tag != 0) {
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [addBtn addGestureRecognizer:gesture];
    }
    return addBtn;
}

- (void)longPress:(UIGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        UIButton *btn = (UIButton *)gesture.view;
        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
        delete.bounds = CGRectMake(0, 0, 25, 25);
        delete.backgroundColor = [UIColor yellowColor];
        [delete setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [delete addTarget:self action:@selector(deletePicture:) forControlEvents:UIControlEventTouchUpInside];
        delete.frame = CGRectMake(btn.frame.size.width-delete.frame.size.width, 0, delete.frame.size.width, delete.frame.size.height);
        [btn addSubview:delete];
        [self start:btn];
    }

}


- (BOOL)deleteClose:(UIButton *)btn {

    if (btn.subviews.count == 2) {
        [[btn.subviews lastObject] removeFromSuperview];
        [self stop:btn];
        return YES;
    }
    return NO;
}

- (void)start:(UIButton *)btn {

    double angle1 = -5.0/180.0*M_PI;
    double angle2 = 5.0/180.0*M_PI;
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle1),@(angle2),@(angle1)];
    anim.duration = 0.25;
    anim.repeatCount = MAXFLOAT;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    [btn.layer addAnimation:anim forKey:@"shake"];
    
}

- (void)stop:(UIButton *)btn {

    [btn.layer removeAnimationForKey:@"shake"];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    int maxColumn = kMaxColumn > self.frame.size.width / imageH ? self.frame.size.width/imageH : kMaxColumn;
    CGFloat margin = (self.frame.size.width - maxColumn * imageH)/(count+1);
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i];
        CGFloat x = (i%maxColumn)*(margin+imageH)+margin;
        CGFloat y = (i/maxColumn)*(margin+imageH)+margin;
        btn.frame = CGRectMake(x, y, imageH, imageH);
    }
    
}

- (void)deletePicture:(UIButton *)btn {

    UIImage *image = [(UIButton *)btn.superview imageForState:UIControlStateNormal];
    [self.images removeObject:image];
    [btn.superview removeFromSuperview];
    if ([[self.subviews lastObject] isHidden]) {
        [[self.subviews lastObject] setHidden:NO];
    }
    
}

- (void)callImagePicker {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    [self.window.rootViewController presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    if (editTag == -1) {
        UIButton *btn = [self createButtonWithImage:image selector:@selector(changeOld:)];
        btn.backgroundColor = [UIColor blueColor];
        [self insertSubview:btn atIndex:self.subviews.count-1];
        [self.images addObject:image];
        if (self.subviews.count-1 == MaxImageCount) {
            [[self.subviews lastObject] setHidden:YES];
        }
    } else {
    
        UIButton *btn = (UIButton *)[self viewWithTag:editTag];
        NSInteger index = [self.images indexOfObject:[btn imageForState:UIControlStateNormal]];
        [self.images removeObjectAtIndex:index];
        [btn setImage:image forState:UIControlStateNormal];
        [self.images insertObject:image atIndex:index];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeOld:(UIButton *)btn {

    if (![self deleteClose:btn]) {
        editTag = btn.tag;
        [self callImagePicker];
    }
}

- (NSMutableArray *)images {

    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}


@end
