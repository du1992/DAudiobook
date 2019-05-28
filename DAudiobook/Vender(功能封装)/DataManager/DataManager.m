//
//  DataManager.m
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/18.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

//获取数据
+(id)getDataKey:(NSString*)key{
    
    NSData *dataObject= [[NSUserDefaults standardUserDefaults]objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:dataObject];
    
    
}
//设置数据
+(void)setDataKey:(NSString *)key data:(id)data{
    NSData *modelObject = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:modelObject
                                              forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//删除
+(void)removeObjectForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
