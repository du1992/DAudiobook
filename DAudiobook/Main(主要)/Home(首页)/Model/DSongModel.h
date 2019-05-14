//
//  DSongModel.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/26.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DSongModel : DBaseModel

/**
 *  标题
 */
@property (nonatomic,strong) NSString *title;
/**
 *  配图
 */
@property (nonatomic,strong) NSString *coverimg;
/**
 *  介绍
 */
@property (nonatomic, strong) NSString * trackIntro;
/**
 *  歌曲链接
 */
@property (nonatomic,strong) NSString *musicUrl;
/**
 *  播放ID
 */
@property (nonatomic, assign) NSInteger trackId;



@end

NS_ASSUME_NONNULL_END
