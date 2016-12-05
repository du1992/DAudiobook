//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.

#import "DHeaderScrollTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
@implementation DHeaderScrollTool
+(NSArray *)headerPhotos:(NSString *)htmlString{
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (htmlStr.length < 5000 ||nil ==htmlStr)return nil;
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"hd_box\""];
    if (startRange.location == NSNotFound)return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];

    NSRange endRange=[startStr rangeOfString:@"<div class=\"hd_num\""];
    if (endRange.location ==NSNotFound) return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableArray *headerPhotos=[NSMutableArray array];
   
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//li"];

    for (TFHppleElement *element in elements){
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        NSArray *childArray=element.children;
        TFHppleElement *aElement= [childArray firstObject];
        NSDictionary *childDict=[aElement attributes];
        NSString *linkUrl=[childDict objectForKey:@"href"];
        if (linkUrl != nil) {
            [dict setObject:linkUrl forKey:@"linkUrl"];
        }
        TFHppleElement *imgElement= [aElement.children lastObject];
        NSDictionary *imgDict=[imgElement attributes];
        NSString *imgUrl=[imgDict objectForKey:@"src"];
        NSString *title=[imgDict objectForKey:@"alt"];
        if (imgUrl != nil) {
            [dict setObject:imgUrl forKey:@"imgUrl"];
        }
        if (title !=nil) {
            [dict setObject:title forKey:@"title"];
        }
        [headerPhotos addObject:dict];
    }
    return  headerPhotos;
}
@end
