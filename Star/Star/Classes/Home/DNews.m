//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DNews.h"

@implementation DNews
- (instancetype)initWithDict:(NSDictionary *)dict{
    self=[super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)newsWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
}

- (BOOL)isEqual:(id)other
{
    DNews *new=other;
    if ([self.title isEqualToString:new.title] && [self.linkUrl isEqual:new.linkUrl]) {
        return YES;
    }else{
        return NO;
    }
}

- (NSUInteger)hash
{
      return [self.title hash] ^ [self.linkUrl hash];
}
@end
