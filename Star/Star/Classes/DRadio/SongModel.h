//
//  DRadioSecondHeaderView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SongModel : NSObject
/**
 *  歌词
 */
@property (nonatomic,copy) NSString *lyric_text;
/**
 *  歌名
 */
@property (nonatomic,copy) NSString *song_name;
/**
 *  歌手名
 */
@property (nonatomic,copy) NSString *artist_name;
/**
 *  歌曲缩略图
 */
@property (nonatomic,copy) NSString *logo;
/**
 *  歌曲时间
 */
@property (nonatomic,copy) NSString *play_seconds;
/**
 *  歌曲链接
 */
@property (nonatomic,copy) NSString *track_url;

@end
