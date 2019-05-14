//
//  DBaseRequest.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface DBaseRequest : NSObject

+ (void)POST:(NSString *)URLString parameters:(nullable id)parameters block:(nullable void (^)( id __nullable input, NSError * __nullable error))block;


+ (void)GET:(NSString *)URLString parameters:(nullable id)parameters block:(nullable void (^)( id __nullable input, NSError * __nullable error))block;



@end

NS_ASSUME_NONNULL_END
