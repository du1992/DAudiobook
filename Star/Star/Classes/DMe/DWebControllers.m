//
//  DWebController.m
//  D_notebook
//
//  Created by DUCHENGWEN on 2016/12/22.
//  Copyright © 2016年 DCW. All rights reserved.
//

#import "DWebControllers.h"
#import "Macro.h"
@interface DWebControllers ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView*web;
@end

@implementation DWebControllers

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的作品";
    _web=[[UIWebView alloc]initWithFrame:CGRectMake(0,-50,WIDTH, HEIGHT+50)];
    _web.backgroundColor=[UIColor whiteColor];
    [_web setUserInteractionEnabled:YES];//是否支持交互
    _web.delegate=self;
    [_web setOpaque:NO];//opaque是不透明的意思
    [_web setScalesPageToFit:YES];//自动缩放以适应屏幕
    NSURLRequest*url=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://kevindcw.github.io/portfolio/index.html"]];
    [_web loadRequest:url];
    [self.view addSubview:_web];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
    
}
-(void)didClickedBack:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.view showLoadingMeg:kNetWorkLoadingMessage];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.view hideLoading];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.view showLoadingMeg:kNetWorkError time:kDefaultShowTime];
}



@end
