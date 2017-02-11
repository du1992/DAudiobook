//
//  DRadioSecondHeaderView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class DRadioSecondListModel;
@interface RadioMusicView : UIView

/**
 *  进度条
 */
@property (nonatomic,strong) UIProgressView *progressView;
/**
 *  显示时间
 */
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerItem *itemPlayer;
@property (nonatomic,assign,getter=isPlaying) BOOL playing;


- (void)passRadioMessage:(DRadioSecondListModel *)listModel andName:(NSString *)name;

@property (nonatomic, copy)  void (^playerLoading) (BOOL loading);

@end
