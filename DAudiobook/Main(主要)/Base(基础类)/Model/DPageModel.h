//
//  DPageModel.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/24.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface DPageModel : NSObject<NSCopying>

/** 页码 默认     */
@property (nonatomic, assign) NSInteger page;
/** 每页条数      */
@property (nonatomic, assign) NSInteger count;


@end



@interface DPageModel (TC)

/**
 *  @{@"pageSize":iString(self.count),@"currentPage":iString(self.page)};
 *
 *  @return 字典
 */
- (NSDictionary *)pageOutput;

@end

NS_ASSUME_NONNULL_END
