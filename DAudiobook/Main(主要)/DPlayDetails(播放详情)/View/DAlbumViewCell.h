//
//  DAlbumViewCell.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/26.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DAlbumViewCell : DTableViewCell

/**
 *  标题
 */
@property (strong, nonatomic)  UILabel *titleLabel;

/**
 *  电台简介
 */
@property (strong, nonatomic)  UILabel *desLabel;


@end

NS_ASSUME_NONNULL_END
