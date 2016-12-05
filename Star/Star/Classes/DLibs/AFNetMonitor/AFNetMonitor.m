//
//  AFnet.m
//  AFNetworking
//
//  Created by JUNE_EN on 15/6/9.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "AFNetMonitor.h"
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AFHTTPSessionManager.h"

@interface AFNetMonitor ()

@end
@implementation AFNetMonitor

static NSString * const AFBaseURLString = @"www.baidu.com";
+ (instancetype)sharedClient {
    
    static AFNetMonitor *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFNetMonitor alloc] initWithBaseURL:[NSURL URLWithString:AFBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        __unsafe_unretained typeof(self) selfVC=self;
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:{
//                    [selfVC setupHintLabelWithTitle:@"2G/3G网络"];
                }
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:{
//                     [selfVC setupHintLabelWithTitle:@"WIFI网络"];
                }
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:{
                    [selfVC setupHintLabelWithTitle:@"网络断开"];
                }
                    break;
                default:
                    break;
                    
            }
            
        }];
        
        [_sharedClient.reachabilityManager startMonitoring];
        
    });
    
    return _sharedClient;
    
}

+(void)setupHintLabelWithTitle:(NSString *)title{
    AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    CGSize size=[[UIScreen mainScreen] bounds].size;
    UILabel *view =[[UILabel alloc] initWithFrame:CGRectMake((size.width-100)/2.0,size.height-100, 100, 30)];
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.5;
    view.textAlignment=NSTextAlignmentCenter;
    view.textColor=[UIColor whiteColor];
    view.text=title;
    [appDelegate.window addSubview:view];
    [appDelegate.window bringSubviewToFront:view];
    [UIView animateWithDuration:2.5 animations:^{
        view.alpha=0;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

@end
