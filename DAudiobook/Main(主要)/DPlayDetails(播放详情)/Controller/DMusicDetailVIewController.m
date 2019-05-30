//
//  DMusicDetailVIewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/7.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DMusicDetailVIewController.h"
#import "DChooseMusicView.h"
#import "GDTMobInterstitial.h"

@interface DMusicDetailVIewController ()<GDTMobInterstitialDelegate>{
    GDTMobInterstitial *_interstitialObj;
}

@property(nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) DChooseMusicView *chooseMusicView;

@end

@implementation DMusicDetailVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.musicDetailView interfaceRefresh];
    self.timer =[NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
   
    self.chooseMusicView=[[DChooseMusicView alloc]initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    [self.view addSubview:self.chooseMusicView];
    
    _interstitialObj = [[GDTMobInterstitial alloc] initWithAppId:GDTAppkey placementId:GDTPlacementIdC];
    _interstitialObj.delegate = self;
    [_interstitialObj loadAd];
    
    
}
-(void)timerAct{
    [self.musicDetailView interfaceRefresh];
}
-(DMusicDetailView*)musicDetailView{
    if (!_musicDetailView) {
        _musicDetailView=[DMusicDetailView new];
        _musicDetailView.frame=self.view.frame;
        [_musicDetailView.backBtn addTarget:self action:@selector(backActionClick)
                                            forControlEvents:UIControlEventTouchUpInside];
        [_musicDetailView.sliderProgress addTarget:self action:@selector(sliderProgress) forControlEvents:UIControlEventValueChanged];
        
        
        [_musicDetailView.playAndPauseBtn addTarget:self action:@selector(playAndPauseClick)
                           forControlEvents:UIControlEventTouchUpInside];
        [_musicDetailView.previousBtn addTarget:self action:@selector(previousClick)
                                   forControlEvents:UIControlEventTouchUpInside];
        [_musicDetailView.nextBtn addTarget:self action:@selector(nextActionClick)
                                   forControlEvents:UIControlEventTouchUpInside];
        [_musicDetailView.singlecycleBtn addTarget:self action:@selector(singlecycleClick)
                           forControlEvents:UIControlEventTouchUpInside];
        [_musicDetailView.listBtn addTarget:self action:@selector(listBtnClick)
                                  forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_musicDetailView];
    }
    return  _musicDetailView;
}
-(void)backActionClick{
    
     [self dismissViewControllerAnimated:YES completion:nil];
}
//播放进度
- (void)sliderProgress{
    
    [[DPlayerManager defaultManager] playerProgressWithProgressFloat:_musicDetailView.sliderProgress.value];
}

//上一首
- (void)previousClick{
    [[DPlayerManager defaultManager] autoNext];
}
//下一首
- (void)nextActionClick{
    [[DPlayerManager defaultManager] autoNext];
    NSLog(@"当前播放=====%ld",(long)[DPlayerManager defaultManager].index);
}
//播放或暂停
- (void)playAndPauseClick{
    [[DPlayerManager defaultManager] playAndPause];
}

//单曲循环
- (void)singlecycleClick{
    [DPlayerManager defaultManager].isSinglecycle=![DPlayerManager defaultManager].isSinglecycle;
}
//播放列表
-(void)listBtnClick{
    [self.chooseMusicView show];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.timer invalidate];
    self.timer = nil;
    
}



// 广告预加载成功回调
//
// 详解:当接收服务器返回的广告数据成功后调用该函数
- (void)interstitialSuccessToLoadAd:(GDTMobInterstitial *)interstitial
{
    [_interstitialObj presentFromRootViewController:self];
}






@end
