//
//  StarSelfInfo.m
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarSelfInfo.h"

@implementation StarSelfInfo
- (instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)selfInfoWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end
