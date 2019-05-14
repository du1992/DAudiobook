//
//  DMusicDetailView.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/7.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMusicDetailView : DView

//返回按钮
@property (strong, nonatomic) UIButton *backBtn;
//歌曲名
@property (strong, nonatomic)  UILabel *songLB;



//歌词
@property (strong, nonatomic)  UILabel *songerLB;
//背景高斯模糊图片
@property (strong, nonatomic)  UIImageView *bgImageVIew;
//歌曲icon(中间转圈的图片)
@property (strong, nonatomic)  UIImageView *songIcon;



//当前播放时间
@property (strong, nonatomic)  UILabel *currentTimeLB;
//总时间
@property (strong, nonatomic)  UILabel *totalTimeLB;
//歌曲播放进度条
@property (strong, nonatomic)  UISlider *sliderProgress;
//最近播放按钮
@property (strong, nonatomic)  UIButton *singlecycleBtn;
//上一首按钮
@property (strong, nonatomic)  UIButton *previousBtn;
//播放和暂停按钮
@property (strong, nonatomic)  UIButton *playAndPauseBtn;
//下一首按钮
@property (strong, nonatomic)  UIButton *nextBtn;
//播放列表
@property (strong, nonatomic)  UIButton *listBtn;




//界面刷新
-(void)interfaceRefresh;

@end

NS_ASSUME_NONNULL_END
