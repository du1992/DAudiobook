//
//  StarInfo.h
//  Star
//
//  Created by JUNE_EN on 15/6/1.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StarInfo : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *linkUrl;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *detail;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)starInfoWithDict:(NSDictionary *)dict;
@end
