//
//  DPlayMusicView.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"
#import "DSongModel.h"
#import <MediaPlayer/MediaPlayer.h>

NS_ASSUME_NONNULL_BEGIN

typedef  void(^DBottomMusicClick)(void);







@interface DPlayMusicView : DView




@property(nonatomic)BOOL isDownload;

/**
 *  音乐图标
 */
@property (nonatomic,strong) UIImageView *musicIconImageView;

/**
 *  播放/暂停按钮
 */
@property (nonatomic,strong) UIButton *playButton;
/**
 *  歌手名
 */
@property (nonatomic,strong) UILabel *singerLabel;
/**
 *  歌曲名
 */
@property (nonatomic,strong) UILabel *songNamelabel;
/**
 *  歌曲数据模型
 */
@property (nonatomic,strong) DSongModel *songModel;



/*定时器*/
@property(nonatomic,strong)NSTimer     *timer;

/*进度*/
@property(nonatomic,strong)UISlider    *progressSlider;

- (void)reloadDataWithIndex:(NSInteger)index;
//点击下一首时刷新页面用(当前播放的歌曲--->歌曲名字颜色改变)
@property(nonatomic,copy)void(^reloadBlock)(void);
//是否在播放歌曲(主要作用是替换播放暂停按钮的图片)
@property (nonatomic, assign) BOOL isSongPlayer;
//自动下一首
-(void)autoNext;
//播放暂停
-(void)playAndPauseBtnClicekd:(UIButton *)btn;
//下一首按钮点击
-(void)nextBtnClicked:(UIButton *)btn;
//上一首
-(void)previousBtnClicked:(UIButton *)btn;
//标记是否在单曲循环 (如果是yes是当前这首播放完时自动还从新开始播放)当前播放的
@property (nonatomic, assign) BOOL isSinglecycle;

@property (nonatomic,copy) DBottomMusicClick   bottomMusicBlock;




@end

NS_ASSUME_NONNULL_END
