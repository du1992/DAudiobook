//
//  DPlayMusicView.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPlayMusicView.h"

@interface DPlayMusicView ()

@end



@implementation DPlayMusicView

- (void)setLayout{
    
    self.backgroundColor=ImportantColor;
    
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detailsClick)];
    [self addGestureRecognizer:tap];
    
    
    //给音乐图标设置约束
   [self.musicIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(@40);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
    }];
    
    //给按钮设置约束
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-20);
    }];
    
    [self.songNamelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.musicIconImageView.mas_right);
        make.top.equalTo(self.musicIconImageView.mas_top);
        make.right.equalTo(self.playButton.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [self.singerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.musicIconImageView.mas_right);
        make.top.equalTo(self.songNamelabel.mas_bottom);
        make.right.equalTo(self.playButton.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(-0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
    
    self.singerLabel.text=@"可以选择列表播放";
    self.songNamelabel.text=@"还未播放";
    
    DPlayerManager *manager = [DPlayerManager defaultManager];
    manager.isStartPlayer = ^(NSInteger index) {//0是开始 1 暂停
        if (index==0) {//开启定时器
            [self startTimer];
          
        }else if(index==1){
            [self stopTimer];
        }else{}
    };
    
    
}


- (void)detailsClick
{
   if (self.bottomMusicBlock) {
        self.bottomMusicBlock();
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selected"]) {

        NSInteger NewSelected = [change[@"new"] integerValue];
        if (NewSelected == 1) {
            self.playButton.selected = YES;
        }else{
            self.playButton.selected = NO;
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
        [self addSubview:_songNamelabel];
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
        [self addSubview:_singerLabel];
    }
    return _singerLabel;
}
-(UIImageView*)musicIconImageView{
    if (!_musicIconImageView) {
        _musicIconImageView = [[UIImageView alloc] init];
        _musicIconImageView.image = [UIImage imageNamed:@"音乐"];
        _musicIconImageView.layer.cornerRadius=20;
        _musicIconImageView.clipsToBounds = YES;
        [self addSubview:_musicIconImageView];
    }
    return _musicIconImageView;
}

-(UIButton*)playButton{
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [_playButton setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_playButton setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
        [_playButton addTarget:self action:@selector(playAndPauseBtnClicekd:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_playButton];
        
    }
    return _playButton;
}
-(UISlider*)progressSlider{
    if (!_progressSlider) {
        //进度条
        _progressSlider=[[UISlider alloc]init];
        [self addSubview:_progressSlider];
        _progressSlider.maximumTrackTintColor = [UIColor whiteColor];
        _progressSlider.minimumTrackTintColor = ImportantColor;
        [_progressSlider setThumbImage:[UIImage new] forState:UIControlStateNormal];
        [_progressSlider setThumbImage:[UIImage new] forState:UIControlStateHighlighted];
        _progressSlider.value=0;
    }
    return _progressSlider;
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




//播放暂停
-(void)playAndPauseBtnClicekd:(UIButton *)btn{
    if (!self.songModel) {
        return;
    }
    self.playButton.selected=[DPlayerManager defaultManager].isPlay;
   
    if ([DPlayerManager defaultManager].isFristPlayerPauseBtn==NO) {
        [[DPlayerManager defaultManager] reloadDataWithIndex:0];//标记是不是没点列表直接点了播放按钮如果是就默认播放按钮
    }else{
        [[DPlayerManager defaultManager] playAndPause];
    }
    [DPlayerManager defaultManager].isFirstClickedListPlayer=0;
    
}
//是否在播放歌曲(主要作用是替换播放暂停按钮的图片)
-(void)setIsSongPlayer:(BOOL)isSongPlayer{
    self.playButton.selected = isSongPlayer;
    
}
//定时器
-(void)timerAct{
    
    if ([DPlayerManager defaultManager].player.currentTime.timescale == 0 || [DPlayerManager defaultManager].player.currentItem.duration.timescale == 0 ) {
        return;
    }
    // 获得当前时间
    long long int currentTime = [DPlayerManager defaultManager].player.currentTime.value / [DPlayerManager defaultManager].player.currentTime.timescale;
    
    // 获得音乐总时长
    long long int totalTime = [DPlayerManager defaultManager].player.currentItem.duration.value / [DPlayerManager defaultManager].player.currentItem.duration.timescale;
    NSString *str = [NSString stringWithFormat:@"%lld",totalTime];
    [DPlayerManager defaultManager].totalTime=str;
       

    
    
    self.progressSlider.maximumValue = totalTime;
    self.progressSlider.minimumValue = 0;
    self.progressSlider.value = currentTime;//当前播放进度
    
    if (self.progressSlider.value == totalTime) {//如果progressSlider的值=总时长 就直接下一首(或者单曲循环)
        [DPlayerManager defaultManager].totalTime=@"";
        [[DPlayerManager defaultManager] autoNext];
    }
    if ([DPlayerManager defaultManager].isPlay) {//正在播放歌曲时头像转动
        [UIView beginAnimations:@"rzoration" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.musicIconImageView.transform = CGAffineTransformRotate(self.musicIconImageView.transform, 0.02);
        [UIView commitAnimations];
    }
    
    DSongModel *songModel = [[DPlayerManager defaultManager] currentSongModel];
    self.songModel=songModel;
    
    // 改变图片 标题 音频
    [self.musicIconImageView sd_setImageWithURL:[NSURL URLWithString:songModel.coverimg] placeholderImage:[UIImage imageNamed:@"musicicon"]];
    self.songNamelabel.text = songModel.title;
    self.singerLabel.text   = songModel.trackIntro;
}
//定时器
-(void)startTimer{
    
    self.timer =[NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}

@end
