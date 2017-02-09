//
//  DPlayMusicView.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DPlayMusicView.h"
#import "DSongModel.h"
#import <AVFoundation/AVFoundation.h>
#import "DRadioSecondListModel.h"
#import "Macro.h"
#import "MusicManager.h"

@interface DPlayMusicView ()
/**
 *  音乐图标
 */
@property (nonatomic,strong) UIImageView *MusicIconImageView;

/**
 *  播放/暂停按钮
 */
@property (nonatomic,strong) UIButton *playBtn;
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
/**
 *  网络歌曲的模型
 */
@property (nonatomic,strong) DRadioSecondListModel *listModel;
/**
 *  首页的播放按钮
 */
@property (nonatomic,strong) UIButton *SQPlayBtn;
/**
 *  当前播放进度
 */
@property (nonatomic,assign) CMTime currTime;

@property (nonatomic,strong) AVPlayer *player;
@end



@implementation DPlayMusicView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMusicModel:) name:MHDidPlayMusicNotification object:nil];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GoToRadio)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (void)GoToRadio
{
    if (self.songModel) return;
    self.block(self.listModel);
}


#pragma mark - 移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.SQPlayBtn removeObserver:self forKeyPath:@"selected"];
}

#pragma mark -
#pragma mark - 初始化方法
- (void)setupSubViews
{
    //创建左边的音乐图标
    UIImageView *MusicImageView = [[UIImageView alloc] init];
    MusicImageView.image = [UIImage imageNamed:@"音乐"];
    [self addSubview:MusicImageView];
    self.MusicIconImageView = MusicImageView;
    
    //创建右边的播放/暂停按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
    btn.selected = NO;
    [btn addTarget:self action:@selector(PlayOrPause) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.playBtn = btn;
    
    [self addSubview:self.singerLabel];
    [self addSubview:self.songNamelabel];
}


- (void)layoutSubviews
{
    //给音乐图标设置约束
    CGFloat padding = 10;
    __weak typeof(self)vc = self;
    [vc.MusicIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(@40);
        make.centerY.mas_equalTo(vc.mas_centerY);
        make.left.equalTo(vc.mas_left).offset(padding);
    }];
    //给按钮设置约束
    CGFloat playBtnW = 20;
    [vc.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(playBtnW, playBtnW));
        make.centerY.mas_equalTo(vc.mas_centerY);
        make.right.mas_equalTo(vc.mas_right).offset(-playBtnW);
    }];
    
    [vc.songNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vc.MusicIconImageView.mas_right);
        make.top.equalTo(vc.MusicIconImageView.mas_top);
        make.right.equalTo(vc.playBtn.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [vc.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vc.MusicIconImageView.mas_right);
        make.top.equalTo(vc.songNamelabel.mas_bottom);
        make.right.equalTo(vc.playBtn.mas_left);
        make.height.mas_equalTo(20);
    }];
}

#pragma mrak -
#pragma mark - 其他方法
- (void)PlayOrPause
{
    self.playBtn.selected = ![self.playBtn isSelected];
    self.SQPlayBtn.selected = self.playBtn.selected;
    if (self.playBtn.selected) {
        [self playMusic];
        [self  resumeLayer:self.MusicIconImageView.layer];
      }else
    {
        
        [[MusicManager defaultManager] pauseMusic:self.songModel.track_url];
        [self.player pause];
        self.currTime = self.player.currentTime;
        [self  pauseLayer:self.MusicIconImageView.layer];
    }
}


- (void)playMusic
{
    MusicManager *manager = [MusicManager defaultManager];
    if (self.songModel) {
        [manager playingMusic:self.songModel.track_url];
        self.listModel = nil;
    }else{
        [self.player seekToTime:self.currTime];
        [self.player play];
        self.songModel = nil;
    }
}


- (void)getMusicModel:(NSNotification *)notification
{
    self.MusicIconImageView= [self rotate360DegreeWithImageView:self.MusicIconImageView];
    NSDictionary *info = notification.userInfo;
    id obj = info[@"model"];
    if ([obj isKindOfClass:[DSongModel class]]) {  //如果是本地音乐
        self.songModel = obj;
        self.SQPlayBtn = info[@"playBtn"];
        
        //设置图片等数据
        self.MusicIconImageView.image = [UIImage imageNamed:self.songModel.logo];
        self.singerLabel.text = self.songModel.artist_name;
        self.songNamelabel.text = self.songModel.song_name;
    }else{
        self.listModel = obj;
//        [self.MusicIconImageView sd_setImageWithURL:[NSURL URLWithString:self.listModel.coverimg] placeholderImage:Placholder];
        self.singerLabel.text = info[@"uname"];
        self.songNamelabel.text = self.listModel.title;
        self.player = info[@"player"];
    }
    //KVO
    [self.SQPlayBtn addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
    
    self.playBtn.selected = YES;
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selected"]) {
        
        NSInteger NewSelected = [change[@"new"] integerValue];
        if (NewSelected == 1) {
            self.playBtn.selected = YES;
        }else{
            self.playBtn.selected = NO;
        }
    }
}

#pragma mark - 懒加载
- (UILabel *)songNamelabel
{
    if (!_songNamelabel) {
        _songNamelabel = [[UILabel alloc] init];
        _songNamelabel.backgroundColor = [UIColor clearColor];
        _songNamelabel.textColor = [UIColor whiteColor];
        _songNamelabel.font = [UIFont systemFontOfSize:13];
        _songNamelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _songNamelabel;
}


- (UILabel *)singerLabel
{
    if (!_singerLabel) {
        _singerLabel = [[UILabel alloc] init];
        _singerLabel.backgroundColor = [UIColor clearColor];
        _singerLabel.textColor = [UIColor whiteColor];
        _singerLabel.font = [UIFont systemFontOfSize:11];
        _singerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _singerLabel;
}

#pragma mark -旋转动画
-(UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 1.6;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [imageView.layer addAnimation:animation forKey:nil];
    return imageView;
}
//用来暂停layer上的动画
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}
//恢复layer上的动画
-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}
@end
