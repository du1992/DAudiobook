//
//  DRadioListCell.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DRadioListCell : DTableViewCell

/**
 *  配图
 */
@property (strong, nonatomic) UIImageView *coverImageView;
/**
 *  标题
 */
@property (strong, nonatomic) UILabel *titleLabel;
/**
 *  简介
 */
@property (strong, nonatomic) UILabel *desLabel;
/**
 *  电台收听量
 */
@property (strong, nonatomic)  UILabel *countLabel;
/**
 *  分割线
 */
@property (strong, nonatomic)  UIView *lineView;


@end

NS_ASSUME_NONNULL_END
