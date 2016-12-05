//
//  DPictureModel.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DPictureModel.h"

@implementation DPictureModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //防止封装model时闪退
}

//该方法用于封装model （需要给个字典）
+(id)setModelWithDictionary:(NSDictionary *)dictionary
{
    DPictureModel *model=[[DPictureModel alloc]init];
    [model setValuesForKeysWithDictionary:dictionary];
    return model;
}

-(NSString *)description
{
    NSString *string=[NSString stringWithFormat:@"%@",_title];
    return string;
}


//比较
- (BOOL)isEqual:(id)other
{
    DPictureModel *new=other;
    if ([self.title isEqualToString:new.title] && [self.linkUrl isEqual:new.linkUrl]) {
        return YES;
    }else{
        return NO;
    }
}

@end
