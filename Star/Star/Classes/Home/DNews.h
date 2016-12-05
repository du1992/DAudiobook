//

//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
// 明星最新资讯model

#import <Foundation/Foundation.h>

@interface DNews : NSObject
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  图片链接
 */
@property (nonatomic,copy) NSString *imgUrl;
/**
 *  详情链接
 */
@property (nonatomic,copy) NSString *linkUrl;
/**
 *  日期
 */
@property (nonatomic,copy) NSString *date;
/**
 *  涉及的明星
 */
@property (nonatomic,copy) NSString *aboutStar;
/**
 *  描述
 */
@property (nonatomic,copy) NSString *descrip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)newsWithDict:(NSDictionary *)dict;
@end
