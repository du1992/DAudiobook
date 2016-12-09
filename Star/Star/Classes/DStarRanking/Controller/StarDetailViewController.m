//
//  StarDetailViewController.m
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarDetailViewController.h"
#import "StarDetailTool.h"
#import "Macro.h"
@interface StarDetailViewController ()<UIWebViewDelegate>
@end

@implementation StarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
   __block UIWebView *webView=[[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.delegate=self;
    [self.view addSubview: webView];
    
    __block NSString *htmlStr=nil;

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        htmlStr=[StarDetailTool starDetail:self.linkUrl];
        if(htmlStr !=nil){
            dispatch_async(dispatch_get_main_queue(), ^{
                [webView loadHTMLString:htmlStr baseURL:nil];
//                [GMDCircleLoader hideFromView:self.view animated:YES];
            });
        }
        
    });
    webView.backgroundColor=[UIColor whiteColor];
    webView.autoresizesSubviews = YES;//自动调整大小
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)didClickedBack:(UIBarButtonItem *)item{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
