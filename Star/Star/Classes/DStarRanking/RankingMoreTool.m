//
//  RankingMoreTool.m
//  Star
//
//  Created by JUNE_EN on 15/6/3.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "RankingMoreTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
@implementation RankingMoreTool
+(NSArray *)rankingMore:(NSString *)htmlString
{
   
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (nil ==htmlStr ||htmlStr.length < 5000)return nil;
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"wrapper1220 cm_block03\">"];
    if (startRange.location == NSNotFound)return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"<div style=\"clear:both\">"];
    if (endRange.location == NSNotFound)return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
     NSMutableArray *starInfo=[NSMutableArray array];
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *allArray=[xpathParser searchWithXPathQuery:@"//ul"];
    TFHppleElement *firstElement=allArray.lastObject;
    for (TFHppleElement *element in firstElement.children) {
        NSMutableDictionary *mutDict=[NSMutableDictionary dictionary];
        if ([element.tagName isEqualToString:@"li"]) {
            TFHppleElement *child=element.children.firstObject;
            NSDictionary *dict=[child attributes];
            NSString *linkUrl=[dict objectForKey:@"href"];
            if (nil !=linkUrl) {
                [mutDict setObject:linkUrl forKey:@"linkUrl"];
            }
            TFHppleElement *sub=child.children.firstObject;
            NSDictionary *imgDict=[sub attributes];
            NSString *imgUrl=[imgDict objectForKey:@"src"];
            if (nil !=imgUrl) {
                [mutDict setObject:imgUrl forKey:@"imgUrl"];
            }
            NSString *name=[imgDict objectForKey:@"alt"];
            if (nil !=name) {
                 [mutDict setObject:name forKey:@"name"];
            }
            [starInfo addObject:mutDict];
        }
    }

    return starInfo;
    
}

@end
