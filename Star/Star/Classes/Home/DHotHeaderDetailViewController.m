//
//  StarDetailViewController.m
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "DHotHeaderDetailViewController.h"
#import "StarDetailTool.h"
#import "DHotsHeaderOtherTool.h"
#import "Macro.h"

@interface DHotHeaderDetailViewController ()
@property (nonatomic,assign) int number;
@property (nonatomic,weak) UIWebView *webView;
@property (nonatomic,copy) __block NSString *htmlStr;
@end

@implementation DHotHeaderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _number=1;
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedBack:)];
   __block UIWebView *webView=[[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview: webView];
    webView.backgroundColor=[UIColor whiteColor];
    webView.autoresizesSubviews = YES;//自动调整大小
    self.webView=webView;
    [self webViewRequest];
    
}


- (void)webViewRequest {
    __unsafe_unretained typeof(self) selfVC=self;
//    [GMDCircleLoader hideFromView:self.view animated:YES];
    if (self.number==1) {
//        [GMDCircleLoader setOnView:self.view withTitle:@"正在拼命加载..." animated:YES];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _htmlStr=[DHotsHeaderOtherTool hotsHeaderOther:self.linkUrl];
        if (_htmlStr ==nil) {
            if (selfVC.number==1) {
                _htmlStr=[StarDetailTool starDetail:selfVC.linkUrl];
            }
        }else{
            if(selfVC.number==1){
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [GMDCircleLoader hideFromView:selfVC.view animated:YES];
                    selfVC.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStyleDone target:selfVC action:@selector(didClickedNext:)];
                });
            }
        }
        if(_htmlStr !=nil){
            dispatch_async(dispatch_get_main_queue(), ^{
//                [GMDCircleLoader hideFromView:selfVC.view animated:YES];
                [selfVC.webView loadHTMLString:_htmlStr baseURL:nil];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
//                [GMDCircleLoader stopInView:selfVC.view title:@"网络加载失败" animated:YES];
                if (self.number>1) {
//                    [GMDCircleLoader hideFromView:selfVC.view animated:YES];
                }
            });
        }
        
    });
    
}
-(void)didClickedNext:(UIBarButtonItem *)item{
    self.number++;
    NSRange range= [self.linkUrl rangeOfString:@".html"];
    NSString *strNum=[NSString stringWithFormat:@"%d",self.number-1];
    NSRange newRange=NSMakeRange(range.location-strNum.length, range.length+strNum.length);
    NSString *str=[self.linkUrl stringByReplacingCharactersInRange:newRange withString:[NSString stringWithFormat:@"%d.html",_number]];
    self.linkUrl=str;
    [self webViewRequest];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSRange range= [self.linkUrl rangeOfString:@".html"];
        NSString *strNum=[NSString stringWithFormat:@"%d",self.number-1];
        NSRange newRange=NSMakeRange(range.location-strNum.length, range.length+strNum.length);
        NSString *str=[self.linkUrl stringByReplacingCharactersInRange:newRange withString:[NSString stringWithFormat:@"%d.html",_number+1]];
         _htmlStr=[DHotsHeaderOtherTool hotsHeaderOther:str];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_htmlStr==nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.navigationItem.rightBarButtonItem.enabled=NO;
                });
                
            }
        });
      
        
    });
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
