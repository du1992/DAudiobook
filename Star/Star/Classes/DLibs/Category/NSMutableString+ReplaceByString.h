//
//  NSMutableString+ReplaceByString.h
//  Star
//
//  Created by JUNE_EN on 15/5/31.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (ReplaceByString)
//替换可变字符串中得某个字符串 用xx替换
- (void)replaceString:(NSString *)search by:(NSString *)replace;
@end
