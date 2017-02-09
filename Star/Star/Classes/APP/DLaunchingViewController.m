//
//  DLaunchingViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/9.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DLaunchingViewController.h"
#import "DAllControllersTool.h"

@interface DLaunchingViewController ()
@property (nonatomic,strong) UIImageView *launchingBackgroundImageView;
@property (nonatomic,strong) NSTimer *launchingTimer;
@end

@implementation DLaunchingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载背景（默认系统的图片）
    [self.view addSubview:self.launchingBackgroundImageView];
//    _launchingBackgroundImageView.image=[UIImage imageNamed:@"one"];
    [_launchingBackgroundImageView setImage:[UIImage imageNamed:@"2012"]];
    
    
  
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //让背景动起来，先加载完毕，将要出现的时候再执行动画
    
    //设置动画效果
    [UIView animateWithDuration:3.0 animations:^{
        
        CGRect rect = self.launchingBackgroundImageView.frame;
        rect.origin = CGPointMake(-100, -100);
        rect.size = CGSizeMake(rect.size.width + 200, rect.size.height + 200);
        _launchingBackgroundImageView.frame = rect;
        
    } completion:^(BOOL finished) {
        
        //动画结束之后直接进入良品界面
        [DAllControllersTool createViewControllerWithIndex:0];
    }];
    
    
}
#pragma mark - 懒加载
/**
 *  背景图
 */
- (UIImageView *)launchingBackgroundImageView
{
    if (!_launchingBackgroundImageView) {
        _launchingBackgroundImageView = [[UIImageView alloc] init];
        [_launchingBackgroundImageView setFrame:self.view.frame];
        [_launchingBackgroundImageView setBackgroundColor:[UIColor cyanColor]];
      
    }
    return _launchingBackgroundImageView;
}


@end
