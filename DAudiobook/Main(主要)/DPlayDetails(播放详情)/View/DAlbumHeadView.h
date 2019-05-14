//
//  DAlbumHeadView.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/27.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DAlbumHeadView : DView

/*封面背景*/
@property(nonatomic,strong)UIImageView   *bgImageView;
/*封面*/
@property(nonatomic,strong)UIImageView   *coverImageView;
/*标题*/
@property(nonatomic,strong)UILabel       *titleLabel;
/*描述*/
@property(nonatomic,strong)UILabel       *introduceLabel;



@end

NS_ASSUME_NONNULL_END
