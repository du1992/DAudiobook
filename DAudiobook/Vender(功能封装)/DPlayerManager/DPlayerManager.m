//
//  DPlayerManager.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPlayerManager.h"

static DPlayerManager *_defaultManager = nil;

@implementation DPlayerManager

+(instancetype)defaultManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[DPlayerManager alloc]init];
        
    });
    return _defaultManager;
}
/*初始化播放器*/
- (instancetype)init
{
    if (self = [super init]) {
        _player = [[AVPlayer alloc] init];
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session  setCategory:AVAudioSessionCategoryPlayback error:nil];
        [session setActive:YES error:nil];
    }
    return self;
}

// 播放
- (void)playerPlay
{
    [_player play];
    _isPlay = YES;
    
}
//暂停
- (void)playerPause
{
    [_player pause];
    _isPlay = NO;
    
}
//播放和暂停
- (void)playAndPause
{
    if (self.isPlay) {
        [self playerPause];
        if (self.isStartPlayer) {
            self.isStartPlayer(1);
        }
    }else{
        [self playerPlay];
        if (self.isStartPlayer) {
            self.isStartPlayer(0);
        }
    }
}
//前一首
- (void)playPrevious
{
    if (self.index == 0) {
        self.index = self.musicArray.count - 1;
    }else{
        self.index--;
    }
     [self reloadDataWithIndex:self.index];
}
//下一首
- (void)playNext
{
    if (self.index == self.musicArray.count - 1) {
        self.index = 0;
    }else{
        self.index++;
    }
     [self reloadDataWithIndex:self.index];
}
//自动下一首或者是单曲循环
-(void)autoNext{
    
    if (self.isSinglecycle) {//单曲循环
        [self reloadDataWithIndex:self.index];
    }else{
        [self playNext];
        [self reloadDataWithIndex:self.index];
    }
    
}
//播放时调用
- (void)reloadDataWithIndex:(NSInteger)index{
    if (self.index<self.musicArray.count) {
        self.index=index;
        //读取歌曲的总时间
        
        self.isFristPlayerPauseBtn = YES;
        if (self.isFirstClickedListPlayer==0) {//第一次点击列表播放
            if (self.isStartPlayer) {
                self.isStartPlayer(0);
            }
        }
        self.isFirstClickedListPlayer = 1;
        // 修改播放歌曲
        [self replaceItemWithUrlString:[self currentSongModel].musicUrl];
        [self lockScreen:self.totalTime];
    }
}
//音量
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat
{
    self.player.volume = volumeFloat;
}
//进度
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat
{
    [self.player seekToTime:CMTimeMakeWithSeconds(progressFloat, 1) completionHandler:^(BOOL finished) {
        [self playerPlay];
    }];
}
//当前播放
- (void)replaceItemWithUrlString:(NSString *)urlString
{
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self playerPlay];
}
//当前数据模型
-(DSongModel *)currentSongModel{
    if (self.index<self.musicArray.count) {
      return  self.musicArray[self.index];
    }
    return  nil;
}
#pragma mark 锁屏传值
-(void)lockScreen:(NSString *)totalTime{
    NSNumber *time = [NSNumber numberWithDouble:[totalTime doubleValue]];
    if (self.musicArray.count) {
       
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        //设置歌曲时长
        [info setObject:time forKey:MPMediaItemPropertyPlaybackDuration];
        [info setObject:[NSNumber numberWithDouble:0] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        //设置歌曲名
        info[MPMediaItemPropertyTitle] = [self currentSongModel].title;
        //演唱者
        [info setObject: [self currentSongModel].title forKey:MPMediaItemPropertyArtist];
        //设置歌手头像
        NSString *str=[NSString stringWithFormat:@"%@",[self currentSongModel].coverimg];
        NSString *url=[str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        //设置歌手头像
        if ([UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]) {
            MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
            info[MPMediaItemPropertyArtwork] = artwork;
        }
        [info setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo =  info;
        //更新字典
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:info];
    }
}
@end
