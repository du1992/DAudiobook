//
//  AFnet.h
//  AFNetworking
//
//  Created by JUNE_EN on 15/6/9.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "AFHTTPSessionManager.h"
@interface AFNetMonitor  : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
