//
//  StarInfo.m
//  Star
//
//  Created by JUNE_EN on 15/6/1.
//  Copyright (c) 2015年 beijing. All rights reserved.
// 明星个人页面model

#import "StarInfo.h"

@implementation StarInfo
- (instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)starInfoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
