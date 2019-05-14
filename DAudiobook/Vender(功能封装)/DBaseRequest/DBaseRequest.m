//
//  DBaseRequest.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBaseRequest.h"
#import "AFNetworking.h"

@implementation DBaseRequest

+ (void)POST:(NSString *)URLString parameters:(nullable id)parameters block:(nullable void (^)( id __nullable input, NSError * __nullable error))block{
    
    //模拟网络请求（返回本地数据）
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@.json",URLString] ofType:nil];
    NSArray *localArray;
    if (dataPath) {
        NSData *localData = [[NSData alloc] initWithContentsOfFile:dataPath];
         localArray = [NSJSONSerialization JSONObjectWithData:localData options:0 error:nil];
    }
    
    if (block) {
        block(localArray,nil);
    }
    
    
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//        if (block) {
//            block(responseObject,nil);
//        }
//
//    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
//        if (block) {
//            block(nil,error);
//        }
//
//    }];
    
    
}

+ (void)GET:(NSString *)URLString parameters:(nullable id)parameters block:(nullable void (^)( id __nullable input, NSError * __nullable error))block{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        if (block) {
            block(responseObject,nil);
        }
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        if (block) {
            block(nil,error);
        }
        
    }];
    
}


@end
