//
//  ToolOfPhotos.m
//  Star
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "ToolOfPhotos.h"

@implementation ToolOfPhotos

//实现抓取html数据方法
+(NSMutableArray *)photosData:(NSString *)htmlString{
    
    
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    
    if (htmlStr == nil) {
        return nil;
    }
    
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"box\">"];
     if (startRange.location == NSNotFound) return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"<div id=\"page\">"];
    if (endRange.location == NSNotFound) return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableArray *photosInfo=[NSMutableArray array];
    TFHpple *parser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *photosElement=[parser searchWithXPathQuery:@"//li"];
    
    for (TFHppleElement *element in photosElement) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        for (TFHppleElement *childElemnt in element.children) {
            if ([childElemnt.tagName isEqualToString:@"a"]) {
                NSDictionary *childDict=[childElemnt attributes];
                NSString *linkUrl=[childDict objectForKey:@"href"];
                [dict setObject:linkUrl forKey:@"linkUrl"];
                
                TFHppleElement *imgElement= [childElemnt.children lastObject];
                NSDictionary *imgDict=[imgElement attributes];
                NSString *imgUrl=[imgDict objectForKey:@"src"];
                NSString *title=[imgDict objectForKey:@"title"];
                [dict setObject:imgUrl forKey:@"imgUrl"];
                [dict setObject:title forKey:@"title"];
                [photosInfo addObject:dict];
                continue;
            }
            
        }
    }
    
    return photosInfo;
    
}
@end
