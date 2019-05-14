//
//  DSideMenuTableViewCell.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DSideMenuTableViewCell : DTableViewCell

/** 描绘*/
@property (strong, nonatomic) UILabel     *describeLabel;
/** 图标*/
@property (strong, nonatomic) UIImageView *iconImageView;
/** 分割线*/
@property (strong, nonatomic) UIView      *lineView;

@end

NS_ASSUME_NONNULL_END
