//
//  Rankingt.m
//  Star
//
//  Created by lanou3g on 15/5/31.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "RankingTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
@implementation RankingTool

+(NSMutableArray *)startChart:(NSString *)htmlString
{
    NSMutableArray *starChartInfo=[NSMutableArray array];
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (nil ==htmlStr || htmlStr.length < 5000) return nil;
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"lm_name\"><i>"];
    if (startRange.location == NSNotFound)return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"<div class=\"links_bg\">"];
    if (endRange.location == NSNotFound)return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//dd"];
    
    
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
                NSString *name=[imgDict objectForKey:@"title"];
                if (nil ==imgUrl)continue;
                [dict setObject:imgUrl forKey:@"imgUrl"];
                [dict setObject:name forKey:@"name"];
                
            }
            if([chElement.tagName isEqualToString:@"span"]){
                NSString *heat=chElement.text;
                [dict setObject:heat forKey:@"heat"];
            }
        }
        [starChartInfo addObject:dict];
        
    }
    return starChartInfo;
    
}
@end
