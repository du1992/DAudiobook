//
//  DRadioSecondHeaderView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "MusicManager.h"
NSString * const MHDidPlayMusicNotification = @"MHDidPlayMusicNotification";

@interface MusicManager ()
@property (nonatomic, strong) NSMutableDictionary *musicPlayers;
@property (nonatomic, strong) NSMutableDictionary *soundIDs;
@end

static MusicManager *_instance = nil;
static AVPlayer *player = nil;

@implementation MusicManager

+ (void)initialize
{
    // 音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类型（播放类型、播放模式,会自动停止其他音乐的播放）
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 激活会话
    [session setActive:YES error:nil];
}


+ (instancetype)defaultManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


- (instancetype)init
{
    __block MusicManager *temp = self;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((temp = [super init]) != nil) {
            _musicPlayers = [NSMutableDictionary dictionary];
            _soundIDs = [NSMutableDictionary dictionary];
        }
    });
    self = temp;
    return self;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       _instance = [super allocWithZone:zone];
    });
    return _instance;
}


//播放音乐
- (AVAudioPlayer *)playingMusic:(NSString *)songid
{
    if (songid == nil || songid.length == 0)  return nil;
    
    AVAudioPlayer *player = self.musicPlayers[songid];      //先查询对象是否缓存了
    
    if (!player) {
        
//        //先取出，进行判断
//        if ([self checkout:songid])
//        {
//            return nil;
//        }
        
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:songid ofType:@"mp3"]];
        
        if (!url)  return nil;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        
        if (![player prepareToPlay]) return nil;
        
        self.musicPlayers[songid] = player;            //对象是最新创建的，那么对它进行一次缓存
    }
    
    if (![player isPlaying]) {                 //如果没有正在播放，那么开始播放，如果正在播放，那么不需要改变什么
        [player play];
    }
    return player;
}



/**
 *  播放网络音乐
 */
- (AVPlayer *)playingURLMusic:(NSString *)urlString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[AVPlayer alloc] init];
    });
    if (urlString.length == 0) return nil;
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (!url) return nil;
    
    AVPlayerItem  *playerItem = [AVPlayerItem playerItemWithURL:url];
    [player replaceCurrentItemWithPlayerItem:playerItem];

    return player;
}


/**
 *  暂停音乐
 *
 */
- (void)pauseMusic:(NSString *)filename
{
    if (filename == nil || filename.length == 0)  return;
    
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    if ([player isPlaying]) {
        [player pause];
    }
}
- (void)stopMusic:(NSString *)filename
{
    if (filename == nil || filename.length == 0)  return;
    
    AVAudioPlayer *player = self.musicPlayers[filename];
    
    [player stop];
    
    [self.musicPlayers removeObjectForKey:filename];
}


- (BOOL)checkout:(NSString *)songid
{
    NSString *docDirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *file = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath ,songid];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:file]];
    return data;
}


//播放音效
- (void)playSound:(NSString *)filename
{
    if (!filename) return;
    
    //取出对应的音效ID
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (!soundID) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url) return;
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        self.soundIDs[filename] = @(soundID);
    }
    
    // 播放
    AudioServicesPlaySystemSound(soundID);
}


//摧毁音效
- (void)disposeSound:(NSString *)filename
{
    if (!filename) return;
    
    
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [self.soundIDs removeObjectForKey:filename];    //音效被摧毁，那么对应的对象应该从缓存中移除
    }
}


- (void)pauseAVPlayer
{
    [player pause];
}

@end
