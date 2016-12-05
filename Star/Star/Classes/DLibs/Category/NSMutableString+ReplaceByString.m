//
//  NSMutableString+ReplaceByString.m
//  Star
//
//  Created by JUNE_EN on 15/5/31.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "NSMutableString+ReplaceByString.h"

@implementation NSMutableString (ReplaceByString)
//不要出现这种情况 比如 将<a  替换成 <a ss  这样会出现死循环
- (void)replaceString:(NSString *)search by:(NSString *)replace{
    NSRange substr = [self rangeOfString:search];
    while (substr.location != NSNotFound) {
        [self replaceCharactersInRange:substr withString:replace];
        substr = [self rangeOfString:search];
    }
}
@end
