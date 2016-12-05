//
//  Rankng.m
//  Star
//
//  Created by lanou3g on 15/5/28.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "Ranking.h"

@implementation Ranking
- (instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)rankingWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}
@end
