//
//  DTabBarController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DTabBarController.h"
#import "DHomeViewController.h"
#import "DStarPhotosViewController.h"
#import "DStarRankingViewController.h"
#import "MeViewController.h"
#import "DNavigationController.h"

@interface DTabBarController ()

@end

@implementation DTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化所有子控件
    [self setupAllChildViewController];
    self.selectedIndex=0;
    
}

//初始化所有控制器
-(void)setupAllChildViewController{
    DHomeViewController *hots=[[DHomeViewController alloc] init];
    [self setupChildViewController:hots title:@"热点" imageName:@"热点" selectedImage:@"热点1"];
    
    
    DStarPhotosViewController *photos=[[DStarPhotosViewController alloc] init];
    [self setupChildViewController:photos title:@"图库" imageName:@"壁纸" selectedImage:@"壁纸1"];
    
    DStarRankingViewController *ranking=[[DStarRankingViewController alloc] init];
    [self setupChildViewController:ranking title:@"排名" imageName:@"排名" selectedImage:@"排名1"];
    
    MeViewController *me=[[MeViewController alloc] init];
    [self setupChildViewController:me title:@"设置" imageName:@"设置" selectedImage:@"设置1"];
}

//设置控制器一些--
- (void)setupChildViewController:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImage:(NSString *)selectedImage{
    childVC.title=title;
    if (nil != imageName) {
        childVC.tabBarItem.image=[UIImage imageNamed:imageName];
    }
    if(nil !=selectedImage){
        UIImage *selImage=[UIImage imageNamed:selectedImage];
        childVC.tabBarItem.selectedImage=[selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    DNavigationController *nav=[[DNavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

@end
