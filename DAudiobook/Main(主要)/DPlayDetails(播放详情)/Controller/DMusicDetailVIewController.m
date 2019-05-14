//
//  DMusicDetailVIewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/7.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DMusicDetailVIewController.h"

@interface DMusicDetailVIewController ()

@property(nonatomic, strong) NSTimer *timer;

@end

@implementation DMusicDetailVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.timer =[NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    
}
-(void)timerAct{
    [self.musicDetailView interfaceRefresh];
}
-(DMusicDetailView*)musicDetailView{
    if (!_musicDetailView) {
        _musicDetailView=[DMusicDetailView new];
        _musicDetailView.frame=self.view.frame;
        [_musicDetailView.backBtn addTarget:self action:@selector(backAction)
                                            forControlEvents:UIControlEventTouchUpInside];
        [_musicDetailView.sliderProgress addTarget:self action:@selector(sliderProgress) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:_musicDetailView];
    }
    return  _musicDetailView;
}
-(void)backAction{
    
     [self dismissViewControllerAnimated:YES completion:nil];
}
//播放进度
- (void)sliderProgress{
    
    [[DPlayerManager defaultManager] playerProgressWithProgressFloat:_musicDetailView.sliderProgress.value];
}

//上一首
- (void)previous{
    [[DPlayerManager defaultManager] playPrevious];
}
//下一首
- (void)nextAction{
    [[DPlayerManager defaultManager] playNext];
}
//播放暂停
- (void)playAndPause{
    [DPlayerManager defaultManager].isPlay=![DPlayerManager defaultManager].isPlay;
    self.musicDetailView.playAndPauseBtn.selected=[DPlayerManager defaultManager].isPlay;
    [[DPlayerManager defaultManager] playAndPause];
}


//单曲循环
- (void)singlecycle{
    [DPlayerManager defaultManager].isSinglecycle=![DPlayerManager defaultManager].isSinglecycle;
     self.musicDetailView.singlecycleBtn.selected =[DPlayerManager defaultManager].isSinglecycle;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
    
}
@end
