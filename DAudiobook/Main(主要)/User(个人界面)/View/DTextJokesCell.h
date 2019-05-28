//
//  DTextJokesCell.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/15.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface DTextJokesCell : DTableViewCell

/** 文字*/
@property (strong, nonatomic) UILabel     *textJokesLabel;
/** 底部视图*/
@property (strong, nonatomic) UIView      *textJokesView;


@end

NS_ASSUME_NONNULL_END
