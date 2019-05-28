//
//  DPictureModel.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/19.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPictureModel : DBaseModel
/**图片标题**/
@property(nonatomic,copy)NSString *title;
/**图片地址**/
@property(nonatomic,copy)NSString *image_url;
/**cell高度**/
@property (nonatomic)  CGFloat cellHeight;
/**图片高度**/
@property (nonatomic)  CGFloat imageHeight;
/**图片宽度**/
@property (nonatomic)  CGFloat imageWidth;

/**获取高度**/
-(void)calculateHeight:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
