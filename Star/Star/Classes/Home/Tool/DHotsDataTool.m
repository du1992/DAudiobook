//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.

#import "DHotsDataTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "AFHTTPRequestOperation.h"
@interface DHotsDataTool()

@end
@implementation DHotsDataTool
//获取最新明星图片
+(NSArray *)hotsData:(NSString *)htmlString{
    
    NSMutableArray *starChartInfo=[NSMutableArray array];
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (htmlStr.length < 5000 ||nil ==htmlStr)return nil;
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"mainLeftBody\">"];
    if (startRange.location == NSNotFound)return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"<div class=\"pages\"><div class=\"fr\">"];
    if (endRange.location ==NSNotFound) return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *elements=[xpathParser searchWithXPathQuery:@"//div[@class='characterList']"];
    
    for (TFHppleElement *element in elements){
        NSArray *childArray=element.children;
        //解析链接 url title img
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        for (TFHppleElement *childElement in childArray) {
            if ([childElement.tagName isEqualToString:@"a"]) {
                NSDictionary *childDict=[childElement attributes];
                NSString *linkUrl=[childDict objectForKey:@"href"];
                [dict setObject:linkUrl forKey:@"linkUrl"];
                TFHppleElement *imgElement= [childElement.children lastObject];
                NSDictionary *imgDict=[imgElement attributes];
                NSString *imgUrl=[imgDict objectForKey:@"src"];
                NSString *title=[imgDict objectForKey:@"alt"];
                [dict setObject:imgUrl forKey:@"imgUrl"];
                [dict setObject:title forKey:@"title"];
                [starChartInfo addObject:dict];
            }
            if ([childElement.tagName isEqualToString:@"div"]) {
                for (TFHppleElement *childDiv in childElement.children) {
                    if ([childDiv.tagName isEqualToString:@"span"] && [[childDiv objectForKey:@"class"] isEqualToString:@"charDate"]) {
                        NSString *date=[NSString stringWithFormat:@"%@  |",childDiv.text];
                        [dict setObject:date forKey:@"date"];
                    }
                    if ([childDiv.tagName isEqualToString:@"a"]){
                        NSString  *aboutStar=dict[@"aboutStar"];
                        NSString *starName=childDiv.text;
                        if (aboutStar ==nil) {
                            [dict setObject:starName forKey:@"aboutStar"];
                        }else{
                            NSString *newStr=[NSString stringWithFormat:@"%@  %@",aboutStar,starName];
                            [dict setObject:newStr forKey:@"aboutStar"];
                        }
                    }
                }
            }
            if ([childElement.tagName isEqualToString:@"p"]) {
                NSString *descrip=[self wipeOff:childElement.text];
                [dict setObject:descrip forKey:@"descrip"];
            }
            
        }
    }
    return starChartInfo;
    
}

//去除回车
+(NSString *)wipeOff:(NSString *)str{
    return  [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
}
@end
