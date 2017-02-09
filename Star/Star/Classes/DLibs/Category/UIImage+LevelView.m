//
//  DHeadView.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#define kLevelStar 32
#import "UIImage+LevelView.h"

@implementation UIImage (LevelView)

+ (UIImage *)levelViewWithLevelCount:(NSInteger)levelCount {
    
    
    UIView *levelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kLevelStar * 15, kLevelStar)];
    NSInteger crownCount = levelCount / 64;
    NSInteger sunCount = (levelCount - crownCount * 64) / 16;
    NSInteger moonCount = (levelCount - crownCount * 64 - sunCount * 16) / 4;
    NSInteger starCount = levelCount % 4;
    CGFloat y = 0;
    CGFloat w = kLevelStar;
    CGFloat h = kLevelStar;
    for (NSInteger i = 0; i < crownCount; i++) {
        UIImageView *crownImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usersummary_icon_lv_crown"]];
        CGFloat x = kLevelStar * i;
        crownImgView.frame = CGRectMake(x, y, w, h);
        [levelView addSubview:crownImgView];
    }
    for (NSInteger i = 0; i < sunCount; i++) {
        UIImageView *sunImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usersummary_icon_lv_sun"]];
        CGFloat x = kLevelStar * i + kLevelStar * crownCount;
        sunImgView.frame = CGRectMake(x, y, w, h);
        [levelView addSubview:sunImgView];
    }
    for (NSInteger i = 0; i < moonCount; i++) {
        UIImageView *moonImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usersummary_icon_lv_moon"]];
        CGFloat x = kLevelStar * i + kLevelStar * (sunCount + crownCount);
        moonImgView.frame = CGRectMake(x, y, w, h);
        [levelView addSubview:moonImgView];
    }
    for (NSInteger i = 0; i < starCount; i++) {
        UIImageView *starImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usersummary_icon_lv_star"]];
        CGFloat x = kLevelStar * i + kLevelStar * (moonCount + sunCount + crownCount);
        starImgView.frame = CGRectMake(x, y, w, h);
        [levelView addSubview:starImgView];
    }
    
    // 绘制图片
    UIGraphicsBeginImageContext(levelView.bounds.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [levelView.layer renderInContext:ctx];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
