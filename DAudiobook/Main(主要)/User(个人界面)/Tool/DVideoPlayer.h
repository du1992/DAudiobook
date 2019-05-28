//
//  DVideoPlayer.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/24.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@class DVideoPlayer;

typedef void (^VideoCompletedPlayingBlock) (DVideoPlayer *videoPlayer);



@interface DVideoPlayer : UIView

@property (nonatomic, copy) VideoCompletedPlayingBlock completedPlayingBlock;

@property (nonatomic, strong) UIButton *playOrPauseBtn;
- (void)playOrPause:(UIButton *)btn;
/**
 *  video url 视频路径
 */
@property (nonatomic, strong) NSString *videoUrl;


@property(nonatomic)BOOL isDown;

/**
 *  play or pause
 */
- (void)playPause;

/**
 *  dealloc 销毁
 */
- (void)destroyPlayer;

/**
 *  在cell上播放必须绑定TableView、当前播放cell的IndexPath
 */
- (void)playerBindTableView:(UITableView *)bindTableView currentIndexPath:(NSIndexPath *)currentIndexPath;

/**
 *  在scrollview的scrollViewDidScroll代理中调用
 *
 *  @param support        是否支持右下角小窗悬停播放
 */
- (void)playerScrollIsSupportSmallWindowPlay:(BOOL)support;



@end



NS_ASSUME_NONNULL_END
