//
//  StarInfoTool.m
//  Star
//
//  Created by JUNE_EN on 15/6/1.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarInfoTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
@implementation StarInfoTool
+(NSMutableArray *)starInfo:(NSString *)htmlString
{
    NSMutableArray *starInfos=[NSMutableArray array];
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (nil ==htmlStr ||htmlStr.length < 5000) return nil;
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"block03\">"];
    if (startRange.location == NSNotFound)return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"<div class=\"gengduo_xiaoxi\""];
    if (endRange.location == NSNotFound)return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//dd"];
    NSArray *liElements=[xpathParser searchWithXPathQuery:@"//li"];
    
    for (TFHppleElement *element in elements) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        NSArray *childArray=element.children;
        for (TFHppleElement *chElement in childArray) {
            if ([chElement.tagName isEqualToString:@"a"]) {
                NSDictionary *childDict=[chElement attributes];
                NSString *linkUrl=[childDict objectForKey:@"href"];
                [dict setObject:linkUrl forKey:@"linkUrl"];
                TFHppleElement *imgElement= [chElement.children lastObject];
                NSDictionary *imgDict=[imgElement attributes];
                NSString *imgUrl=[imgDict objectForKey:@"src"];
                NSString *title=[imgDict objectForKey:@"alt"];
                if (nil ==imgUrl)continue;
                [dict setObject:imgUrl forKey:@"imgUrl"];
                [dict setObject:title forKey:@"title"];
                
            }
            if([chElement.tagName isEqualToString:@"p"]){
                NSString *detail=chElement.text;
                [dict setObject:detail forKey:@"detail"];
            }
        }
        [starInfos addObject:dict];
        
    }
    
    for (TFHppleElement *element in liElements) {
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        TFHppleElement *aElement= [element.children lastObject];
        NSDictionary *imgDict=[aElement attributes];
        NSString *linkUrl=[imgDict objectForKey:@"href"];
        NSString *title=aElement.text;
        [dict setObject:title forKey:@"title"];
        [dict setObject:linkUrl forKey:@"linkUrl"];
        [starInfos addObject:dict];
    }

    return starInfos;
    
}

@end
