//
//  GDTHybridAd.h
//  GDTMobApp
//
//  Created by royqpwang on 2019/3/8.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, GDTHybridAdOptions) {
    GDTHybridAdOptionRewardVideo = 1 << 0
};

@class GDTHybridAd;

@protocol GDTHybridAdDelegate <NSObject>

@optional

- (void)gdt_hybridAdDidPresented:(GDTHybridAd *)hybridAd;
- (void)gdt_hybridAdDidClose:(GDTHybridAd *)hybridAd;
- (void)gdt_hybridAdLoadURLSuccess:(GDTHybridAd *)hybridAd;
- (void)gdt_hybridAd:(GDTHybridAd *)hybridAd didFailWithError:(NSError *)error;

@end

@interface GDTHybridAd : NSObject

/**
 自定义浏览器 UI 属性，请在 showWithRootViewController: 方法前设置。
 */
@property (nonatomic, copy) NSString *titleContent;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *navigationBarColor;
@property (nonatomic, strong) UIColor *navigationBarBottomColor;
@property (nonatomic, strong) UIColor *separatorLineColor;
@property (nonatomic, strong) UIImage *closeImage; // 如需自定义关闭图片，请按 44*44 大小设置
@property (nonatomic, strong) UIImage *backImage; // 如需自定义后退图片，请按 44*44 大小设置


/**
 委托对象
 */
@property (nonatomic, weak) id <GDTHybridAdDelegate> delegate;


/**
 构造方法

 @param appId - 媒体 ID
 @param adOptions - 支持的广告类型 Options，激励视频请传 GDTHybridAdOptionRewardVideo
 @return GDTHybrid 实例
 */
- (instancetype)initWithAppId:(NSString *)appId type:(GDTHybridAdOptions)adOptions;


/**
 加载广告方法 支持 iOS8.1 及以上系统

 @param url 加载的 X 中心 URL
 */
- (void)loadWithUrl:(NSString *)url;


/**
 展示浏览器方法

 @param rootViewController 用于 present 浏览器 VC
 */
- (void)showWithRootViewController:(UIViewController *)rootViewController;

@end

NS_ASSUME_NONNULL_END
