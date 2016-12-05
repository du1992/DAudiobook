//
//  ToolForPictureDetail.m
//  Star
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "ToolForPictureDetail.h"

@implementation ToolForPictureDetail
//实现抓取html数据方法
+(NSDictionary *)everyPhoto:(NSString *)htmlString{
    
    NSLog(@"%@",htmlString);
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (htmlStr.length < 5000 ||htmlStr ==nil)return nil;
    
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"img_box\">"];
    if (startRange.location == NSNotFound) return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"<div class=\"tp_content_1150_04\">"];
    if (endRange.location ==NSNotFound) return nil;
    NSMutableDictionary *photoDict=[NSMutableDictionary dictionary];
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    
    NSArray *descripArray=[xpathParser searchWithXPathQuery:@"//div[@class='intro']"];
    
    NSArray *aArray=[xpathParser searchWithXPathQuery:@"//a"];
    
    
    NSArray *pageArray=[xpathParser searchWithXPathQuery:@"//div[@class='totalpage_box']"];
    for (TFHppleElement *element in [descripArray.lastObject children]) {
        if (element.text!=nil) {
            [photoDict setObject:element.text forKey:@"descrip"];
        }
    }
    for (TFHppleElement *element in aArray) {
        if ([element.tagName isEqualToString:@"a"]) {
            TFHppleElement *aElement=[element.children lastObject];
            NSDictionary *imgDict=[aElement attributes];
            NSString *imgUrl=[imgDict objectForKey:@"src"];
            NSString *title=[imgDict objectForKey:@"alt"];
            if (imgUrl==nil) {
                break ;
            }
           

            [photoDict setObject:imgUrl forKey:@"imgUrl"];
            
            if (title==nil) {
                break ;
            }
           
            //对title字符串做特殊处理
//            NSRange range=[title rangeOfString:@"("];
//             NSLog(@"%lu",(unsigned long)range.location);
//            NSString *str=[title substringToIndex:range.location];
            [photoDict setObject:[NSString stringWithFormat:@"%@",title ] forKey:@"title"];
            break;
        }
    }
    TFHppleElement *pageElement = [[pageArray.lastObject children] lastObject];
    NSString *pageCount=@"1";
    if (pageElement.text!=nil) {
        pageCount=[pageElement.text substringFromIndex:1];
    }
    [photoDict setObject:pageCount forKey:@"pageCount"];
    
    return photoDict ;
}
@end
