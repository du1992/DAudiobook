//
//  DPlayerManager.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DSongModel.h"

NS_ASSUME_NONNULL_BEGIN

//缓存key
#define SONGLIST  @"SONGLIST"
#define TOTALTIME @"TOTALTIME"


@interface DPlayerManager : NSObject


/*存放歌曲数组*/
@property (nonatomic, strong) NSMutableArray *musicArray;
/*播放下标*/
@property (nonatomic, assign) NSInteger index;
/*总时长*/
@property (nonatomic, assign) NSString* totalTime;
/*是不是正在播放*/
@property (nonatomic, assign) BOOL isPlay;
/*播放器*/
@property (nonatomic, strong) AVPlayer *player;
/*标记是不是没点列表直接点了播放按钮如果是就默认播放按钮*/
@property (nonatomic, assign) BOOL isFristPlayerPauseBtn;
/*开始播放*/
@property (nonatomic,copy)void(^isStartPlayer)(NSInteger index);//0是开始 1 暂停

/*第一次点击列表播放*/
@property (nonatomic, assign) NSInteger isFirstClickedListPlayer;
//标记是否在单曲循环 (如果是yes是当前这首播放完时自动还从新开始播放)当前播放的
@property (nonatomic, assign) BOOL isSinglecycle;






/*播放工具单利*/
+(instancetype)defaultManager;
/*播放和暂停*/
- (void)playAndPause;
/*前一首*/
- (void)playPrevious;
/*后一首*/
- (void)playNext;
/*自动下一首或者是单曲循环*/
-(void)autoNext;
/*播放时调用*/
- (void)reloadDataWithIndex:(NSInteger)index;
/*当前播放项*/
- (void)replaceItemWithUrlString:(NSString *)urlString;
/*声音*/
- (void)playerVolumeWithVolumeFloat:(CGFloat)volumeFloat;
/*进度条*/
- (void)playerProgressWithProgressFloat:(CGFloat)progressFloat;
/**当前播放数据*/
-(DSongModel *)currentSongModel;




@end

NS_ASSUME_NONNULL_END
