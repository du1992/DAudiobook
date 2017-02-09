//
//  DRadioSecondHeaderView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicView : UIView
/**
 *  歌曲序号
 */
@property (nonatomic,assign) NSUInteger songid;
@property (nonatomic,assign,getter=isPlaying) BOOL playing;

- (void)pause;

@end
