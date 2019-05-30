//
//  GDTUnifiedNativeAdView.h
//  GDTMobSDK
//
//  Created by nimomeng on 2018/10/10.
//  Copyright © 2018 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTLogoView.h"
#import "GDTMediaView.h"
#import "GDTUnifiedNativeAdDataObject.h"
#import "GDTSDKDefines.h"

@class GDTUnifiedNativeAdView;

//视频广告时长Key
extern NSString* const kGDTUnifiedNativeAdKeyVideoDuration;

@protocol GDTUnifiedNativeAdViewDelegate <NSObject>
/**
 广告曝光回调

 @param unifiedNativeAdView GDTUnifiedNativeAdView 实例
 */
- (void)gdt_unifiedNativeAdViewWillExpose:(GDTUnifiedNativeAdView *)unifiedNativeAdView;


/**
 广告点击回调

 @param unifiedNativeAdView GDTUnifiedNativeAdView 实例
 */
- (void)gdt_unifiedNativeAdViewDidClick:(GDTUnifiedNativeAdView *)unifiedNativeAdView;


/**
 广告详情页关闭回调

 @param unifiedNativeAdView GDTUnifiedNativeAdView 实例
 */
- (void)gdt_unifiedNativeAdDetailViewClosed:(GDTUnifiedNativeAdView *)unifiedNativeAdView;


/**
 当点击应用下载或者广告调用系统程序打开时调用
 
 @param unifiedNativeAdView GDTUnifiedNativeAdView 实例
 */
- (void)gdt_unifiedNativeAdViewApplicationWillEnterBackground:(GDTUnifiedNativeAdView *)unifiedNativeAdView;


/**
 广告详情页面即将展示回调

 @param unifiedNativeAdView GDTUnifiedNativeAdView 实例
 */
- (void)gdt_unifiedNativeAdDetailViewWillPresentScreen:(GDTUnifiedNativeAdView *)unifiedNativeAdView;


/**
 视频广告播放状态更改回调

 @param nativeExpressAdView GDTUnifiedNativeAdView 实例
 @param status 视频广告播放状态
 @param userInfo 视频广告信息
 */
- (void)gdt_unifiedNativeAdView:(GDTUnifiedNativeAdView *)unifiedNativeAdView playerStatusChanged:(GDTMediaPlayerStatus)status userInfo:(NSDictionary *)userInfo;
@end

@interface GDTUnifiedNativeAdView:UIView
@property (nonatomic, strong, readonly) GDTMediaView *mediaView;
@property (nonatomic, weak) id<GDTUnifiedNativeAdViewDelegate> delegate;

/*
 *  viewControllerForPresentingModalView
 *  详解：开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *viewController;


/**
 自渲染2.0视图注册方法

 @param dataObject 数据对象，必传字段
 @param logoView logo视图
 @param viewController 所在ViewController，必传字段。支持在register之后对其进行修改
 @param clickableViews 可点击的视图数组，此数组内的广告元素才可以响应广告对应的点击事件
 */
- (void)registerDataObject:(GDTUnifiedNativeAdDataObject *)dataObject
                  logoView:(GDTLogoView *)logoView
            viewController:(UIViewController *)viewController
            clickableViews:(NSArray<UIView *> *)clickableViews;


/**
 自渲染2.0视图注册方法
 
 @param dataObject 数据对象，必传字段
 @param mediaView 媒体对象视图，此处放视频播放器的容器视图
 @param logoView logo视图
 @param viewController 所在ViewController，必传字段。支持在register之后对其进行修改
 @param clickableViews 可点击的视图数组，此数组内的广告元素才可以响应广告对应的点击事件
 */
- (void)registerDataObject:(GDTUnifiedNativeAdDataObject *)dataObject
                 mediaView:(GDTMediaView *)mediaView
                  logoView:(GDTLogoView *)logoView
            viewController:(UIViewController *)viewController
            clickableViews:(NSArray<UIView *> *)clickableViews;
@end



