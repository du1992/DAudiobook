//
//  GDTMediaView.h
//  GDTMobSDK
//
//  Created by nimomeng on 2018/10/10.
//  Copyright © 2018 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDTMediaView : UIView

/**
 是否支持在WWAN下自动播放视频
 */
@property (nonatomic, assign) BOOL videoAutoPlayOnWWAN;

/**
 是否支持mute视频广告
 */
@property (nonatomic, assign) BOOL videoMuted;
@end
