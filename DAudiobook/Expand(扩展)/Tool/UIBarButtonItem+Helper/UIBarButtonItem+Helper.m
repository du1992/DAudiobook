//
//  UIBarButtonItem+Helper.m
//  图吧导航1号
//
//  Created by Mr.Psychosis on 14/9/11.
//  Copyright (c) 2014年 Frank. All rights reserved.
//

#import "UIBarButtonItem+Helper.h"

@implementation UIBarButtonItem (Helper)

// 设置图片按钮,normal:常规图片，highlighted:高亮图片
- (id)initWithNormalIcon:(NSString *)normal highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action {
    UIImage *image = [UIImage imageNamed:normal];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    if (highlighted) {
        [btn setBackgroundImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    }
    btn.bounds = (CGRect){CGPointZero, image.size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [self initWithCustomView:btn];
}

+ (id)itemWithNormalIcon:(NSString *)normal highlightedIcon:(NSString *)highlighted target:(id)target action:(SEL)action {
    return [[self alloc] initWithNormalIcon:normal highlightedIcon:highlighted target:target action:action];
}

// 设置文字按钮，默认文字颜色：高亮颜色：
- (id)initWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [self initWithTitle:title normalColor:NormalColor highlightedColor:HighlightedColor target:target action:action];
}

+ (id)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title target:target action:action];
}

// 设置文字按钮, backgroundImage:背景图片，normal：常规颜色 Highlighted：高亮颜色
- (id)initWithTitle:(NSString *)title backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)action {
    return [self initWithTitle:title backgroundImage:backImage normalColor:NormalColor highlightedColor:HighlightedColor target:target action:action];
}

+ (id)itemWithTitle:(NSString *)title backgroundImage:(UIImage *)backImage target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title backgroundImage:backImage target:target action:action];
}

// 设置文字按钮，normal：常规颜色 Highlighted：高亮颜色
+ (id)itemWithTitle:(NSString *)title normalColor:(UIColor *)normal highlightedColor:(UIColor *)highlighted target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title backgroundImage:[UIImage new] normalColor:normal highlightedColor:highlighted target:target action:action];
}

- (id)initWithTitle:(NSString *)title normalColor:(UIColor *)normal highlightedColor:(UIColor *)highlighted target:(id)target action:(SEL)action {
    return [self initWithTitle:title backgroundImage:[UIImage new] normalColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor] target:target action:action];
}

// 设置文字按钮，backgroundImage:背景图片 normal：常规颜色 Highlighted：高亮颜色
+ (id)itemWithTitle:(NSString *)title backgroundImage:(UIImage *)backImage normalColor:(UIColor *)normal highlightedColor:(UIColor *)highlighted target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title backgroundImage:backImage normalColor:normal highlightedColor:highlighted target:target action:action];
}

- (id)initWithTitle:(NSString *)title backgroundImage:(UIImage *)backImage normalColor:(UIColor *)normal highlightedColor:(UIColor *)highlighted target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:normal forState:UIControlStateNormal];
    [btn setTitleColor:highlighted forState:UIControlStateHighlighted];
    [btn setBackgroundImage:backImage forState:UIControlStateNormal];
    [btn setBackgroundImage:backImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
    if (CGSizeEqualToSize(backImage.size, CGSizeZero)) {
        CGSize size = [btn.titleLabel sizeThatFits:CGSizeMake(100, 44)];
        btn.frame = CGRectMake(0, 0, size.width, size.height);
    }else {
        btn.frame = CGRectMake(0, 0, backImage.size.width, backImage.size.height);
    }

    return [self initWithCustomView:btn];
}

@end
