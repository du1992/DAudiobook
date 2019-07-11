//
//  DPostModel.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DBaseModel.h"
#import <BmobSDK/Bmob.h>

NS_ASSUME_NONNULL_BEGIN

@interface DPostModel : DBaseModel

/**内容**/
@property (nonatomic, strong) NSString *content;
/**头像**/
@property (nonatomic, strong) NSString *userLogo;
/**昵称**/
@property (nonatomic, strong) NSString *nickName;
/**ID**/
@property (nonatomic, strong) NSString *authorID;
/**是否匿名**/
@property (nonatomic, strong) NSString *isAnonymous;

/**数据处理**/
-(void)modelDealWith:(BmobObject *)obj;

/**cell高度**/
@property (nonatomic)  CGFloat cellHeight;

/**获取高度**/
-(void)calculateHeight;

@end

NS_ASSUME_NONNULL_END
