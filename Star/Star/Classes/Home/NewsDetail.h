//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.


#import <Foundation/Foundation.h>

@interface NewsDetail : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *source;
@property (nonatomic,copy) NSString *introduction;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *imgDescrip;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *pageCount;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)newsDetailWithDict:(NSDictionary *)dict;
@end
