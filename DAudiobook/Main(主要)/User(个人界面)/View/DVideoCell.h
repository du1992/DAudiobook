//
//  DVideoCell.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewCell.h"
#import "DVideoPlayer.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVideoCell : DTableViewCell
/** 播放封面 */
@property (strong, nonatomic)  UIImageView *videoImageView;
/** 播放标题 */
@property (strong, nonatomic)  UILabel     *videoTitle;
/** 播放标识 */
@property (strong, nonatomic) UIImageView  *playImageView;


@end

NS_ASSUME_NONNULL_END
