//
//  StarSelfInfoTool.m
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarSelfInfoTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
@implementation StarSelfInfoTool
+(NSDictionary *)selfInfo:(NSString *)htmlString
{
    NSMutableDictionary *starInfo=[NSMutableDictionary dictionary];
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (nil ==htmlStr ||htmlStr.length < 5000)return nil;
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"wrapper1220 cm_block01\""];
    if (startRange.location == NSNotFound)return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"<div class=\"txt03\">"];
    if (endRange.location == NSNotFound)return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *detailArray=[xpathParser searchWithXPathQuery:@"//div"];
    NSArray *infoArray=[xpathParser searchWithXPathQuery:@"//h3"];
    TFHppleElement *detailElement=detailArray.lastObject;
    NSString *detail=detailElement.raw;
    NSString *allInfo=[self flattenHTML:detail];
    NSString *content = [allInfo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    [starInfo setObject:content forKey:@"job"];
    TFHppleElement *singleElement=infoArray.lastObject;
    NSString *selfInfo=singleElement.text;
    [starInfo setObject:selfInfo forKey:@"detailInfo"];

    return starInfo;
    
}
//去字符串的每一行

+ (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@"\n"];
    }
    return html;
}
@end
