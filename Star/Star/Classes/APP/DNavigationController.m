//
//  DNavigationController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DNavigationController.h"
#import "UIBarButtonItem+ZN.h"
#import "UIBarButtonItem+Helper.h"
#import "Macro.h"
@interface DNavigationController ()

@end

@implementation DNavigationController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    //动态更改导航背景 / 样式
    //开启编辑
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置导航条背景颜色
    [bar setBarTintColor:RGBA_COLOR(39, 184, 232, 1)];
    //设置字体颜色
    [bar setTintColor:[UIColor whiteColor]];
    //设置样式
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor whiteColor],
                                  NSFontAttributeName : [UIFont boldSystemFontOfSize:14]
                                  }];
    
    //设置导航条按钮样式
    //开启编辑
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置样式
    [item setTitleTextAttributes:@{
                                   NSForegroundColorAttributeName : [UIColor whiteColor],
                                   NSFontAttributeName : [UIFont boldSystemFontOfSize:14]
                                   } forState:UIControlStateNormal];
}

/**
 *  更改状态栏颜色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


//设置状态栏是否隐藏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}







@end
