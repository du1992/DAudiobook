//
//  UIColor+ZN.h
//  Star
//
//  Created by JUNE_EN on 15/6/8.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZN)
+ (UIColor*) getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image;
@end
