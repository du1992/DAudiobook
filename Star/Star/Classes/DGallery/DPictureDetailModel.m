//
//  DPictureDetailModel.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DPictureDetailModel.h"

@implementation DPictureDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //预防闪退
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    //对特殊字段处理
    if ([key isEqualToString:@"pageCount"]) {
        _pageCount=[value integerValue];
    }
}

-(NSString *)description
{
    NSString *string=[NSString stringWithFormat:@"%@",_imgUrl];
    return string;
}

@end
