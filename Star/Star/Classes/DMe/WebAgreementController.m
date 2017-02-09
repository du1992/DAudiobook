//
//  WWebAgreement Controller.m
//  kaoLa
//
//  Created by DUCHENGWEN on 2016/10/14.
//  Copyright © 2016年 kenneth. All rights reserved.
//

#import "WebAgreementController.h"

@interface WebAgreementController ()<UIWebViewDelegate>

@end

@implementation WebAgreementController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=NO;
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"用户协议";
    self.view.backgroundColor=[UIColor whiteColor];
  
   [self sendWebView];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
    
}
-(void)didClickedBack:(UIBarButtonItem *)item{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)sendWebView
{
    UIWebView * web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    web.delegate=self;
    web.scalesPageToFit=YES;
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"用户协议" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [web loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    [self.view addSubview:web];
    
}




@end
