//
//  DRadioAllList.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/7.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DRadioUserInfo;
@interface DRadioAllList : NSObject
/**
 *  电台编号
 */
@property (nonatomic,copy) NSString *radioid;
/**
 *  电台标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  配图
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  电台用户信息
 */
@property (nonatomic,strong) DRadioUserInfo *userinfo;
/**
 *  关注人数
 */
@property (nonatomic,assign) NSUInteger count;
/**
 *  电台描述
 */
@property (nonatomic,copy) NSString *desc;
/**
 *  是不是最新的
 */
@property (nonatomic,assign,getter=isnew) BOOL isnew;


@end
