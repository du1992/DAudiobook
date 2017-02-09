//
//  Business.m
//  live
//
//  Created by hysd on 15/8/6.
//  Copyright (c) 2015年 kenneth. All rights reserved.
//

#import "Business.h"
#import "Macro.h"

@interface Business(){
    
}
@end
@implementation Business
static Business *sharedObj = nil;
+ (Business*) sharedInstance
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

//视频数据
- (void)getVideofooterRefresh:(NSString*)url succ:(NetWorkSuccBlock )succ fail:(businessFail )fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        succ(operation ,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        fail(@"错误");
    }];
}
//天气数据
- (void)getWeather:(NSString*)url succ:(NetWorkSuccBlock )succ fail:(businessFail )fail{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        succ(operation ,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        fail(@"错误");
    }];
    
}
//电台数据
- (void)getRadio:(NSString*)url succ:(NetWorkSuccBlock )succ fail:(businessFail )fail{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        succ(operation ,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误=====%@",error);
        fail(@"错误");
    }];
}
//电台详情数据
- (void)getRadioSecond:(NSString*)url params:(NSDictionary*)params succ:(NetWorkSuccBlock )succ fail:(businessFail )fail{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        succ(operation ,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"错误=====%@",error);
        fail(@"错误");
    }];
}
@end

