//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.

#import "DHotsDetailTool.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "NSMutableString+ReplaceByString.h"

@implementation DHotsDetailTool
//获取详情信息
+(NSDictionary *)detailData:(NSString *)htmlString{
    
    NSMutableDictionary *detailDict=[NSMutableDictionary dictionary];
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (htmlStr.length < 5000 ||nil ==htmlStr)return nil;
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"artCon\">"];
    if (startRange.location == NSNotFound) return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"<!-- 分页 -->"];
    if (endRange.location ==NSNotFound) return nil;
    NSString *pageCount=[self pageCount:htmlStr];
    [detailDict setValue:pageCount forKey:@"pageCount"];
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *titleElement=[xpathParser searchWithXPathQuery:@"//h1"];
    NSArray *sourceElements=[xpathParser searchWithXPathQuery:@"//div[@class='artInfo']"];
    NSArray *daoduElement=[xpathParser searchWithXPathQuery:@"//div[@class='daodu']"];
    NSArray *imgElement=[xpathParser searchWithXPathQuery:@"//div[@id='pageContent']"];
    
    NSString *title=[titleElement.lastObject text];
    NSString *introduction=[daoduElement.lastObject text];
    //设置标题
    [detailDict setValue:title forKey:@"title"];
    [detailDict setValue:introduction forKey:@"introduction"];
    
    //获取日期 来源
    TFHppleElement *source=sourceElements.lastObject;
    for (TFHppleElement *element in source.children) {
        if ([element.tagName isEqualToString:@"span"]) {
            for (TFHppleElement *child in element.children) {
                if ([child.tagName isEqualToString:@"span"] && [[child objectForKey:@"id"] isEqualToString:@"pubtime_baidu"]){
                    [detailDict setValue:child.text forKey:@"date"];
                }
                if ([child.tagName isEqualToString:@"em"]) {
                    [detailDict setValue:child.text forKey:@"source"];
                    break;
                }
            }
            
        }
    }
    
    TFHppleElement *others=imgElement.lastObject;
    NSUInteger number=0;
    int i=0;
    NSMutableString *tempStr=[NSMutableString string];
    for (TFHppleElement *element in others.children) {
        if ([element.tagName isEqualToString:@"p"]){
            number++;
            if (number ==1) {
                TFHppleElement *imgEle= [element.children lastObject];
                NSDictionary *imgDict=[imgEle attributes];
                NSString *imgUrl=[imgDict objectForKey:@"src"];
                [detailDict setValue:imgUrl forKey:@"imgUrl"];
            }
            if (number == 2) {
                NSMutableString *imgDescrip=[NSMutableString stringWithString:[self flattenHTML:element.raw]];
                //替换字符串
                [imgDescrip replaceString:@"&#13;" by:@""];
                //取出首尾空格和换行
                NSString *content = [imgDescrip stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                [detailDict setValue:content forKey:@"imgDescrip"];
            }
            
            if (number!=1 && number !=2) {
                i++;
                NSString *str=[self flattenHTML:element.raw];
                if (str.length>7) {
                    str=[str substringFromIndex:7];
                }
                if (i!=1) {
                    str =[NSString stringWithFormat:@"\n\n%@",str];
                }
                [tempStr appendString:str];
            }
            
        }
    }
    
    [tempStr replaceString:@"&#13;" by:@""];
    
    [detailDict setValue:tempStr forKey:@"content"];
    
    return detailDict;
    
}

+(NSString *)pageCount:(NSString *)htmlStr{
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"pages\">"];
    if (startRange.location == NSNotFound) return @"1";
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location+startRange.length]];
    
    NSRange endRange=[startStr rangeOfString:@"</div>"];
    if (endRange.location ==NSNotFound) return @"1";
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    NSData *strData=[finalStr dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple *xpathParser=[[TFHpple alloc]initWithHTMLData:strData];
    NSArray *element=[xpathParser searchWithXPathQuery:@"//a"];
    int i=(int)(element.count-5);
    for (; i<element.count;i++) {
        TFHppleElement *child=element[i];
        if (child.text.length>2) {
            TFHppleElement *page=element[i-1];
            return page.text;
        }
    }
    return @"1";
}

+ (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *theScanner;
    NSString *text = nil;
    NSMutableString *htmlStr= [NSMutableString stringWithString:html];
    
    //首先过滤掉<em>
    NSRange startRange=[html rangeOfString:@"<em"];
    NSRange endRange=[html rangeOfString:@"</em"];
    while (startRange.location!= NSNotFound) {
        NSRange range=NSMakeRange(startRange.location, endRange.location+endRange.length+1 -startRange.location);
        [htmlStr deleteCharactersInRange:range];
        startRange=[htmlStr rangeOfString:@"<em"];
        endRange=[htmlStr rangeOfString:@"</em"];
    }
    html=htmlStr;
    
    
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
                                               withString:@""];
    }
    return html;
}
@end
