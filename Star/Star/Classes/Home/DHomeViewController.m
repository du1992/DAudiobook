//
//  DHomeViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//   首页

#import "DHomeViewController.h"
#import "DContainerViewController.h"
#import "DNewestViewController.h"
#import "DOtherViewController.h"
#import "UIViewController+ZN.h"
@interface DHomeViewController ()<DContainerViewControllerDelegate>

@end

@implementation DHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    DNewestViewController *hots = [[DNewestViewController alloc] init];
    hots.title = @"最新";
    
    DOtherViewController *gossip = [[DOtherViewController alloc] init];
    gossip.title = @"爆料";
   
    
    DOtherViewController *secrets = [[DOtherViewController alloc] init];
    secrets.title = @"秘闻";
    
    
    DOtherViewController *peach = [[DOtherViewController alloc] init];
    peach.title = @"八卦";
   
    
    DOtherViewController *carnatio = [[DOtherViewController alloc] init];
    carnatio.title = @"娱乐";
    
    
    DOtherViewController *black = [[DOtherViewController alloc] init];
    black.title = @"黑色";
    
    
    
    // ContainerView
    float statusHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = self.navigationController.navigationBar.frame.size.height;
   
    DContainerViewController *containerVC = [[DContainerViewController alloc]initWithControllers:@[hots,gossip,secrets,peach,carnatio,black] topBarHeight:statusHeight + navigationHeight  parentViewController:self];
    containerVC.delegate = self;
   [self.view addSubview:containerVC.view];
    
    
}

#pragma mark -- ContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    [controller viewWillAppear:YES];
    [controller viewFirstLoad];
}

@end
