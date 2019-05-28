//
//  DNavigationController.m
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/9.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import "DNavigationController.h"

@implementation DNavigationController

- (void)viewDidLoad
{
    //=============================自定义返回按钮，开启原生滑动返回功能
    WEAKSELF
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
        self.delegate = (id)weakSelf;
    }
    //=============================
    [self setItems];
}
-(void)setItems
{

    //动态更改导航背景 / 样式
    //开启编辑
    UINavigationBar *bar = [UINavigationBar appearance];
    //设置导航条背景颜色
    [bar setBarTintColor:ImportantColor];
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
//==========================================================滑动返回卡住问题解决
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES)
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES)
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToRootViewControllerAnimated:animated];
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    return [super popToViewController:viewController animated:animated];
}
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate
{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}
#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer)
    {
        if (self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0])
        {
            return NO;
        }
    }
    return YES;
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
