//
//  DMusicDetailView.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/7.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DMusicDetailView.h"
@interface DMusicDetailView ()
@property (strong, nonatomic)  UIView *bgShadowView;
@end

@implementation DMusicDetailView

- (void)setLayout{
    
    [self.bgImageVIew mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    
    [self.bgShadowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    
    
    
    [self.songIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(300, 300));
        make.center.mas_equalTo(self);
    }];
    
    
    [self.backBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.top.mas_equalTo(self.mas_top).offset(35);
    }];
    
   
    [self.songLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(35);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left).offset(40);
        make.right.mas_equalTo(self.mas_right).offset(-20);
     }];
    
    [self.songerLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.songLB.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-100, 60));
    }];
    
    
   
    
    //循环播放按钮
    [self.singlecycleBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(self.mas_left).offset(15);
    }];
    //播放列表
    [self.listBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(self.mas_right).offset(-15);
    }];
    
    
    //播放状态
    [self.playAndPauseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    //上一首
    [self.previousBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.right.mas_equalTo(self.playAndPauseBtn.mas_left).offset(-15);
    }];
    
    //下一首
    [self.nextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(self.playAndPauseBtn.mas_right).offset(15);
    }];
    
    
    
    
    [self.currentTimeLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.playAndPauseBtn.mas_top).offset(-15);
        make.left.mas_equalTo(self.left).offset(15);
    }];
    
    [self.totalTimeLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.playAndPauseBtn.mas_top).offset(-15);
        make.right.mas_equalTo(self.right).offset(-15);
    }];
   
    [self.sliderProgress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.currentTimeLB.mas_centerY);
        make.left.mas_equalTo(self.currentTimeLB.mas_right).offset(10);
        make.right.mas_equalTo(self.totalTimeLB.mas_left).offset(-10);
    }];
    
   
}

//界面刷新
-(void)interfaceRefresh{
    NSLog(@"播放=====%d",[DPlayerManager defaultManager].isPlay);
    
    self.singlecycleBtn.selected =[DPlayerManager defaultManager].isSinglecycle;
    self.playAndPauseBtn.selected=[DPlayerManager defaultManager].isPlay;
    
 
   
    DSongModel *songModel = [[DPlayerManager defaultManager] currentSongModel];
 
   [self.songIcon sd_setImageWithURL:[NSURL URLWithString:songModel.coverimg] placeholderImage:ImageNamed(@"timeline_image_placeholder")];
    [self.bgImageVIew sd_setImageWithURL:[NSURL URLWithString:songModel.coverimg] placeholderImage:ImageNamed(@"timeline_image_placeholder")];
    
   
    self.songLB.text   = [NSString stringWithFormat:@"%@",songModel.title];
    self.songerLB.text = [NSString stringWithFormat:@"-- %@ --",songModel.trackIntro];
    
    NSString *time=[DPlayerManager defaultManager].totalTime;
    
    self.totalTimeLB.text = [NSString stringWithFormat:@"%02ld:%02ld", [time integerValue] / 60, [time integerValue] % 60];;
    self.sliderProgress.maximumValue =[time doubleValue];
    
    NSInteger value=[DPlayerManager defaultManager].player.currentTime.value;
    NSInteger timescale=[DPlayerManager defaultManager].player.currentTime.timescale;
    NSInteger currentTime;
    if (value==0||timescale==0) {
        currentTime= 0;
    }else{
        currentTime= value/timescale;
    }
    
    self.currentTimeLB.text = [NSString stringWithFormat:@"%02ld:%02ld", currentTime / 60, currentTime % 60];
    self.sliderProgress.minimumValue = 0;
    self.sliderProgress.value = currentTime;//当前播放进度
    if ([DPlayerManager defaultManager].isPlay) {//正在播放歌曲时头像转动
        [UIView beginAnimations:@"rzoration" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.songIcon.transform = CGAffineTransformRotate(self.songIcon.transform, 0.02);
        [UIView commitAnimations];
    }
    
}


//返回按钮
- (UIButton *)backBtn{
     if (!_backBtn) {
        _backBtn = [[UIButton alloc] init];
        [_backBtn setImage:ImageNamed(@"arrow") forState:UIControlStateNormal];
        [self addSubview:_backBtn];
    }
    return _backBtn;
}
//歌曲名
- (UILabel *)songLB{
    if (!_songLB) {
        _songLB = [[UILabel alloc] init];
        _songLB.textColor=[UIColor whiteColor];
        _songLB.font=AppFont(16);
        _songLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_songLB];
    }
    return _songLB;
}
//歌词
- (UILabel *)songerLB{
    if (!_songerLB) {
        _songerLB = [[UILabel alloc] init];
        _songerLB.textColor=[UIColor whiteColor];
        _songerLB.font=AppFont(14);
        _songerLB.textAlignment = NSTextAlignmentCenter;
        _songerLB.numberOfLines = 0;
        [self addSubview:_songerLB];
    }
    return _songerLB;
}
//背景高斯模糊图片
- (UIImageView *)bgImageVIew{
    if (!_bgImageVIew) {
        _bgImageVIew = [[UIImageView alloc] init];
        [self addSubview:_bgImageVIew];
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame =CGRectMake(0, 0,kScreenWidth, kScreenHeight);
        [_bgImageVIew addSubview:effectView];
       
    }
    return _bgImageVIew;
}
//歌曲icon(中间转圈的图片)
- (UIImageView *)songIcon{
    if (!_songIcon) {
        _songIcon = [[UIImageView alloc] init];
        _songIcon.layer.cornerRadius = 150;
        _songIcon.layer.masksToBounds = YES;
        [self addSubview:_songIcon];
    }
    return _songIcon;
}

//当前播放时间
- (UILabel *)currentTimeLB{
    if (!_currentTimeLB) {
        _currentTimeLB = [[UILabel alloc] init];
        _currentTimeLB.textColor=[UIColor whiteColor];
        _currentTimeLB.font=AppFont(14);
        [self addSubview:_currentTimeLB];
    }
    return _currentTimeLB;
}
//总时间
- (UILabel *)totalTimeLB{
    if (!_totalTimeLB) {
        _totalTimeLB = [[UILabel alloc] init];
        _totalTimeLB.textColor=[UIColor whiteColor];
        _totalTimeLB.font=AppFont(14);
        [self addSubview:_totalTimeLB];
    }
    return _totalTimeLB;
}

//歌曲播放进度条
- (UISlider *)sliderProgress{
    if (!_sliderProgress) {
        _sliderProgress = [[UISlider alloc] init];
         _sliderProgress.minimumTrackTintColor =ImportantColor;
        [_sliderProgress setThumbImage:ImageNamed(@"icon_point1") forState:UIControlStateNormal];
        [self addSubview:_sliderProgress];
    }
    return _sliderProgress;
}
//播放状态按钮
- (UIButton *)singlecycleBtn{
    if (!_singlecycleBtn) {
        _singlecycleBtn = [[UIButton alloc] init];
        [_singlecycleBtn setImage:ImageNamed(@"singlecycleSel") forState:UIControlStateNormal];
        [_singlecycleBtn setImage:ImageNamed(@"singlecycle") forState:UIControlStateSelected];
        [self addSubview:_singlecycleBtn];
    }
    return _singlecycleBtn;
}
//上一首按钮
- (UIButton *)previousBtn{
    if (!_previousBtn) {
        _previousBtn = [[UIButton alloc] init];
        [_previousBtn setImage:ImageNamed(@"icons_previous_music1") forState:0];
        [self addSubview:_previousBtn];
    }
    return _previousBtn;
}

//播放和暂停按钮
- (UIButton *)playAndPauseBtn{
    if (!_playAndPauseBtn) {
        _playAndPauseBtn = [[UIButton alloc] init];
        [_playAndPauseBtn setImage:ImageNamed(@"icons_stop_music1") forState:0];
        [_playAndPauseBtn setImage:ImageNamed(@"icons_play_music1") forState:UIControlStateSelected];
        [self addSubview:_playAndPauseBtn];
    }
    return _playAndPauseBtn;
}
//下一首按钮
- (UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        [_nextBtn setImage:ImageNamed(@"icons_next_music1") forState:UIControlStateNormal];
        [self addSubview:_nextBtn];
    }
    return _nextBtn;
}
//播放列表
- (UIButton *)listBtn{
    if (!_listBtn) {
        _listBtn = [[UIButton alloc] init];
        [_listBtn setImage:ImageNamed(@"目录") forState:0];
        [self addSubview:_listBtn];
    }
    return _listBtn;
}

- (UIView *)bgShadowView{
    if (!_bgShadowView) {
        _bgShadowView = [[UIView alloc] init];
        _bgShadowView.backgroundColor=AppAlphaColor(0,0,0,0.2);
        [self addSubview:_bgShadowView];
    }
    return _bgShadowView;
}



@end
