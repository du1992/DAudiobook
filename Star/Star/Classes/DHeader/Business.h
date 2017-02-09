//
//  Business.h
//  live
//
//  Created by hysd on 15/8/6.
//  Copyright (c) 2015年 kenneth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import <StoreKit/StoreKit.h>

@interface NSDictionary(XiaoXiong)

- (BOOL)isSuccess;
- (NSString *)errorMessage;
- (NSDictionary *)responseDic;



@end

/**
 *  成功回调
 */
//typedef void (^businessSucc)(NSString* msg, id data);
typedef void (^NetWorkSuccBlock) (AFHTTPRequestOperation *operation, NSDictionary *responseObject);
/**
 *  失败回调
 */
typedef void (^businessFail)(NSString *error);
typedef void (^NetWorkErrorBlock)(AFHTTPRequestOperation* completedOperation, NSError* error);

@interface Business : NSObject
/**
 * 获取单例
 */
+ (Business*) sharedInstance;

/**

 *  获取直播列表
 *  @param currentPage 页
 *  @param succ   成功回调
 *  @param fail   失败回调
 */

- (void)getVideofooterRefresh:(NSString*)url succ:(NetWorkSuccBlock )succ fail:(businessFail )fail;
/**
 
 *  天气
 *  @param currentPage 页
 *  @param succ   成功回调
 *  @param fail   失败回调
 */
- (void)getWeather:(NSString*)url succ:(NetWorkSuccBlock )succ fail:(businessFail )fail;
/**
 
 *  电台

 *  @param succ   成功回调
 *  @param fail   失败回调
 */
- (void)getRadio:(NSString*)url succ:(NetWorkSuccBlock )succ fail:(businessFail )fail;
/**
 
 *  电台详情
 
 *  @param succ   成功回调
 *  @param fail   失败回调
 */
- (void)getRadioSecond:(NSString*)url params:(NSDictionary*)params succ:(NetWorkSuccBlock )succ fail:(businessFail )fail;



@end
