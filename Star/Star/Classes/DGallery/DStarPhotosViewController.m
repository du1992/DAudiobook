//
//  DStarPhotosViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DStarPhotosViewController.h"
#import "DPictureViewController.h"
#import "DPortraitViewController.h"

@interface DStarPhotosViewController ()

@end

@implementation DStarPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.view.backgroundColor=[UIColor lightGrayColor];
    [self setUpSubviews];
    self.view.backgroundColor=[UIColor whiteColor];
    
}

-(void)setUpSubviews
{
    
    //写真
    DPortraitViewController *portaitVC=[[DPortraitViewController alloc]init];
    portaitVC.title=@"写真";
    
    //现场
    DPortraitViewController *sceneVC=[[DPortraitViewController alloc]init];
    sceneVC.title=@"现场";
    
    //剧照
    DPortraitViewController *stillsVC=[[DPortraitViewController alloc]init];
    stillsVC.title=@"剧照";
    
    //壁纸
    DPortraitViewController *wallpaperVC=[[DPortraitViewController alloc]init];
    wallpaperVC.title=@"壁纸";
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
    //把四个控制视图添加到容器视图控制器上
    DContainerViewController *containerVC = [[DContainerViewController alloc]initWithControllers:@[portaitVC ,sceneVC,stillsVC,wallpaperVC] topBarHeight:statusHeight + navigationHeight  parentViewController:self];
    containerVC.delegate = self;
    [self.view addSubview:containerVC.view];
}

#pragma mark -- ContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    //让view要出现时开始加载数据
    [controller viewWillAppear:YES];
}

@end
