//
//  StarSelfInfo.h
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//  明星个人资料

#import <Foundation/Foundation.h>

@interface StarSelfInfo : NSObject
@property (nonatomic,copy) NSString *detailInfo;
@property (nonatomic,copy) NSString *birthday;
/**
 *  星座
 */
@property (nonatomic,copy) NSString *constellation;
/**
 *  身高
 */
@property (nonatomic,copy) NSString *height;
/**
 *  体重
 */
@property (nonatomic,copy) NSString *weight;
/**
 *  职业
 */
@property (nonatomic,copy) NSString *job;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)selfInfoWithDict:(NSDictionary *)dict;

@end
