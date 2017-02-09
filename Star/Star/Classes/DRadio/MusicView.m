//
//  DRadioSecondHeaderView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "MusicView.h"
#import "MusicManager.h"
#import "Masonry.h"
#import "SongModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "RadioMusicView.h"
#import "Macro.h"


@interface MusicView ()
/**
 *  音乐播放器
 */
@property (nonatomic,strong) AVAudioPlayer *player;
/**
 *  头像视图
 */
@property (nonatomic,strong) UIImageView *iconView;
/**
 *  歌手名Label
 */
@property (nonatomic,strong) UILabel *artist_nameLabel;
/**
 *  歌曲名Label
 */
@property (nonatomic,strong) UILabel *song_nameLabel;
/**
 *  播放进度条
 */
@property (nonatomic,strong) UIProgressView *musicProgress;
/**
 *  剩余播放时间Label
 */
@property (nonatomic,strong) UILabel *play_secondsLabel;
/**
 *  播放/暂停按钮
 */
@property (nonatomic,strong) UIButton *PlayOrPauseBtn;
/**
 *  当前歌曲的数据模型
 */
@property (nonatomic,strong) SongModel *songModel;
/**
 *  当前歌曲的序号
 */
@property (nonatomic,assign) NSUInteger nowSong;
/**
 *  存放歌曲的数组
 */
@property (nonatomic,strong) NSArray *songsArray;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,strong) RadioMusicView *musicView;

@end

@implementation MusicView

- (instancetype)init
{
    if (self = [super init]) {
        //初始化子控件
        [self creatSubViews];
        //设置自动约束
        [self setupAutoLayout];
    }
    return self;
}


- (void)creatSubViews
{
    [self addSubview:self.iconView];
    [self addSubview:self.PlayOrPauseBtn];
    [self addSubview:self.play_secondsLabel];
    [self addSubview:self.artist_nameLabel];
    [self addSubview:self.musicProgress];
    [self addSubview:self.song_nameLabel];
}


- (void)setupAutoLayout
{
    __weak typeof(self)view = self;
    [view.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY).offset(-Padding);
        make.size.mas_equalTo(CGSizeMake(100,100));
        make.centerX.mas_equalTo(view.mas_centerX).offset(WIDTH * 0.3);
    }];
    
    [view.song_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.right.equalTo(view.iconView.mas_left);
        make.top.equalTo(view.iconView.mas_top).offset(Padding * 0.5);
        make.bottom.equalTo(view.artist_nameLabel.mas_top);
        make.height.mas_equalTo(35);
    }];
    
    [view.artist_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.song_nameLabel.mas_left);
        make.right.equalTo(view.song_nameLabel.mas_right);
        make.top.equalTo(view.song_nameLabel.mas_bottom);
        make.bottom.equalTo(view.iconView.mas_bottom).offset(-Padding * 0.5);
    }];
    
    [view.musicProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.song_nameLabel);
        make.top.equalTo(view.iconView.mas_bottom).offset(18);
        make.height.mas_equalTo(3);
        make.right.equalTo(view.play_secondsLabel.mas_left).offset(-10);
    }];
    
    [view.play_secondsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.iconView.mas_right);
        make.top.equalTo(view.iconView.mas_bottom);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(50);
    }];
    
    [view.PlayOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.iconView.mas_centerX);
        make.centerY.equalTo(view.iconView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50,50));
    }];
}


#pragma mark - 播放音乐
- (void)playMusic
{
    if (self.musicView.isPlaying) {
        [[MusicManager defaultManager] pauseAVPlayer];
    }
    MusicManager *manager = [MusicManager defaultManager];
    self.player = [manager playingMusic:self.songModel.track_url];
   
    
    
    
    //发出通知,传递模型
    NSDictionary *info = @{
                           @"model" : self.songModel,
                           @"playBtn" : self.PlayOrPauseBtn
                           };
    [[NSNotificationCenter defaultCenter] postNotificationName:MHDidPlayMusicNotification object:nil userInfo:info];
    
    //设置滑动条
    NSInteger totalTime = [self.songModel.play_seconds integerValue];
    NSInteger minute = totalTime / 60;
    NSInteger second = totalTime % 60;
    self.play_secondsLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    
    //添加定时器
    [self addTimer];
}


#pragma mark - 添加定时器
- (void)addTimer
{
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(changeTextForLabel) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}


- (void)changeTextForLabel
{
    NSInteger totalTime =  self.player.duration - self.player.currentTime;
    NSInteger minute = totalTime / 60;
    NSInteger second = totalTime % 60;
    self.play_secondsLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",minute,second];
    
    self.musicProgress.progress += 1.0 / self.player.duration;
}


- (void)PlayOrPause
{
    self.PlayOrPauseBtn.selected = ![self.PlayOrPauseBtn isSelected];
    if (self.PlayOrPauseBtn.selected) {
        [self playMusic];
        [self addTimer];
        self.playing = YES;
    }else
    {
        [[MusicManager defaultManager] pauseMusic:self.songModel.track_url];
        [self.timer invalidate];
        self.playing = NO;
    }
}


- (void)pause
{
    [[MusicManager defaultManager] pauseMusic:self.songModel.track_url];
    self.playing = NO;
}


#pragma mark - 发送网络请求获取数据
- (void)setSongid:(NSUInteger)songid
{
    _songid = songid;
    if (self.nowSong == songid) return;
    self.songModel = self.songsArray[songid];
    
        //设置缩略图
        self.iconView.image = [UIImage imageNamed:self.songModel.logo];
        self.song_nameLabel.text = self.songModel.song_name;
        self.artist_nameLabel.text = self.songModel.artist_name;
        self.play_secondsLabel.text = @"00:00";
}





- (void)updata
{
   
}


#pragma mark -
#pragma mark - 懒加载

- (UIButton *)PlayOrPauseBtn
{
    if (!_PlayOrPauseBtn) {
        _PlayOrPauseBtn = [[UIButton alloc] init];
        [_PlayOrPauseBtn setBackgroundColor:[UIColor clearColor]];
        [_PlayOrPauseBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_PlayOrPauseBtn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
        _PlayOrPauseBtn.selected = NO;
        [_PlayOrPauseBtn addTarget:self action:@selector(PlayOrPause) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PlayOrPauseBtn;
}


- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}


- (UILabel *)song_nameLabel
{
    if (!_song_nameLabel) {
        _song_nameLabel = [[UILabel alloc] init];
        _song_nameLabel.font = [UIFont boldSystemFontOfSize:17];
        _song_nameLabel.backgroundColor = [UIColor whiteColor];
        _song_nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _song_nameLabel;
}

- (UILabel *)artist_nameLabel
{
    if (!_artist_nameLabel) {
        _artist_nameLabel = [[UILabel alloc] init];
        _artist_nameLabel.textColor = [UIColor darkGrayColor];
        _artist_nameLabel.font = [UIFont systemFontOfSize:12];
        _artist_nameLabel.backgroundColor = [UIColor whiteColor];
        _artist_nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _artist_nameLabel;
}


- (UIProgressView *)musicProgress
{
    if (!_musicProgress) {
        _musicProgress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _musicProgress.progressTintColor = [UIColor groupTableViewBackgroundColor];
        _musicProgress.trackTintColor = [UIColor whiteColor];
        _musicProgress.progress = 0;
    }
    return _musicProgress;
}


- (UILabel *)play_secondsLabel
{
    if (!_play_secondsLabel) {
        _play_secondsLabel = [[UILabel alloc] init];
        _play_secondsLabel.font = [UIFont systemFontOfSize:12];
        _play_secondsLabel.textColor = [UIColor lightGrayColor];
        _play_secondsLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _play_secondsLabel;
}


- (NSArray *)songsArray
{
    if (!_songsArray) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SongList" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            SongModel *model = [[SongModel alloc] init];
            model.song_name = dic[@"song_name"];
            model.artist_name = dic[@"singer"];
            model.track_url = dic[@"song"];
            model.logo = dic[@"icon"];
            model.play_seconds = dic[@"play_seconds"];
            [temp addObject:model];
        }
        _songsArray = temp;
    }
    return _songsArray;
}


- (RadioMusicView *)musicView
{
    if (!_musicView) {
        _musicView = [[RadioMusicView alloc] init];
    }
    return _musicView;
}

@end
