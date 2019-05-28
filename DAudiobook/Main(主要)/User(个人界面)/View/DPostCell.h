//
//  DPostTableViewCell.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPostCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DPostCell : DTableViewCell

@property(nonatomic,strong)UIView      *backgroundsView;
@property(nonatomic,strong)UIImageView *userLogoImageView;
@property(nonatomic,strong)UILabel     *nameLabel;
@property(nonatomic,strong)UILabel     *contentLabel;
@property(nonatomic,strong)UILabel     *timeLabel;


@end

NS_ASSUME_NONNULL_END
