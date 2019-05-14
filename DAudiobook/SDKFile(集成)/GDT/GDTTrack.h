//
//  GDTTrack.h
//  GDTMobApp
//
//  Created by GaoChao on 16/1/7.
//  Copyright © 2016年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! 当用户完成注册操作的时候的事件名 */
extern NSString *const GDTSDKAppEventNameCompletedRegistration;
/*! 当用户加入购物车操作的事件名 */
extern NSString *const GDTSDKAppEventNameAddToCart;
/*! 当用户完成购买进行付费行为的事件名 */
extern NSString *const GDTSDKAppEventNamePurchase;
/*! 当用户完成应用评分行为的事件名 */
extern NSString *const GDTSDKAppEventNameAppScore;
/*! 当用户完成应用搜索行为的事件名 */
extern NSString *const GDTSDKAppEventNameAppSearch;

@interface GDTTrack : NSObject

/*!
 @abstract
 当应用界面回到活跃Activate状态时调用此方法，SDK会统计用户留存状况以及适时统计激活数据
 
 */
+ (void)activateApp;

/*!
 @abstract
 当应用界面回到活跃Activate状态时调用此方法，SDK会统计用户留存状况以及适时统计激活数据
 
 @param value 此次事件的价值
 */
+ (void)activateAppWithValue:(int)value;

/*!
 @abstract 
 上报事件的基础接口，目前支持注册事件的上报
 
 @param eventName 事件名
 */
+ (void)logEvent:(NSString *)eventName;

/*!
 @abstract
 上报事件的基础接口，目前支持注册事件的上报
 
 @param eventName 事件名
 @param value     此次事件的价值
 */
+ (void)logEvent:(NSString *)eventName
      withValue:(int)value;

@end
