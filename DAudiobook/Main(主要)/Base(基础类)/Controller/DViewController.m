//
//  DViewController.m
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/9.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import "DViewController.h"

@interface DViewController ()

@end

@implementation DViewController
//视图出现
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.indicatorAnimationView];
    [self.indicatorAnimationView resumeLayer];
    
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //网络状态返回
    self.indicatorAnimationView=[[DIndicatorView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth, 1)];
    [self.view addSubview:self.indicatorAnimationView];
    self.indicatorAnimationView.hidden=YES;
    self.count=12;
    
    
    
}
-(void)addBackItem{
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
}
-(void)backAction{
    
    if (self.navigationController.viewControllers.count > 1 ) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)addRightBarButtonItem:(UIImage *)rightImage{
      self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
    
}
-(void)rightItemClick{
    
}

- (NSMutableArray *)listArray {
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
