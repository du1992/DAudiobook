//
//  DRadioSecondHeaderView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "RadioMusicView.h"
#import "Masonry.h"
#import "DRadioSecondListModel.h"
#import "UIImageView+WebCache.h"
#import "MusicManager.h"
#import "MusicView.h"
#import "Macro.h"

@interface RadioMusicView (){
    BOOL playerLoadings;
}

@property (nonatomic,strong) UIImageView *backgroundImageView;
/**
 *  配图
 */
@property (nonatomic,strong) UIImageView *coverImageView;
/**
 *  标题
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 *  喜欢数
 */
@property (nonatomic,strong) UIButton *likeBtn;
/**
 *  评论数
 */
@property (nonatomic,strong) UIButton *commentBtn;

@property (nonatomic,strong) NSString *currentURL;

@property (nonatomic,strong) MusicView *musicView;

@property (nonatomic,assign) CMTime currentTime;

@property (nonatomic,strong) id observer;

@property(nonatomic,strong)DRadioSecondListModel*SecondListModel;


@end

@implementation RadioMusicView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
          _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
         [self  addSubview:_backgroundImageView];
        //初始化子控件
        [self setupSubViews];
        
        //自动适配
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)weakSelf = self;
    CGFloat padding = 30;
    CGFloat coverW = 100;
    [weakSelf.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(60);
        make.size.mas_equalTo(CGSizeMake(coverW,coverW));
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [weakSelf.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageView.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.mas_left).offset(60);
        make.right.equalTo(weakSelf.mas_right).offset(-60);
        make.height.mas_equalTo(padding);
    }];
    
    
    [weakSelf.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.coverImageView.mas_left).offset(padding/2);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(padding);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [weakSelf.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.likeBtn.mas_top);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60,60));
    }];
    
    [weakSelf.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.likeBtn.mas_bottom).offset(padding+30);
        make.left.equalTo(weakSelf.mas_left).offset(60);
        make.right.equalTo(weakSelf.mas_right).offset(-60);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(3);
    }];
    
    [weakSelf.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(weakSelf.mas_top).offset(30);
        make.left.equalTo(weakSelf.mas_left).offset(60);
        make.right.equalTo(weakSelf.mas_right).offset(-60);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(padding / 2);

    }];
    self.currentLabel.textAlignment = NSTextAlignmentCenter;;
    self.coverImageView.layer.cornerRadius = coverW/2;
    self.coverImageView.layer.masksToBounds = YES;
    self.coverImageView.layer.borderWidth = 2;
    self.coverImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.coverImageView.userInteractionEnabled = YES;
    
   
    [self.commentBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    [self.commentBtn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
    self.commentBtn.selected = NO;
    [self.commentBtn addTarget:self action:@selector(PlayOrPause) forControlEvents:UIControlEventTouchUpInside];
  

    
}

- (void)PlayOrPause
{
    self.commentBtn.selected = ![self.commentBtn isSelected];
    if (self.commentBtn.selected) {

         [self.player play];
         self.playing = YES;
        [self  resumeLayer:self.coverImageView.layer];
    }else
    {
        [_player pause];
        self.playing = NO;
        [self  pauseLayer:self.coverImageView.layer];
    }
}


#pragma mark - 初始化子控件
- (void)setupSubViews
{
    [self addSubview:self.coverImageView];
    [self addSubview:self.likeBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.currentLabel];
    [self addSubview:self.progressView];
    [self addSubview:self.commentBtn];
}



#pragma mark - 懒加载
- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
       
    }
    return _backgroundImageView;
}
- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment  =NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)likeBtn
{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _likeBtn;
}


- (UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _commentBtn;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.progressTintColor = [UIColor darkGrayColor];
    }
    return _progressView;
}

- (UILabel *)currentLabel
{
    if (!_currentLabel) {
        _currentLabel = [[UILabel alloc] init];
        _currentLabel.font = [UIFont systemFontOfSize:11];
        _currentLabel.textColor = [UIColor lightGrayColor];
    }
    return _currentLabel;
}


- (void)passRadioMessage:(DRadioSecondListModel *)listModel andName:(NSString *)name
{
    [self playUI:listModel andName:name];
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    BOOL hasin = [defaults boolForKey:@"time"];
    if (!hasin) {
        self.progressView.hidden=YES;
        self.commentBtn.hidden=YES;
        self.audioplayer = [[MusicManager defaultManager] playingMusic:[NSString stringWithFormat:@"%d",arc4random() % 9]];
        
    }else{
        
        if (self.musicView.isPlaying) {
            [self.musicView pause];
        }
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:self.player];
        
        
        self.playing = YES;
        if (listModel.musicUrl != self.currentURL) {
            self.player = nil;
            self.player = [[MusicManager defaultManager] playingURLMusic:listModel.musicUrl];
            
            
            
            
            [self.player play];
            self.currentURL = listModel.musicUrl;
            self.playing = YES;
            
            //添加通知
            NSDictionary *info = @{
                                   @"model" : listModel,
                                   @"uname" : name,
                                   @"player" : self.player
                                   };
            [[NSNotificationCenter defaultCenter] postNotificationName:MHDidPlayMusicNotification object:nil userInfo:info];
            
            
            [self addobserver];
            double duration =0.6;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.playerLoading(YES);
            });
            
            
        }
    }
    
    
    
   
    
    
}

-(void)playUI:(DRadioSecondListModel *)listModel andName:(NSString *)name{
    
    self.SecondListModel=listModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:listModel.coverimg] placeholderImage:Placholder];
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:listModel.coverimg] placeholderImage:Placholder];
    
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = CGRectMake(0, 0, _backgroundImageView.frame.size.width, _backgroundImageView.frame.size.height);
    [_backgroundImageView addSubview:effectView];
    
    
    
    self.titleLabel.text = listModel.title;
}



- (void)addobserver
{
    CMTime time = CMTimeMake(1.0, 1.0);
    __weak typeof(self)weakSelf = self;
    id timeObserver = [weakSelf.player addPeriodicTimeObserverForInterval:time queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        //当前缓冲时间
        NSInteger current = CMTimeGetSeconds(time);
        //总的缓冲时间
        NSInteger total = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        if (current) {
            [self PlayerItemTimeJumped];
            weakSelf.progressView.progress = current * 1.0 / total;
            if (current > 60) {
                NSInteger minute = current / 60;
                NSInteger second = current % 60;
                weakSelf.currentLabel.text = [NSString stringWithFormat:@"%ld:%02ld",(long)minute, second];
            } else{
               weakSelf.currentLabel.text = [NSString stringWithFormat:@"00:%02ld",(long)current];
            }
        }
        self.currentTime = time;
    }];
    self.observer = timeObserver;
    
}


- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.observer) {
        [self.player removeTimeObserver:self.observer];
        self.observer = nil;
    }
}

- (MusicView *)musicView{
    if (!_musicView) {
        _musicView = [[MusicView alloc] init];
    }
    return _musicView;
}
-(void)playerItemDidReachEnd{
    [self  PlayOrPause];
    NSLog(@"结束======");
}
-(void)PlayerItemTimeJumped{
    if (!playerLoadings) {
        playerLoadings=YES;
        self.playerLoading(NO);
        self.commentBtn.selected = YES;
        self.coverImageView= [self rotate360DegreeWithImageView:self.coverImageView];
    }
    
}
#pragma mark -旋转动画
-(UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView{
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(M_PI, 0.0, 0.0, 1.0) ];
    animation.duration = 2;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
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
