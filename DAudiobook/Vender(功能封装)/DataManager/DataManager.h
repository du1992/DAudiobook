//
//  DataManager.h
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/18.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

#define DUserDefaultsSET(object,key)  [DataManager setDataKey:key data:object]// 写
#define DUserDefaultsGET(key)         [DataManager getDataKey:key]// 取
#define DUserDefaultsRemove(key)      [DataManager removeObjectForKey:key]// 删

//收藏
#define kDiscuss @"kdiscuss"


@interface DataManager : NSObject

//获取数据
+(id)getDataKey:(NSString*)key;

//设置数据
+(void)setDataKey:(NSString *)key data:(id)data;

//删除
+(void)removeObjectForKey:(NSString *)key;

@end
NS_ASSUME_NONNULL_END
