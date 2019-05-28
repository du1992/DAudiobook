//
//  DPictureCell.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/19.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DPictureCell : DTableViewCell
/** 照片*/
@property (nonatomic ,strong) UIImageView *dynamicImageView;
/** 标题*/
@property (nonatomic ,strong) UILabel     *titleLabel;
/** 底图*/
@property (strong, nonatomic) UIView      *pictureView;

@end

NS_ASSUME_NONNULL_END
