//
//  DVideoModel.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVideoModel : DBaseModel

@property (nonatomic, strong) NSString *img;

@property (nonatomic, strong) NSString *mp4_url;

@property (nonatomic, strong) NSString *title;


@end

NS_ASSUME_NONNULL_END
