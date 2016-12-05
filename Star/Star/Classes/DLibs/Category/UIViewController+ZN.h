//
//  UIViewController+ZN.h
//  Star
//
//  Created by JUNE_EN on 15/5/31.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZN)
-(void)viewFirstLoad;
#pragma mark 封装异步加载请求
-(void)dispathLoad:(void (^)())block mainQueue:(void (^)())mainBlock;
@end
