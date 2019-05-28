//
//  DJokesModel.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/15.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DJokesModel : DBaseModel

/**内容**/
@property(strong,nonatomic)NSString* text;
/**cell高度**/
@property (nonatomic)  CGFloat cellHeight;
/**背景颜色**/
@property (nonatomic) int R;
@property (nonatomic) int G;
@property (nonatomic) int B;

/**获取高度**/
-(void)calculateHeight;

@end

NS_ASSUME_NONNULL_END
