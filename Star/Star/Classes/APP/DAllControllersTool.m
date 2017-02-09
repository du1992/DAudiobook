//
//  DAllControllersTool.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DAllControllersTool.h"
#import "DLeftMenuViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "DNavigationController.h"
#import "DHomeViewController.h"
#import "DStarPhotosViewController.h"
#import "DStarRankingViewController.h"
#import "MeViewController.h"
#import "DVideoPlayerViewController.h"
#import "DRadioViewController.h"

@interface DAllControllersTool ()
@property (nonatomic,strong) MMDrawerController *drawerController;
@property (nonatomic,strong) DLeftMenuViewController *menuController;

@end

@implementation DAllControllersTool

- (DLeftMenuViewController *)menuController
{
    if (!_menuController) {
        _menuController = [[DLeftMenuViewController alloc] init];
    }
    return _menuController;
}

- (MMDrawerController *)drawerController
{
    if (!_drawerController) {
        _drawerController = [[MMDrawerController alloc] init];
        _drawerController.showsShadow = YES;
        [_drawerController setMaximumLeftDrawerWidth:[UIScreen mainScreen].bounds.size.width * 0.75];
        [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [_drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            
            MMDrawerControllerDrawerVisualStateBlock block = [MMDrawerVisualState slideVisualStateBlock];
            if (block) {
                block(drawerController,drawerSide,percentVisible);
            }
        }];
        
        [_drawerController setLeftDrawerViewController:self.menuController];
    }
    
    return _drawerController;
}

#pragma mark -
#pragma mark - 调度方法
+ (void)createViewControllerWithIndex:(NSUInteger)index
{
    //获取当前类的(唯一)对象
    DAllControllersTool *dispatchTool = [DAllControllersTool shareOpenController];
    
    //用当前类的对象 执行实际选择执行的方法
    [dispatchTool openViewControllerWithIndex:index];
}


+ (instancetype)shareOpenController
{
    //获取到调度的唯一对象
    static DAllControllersTool *tempTool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tempTool = [[DAllControllersTool alloc] init];
    });
    
    return tempTool;
}


#pragma mark -
#pragma mark - 实际选择执行的方法
- (void)openViewControllerWithIndex:(NSUInteger)index
{
    
    switch (index) {
        case 0:
        {//第一次加载，加载[首页]界面
            
            static DNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                DVideoPlayerViewController *player=[[DVideoPlayerViewController alloc] init];
                navVC = [[DNavigationController alloc] initWithRootViewController:player];
                
                
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            
            break;
        case 1:
        {//第一次加载，加载[资讯]界面
            
            static DNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                DHomeViewController *homeVC = [[DHomeViewController alloc] init];
                navVC = [[DNavigationController alloc] initWithRootViewController:homeVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
            
            
        }
            break;
        case 2:
            //第一次加载，加载[排行]界面
        {
            static DNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                DStarRankingViewController *rankingVC = [[DStarRankingViewController alloc] init];
                navVC = [[DNavigationController alloc] initWithRootViewController:rankingVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 3:
            //第一次加载，加载[写真]界面
        {
            
            static DNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                DStarPhotosViewController *starVC = [[DStarPhotosViewController alloc] init];
                navVC = [[DNavigationController alloc] initWithRootViewController:starVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];

            
            
        }
            break;
        case 4:
            //第一次加载，加载[电台]页面 SPViewController
        {
            static DNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                DRadioViewController *rdVC = [[DRadioViewController alloc] init];
                navVC = [[DNavigationController alloc] initWithRootViewController:rdVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 5:
            //第一次加载，加载[设置]页面 LPViewController
        {
            static DNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                MeViewController *sqVC = [[MeViewController alloc] init];
                navVC = [[DNavigationController alloc] initWithRootViewController:sqVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;

        default:
            break;
    }
}


@end
