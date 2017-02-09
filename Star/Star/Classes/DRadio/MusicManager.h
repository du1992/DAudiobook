//
//  DRadioSecondHeaderView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MusicManager : NSObject

extern NSString * const MHDidPlayMusicNotification;

+ (instancetype)defaultManager;

/**
 *  播放本地音乐
 */
- (AVAudioPlayer *)playingMusic:(NSString *)songid;

/**
 *  播放网络音乐
 */
- (AVPlayer *)playingURLMusic:(NSString *)urlString;


/**
 *  暂停本地音乐
 */
- (void)pauseMusic:(NSString *)filename;

/**
 *  停止本地音乐
 */
- (void)stopMusic:(NSString *)filename;

/**
 *  暂停网络播放
 */
- (void)pauseAVPlayer;


//播放音效
- (void)playSound:(NSString *)filename;
- (void)disposeSound:(NSString *)filename;

@end
