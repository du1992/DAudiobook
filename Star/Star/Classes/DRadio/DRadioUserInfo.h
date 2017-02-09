//
//  DRadioUserInfo.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/7.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRadioUserInfo : NSObject
/**
 *  用户编号
 */
@property (nonatomic,assign) NSUInteger uid;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString *uname;
/**
 *  用户头像
 */
@property (nonatomic,copy) NSString *icon;
@end
