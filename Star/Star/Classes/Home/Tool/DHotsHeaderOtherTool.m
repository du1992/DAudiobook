//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.


#import "DHotsHeaderOtherTool.h"
#import "NSMutableString+ReplaceByString.h"
@implementation DHotsHeaderOtherTool
+(NSString *)hotsHeaderOther:(NSString *)htmlString
{
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (nil ==htmlStr ||htmlStr.length < 5000)return nil;
    NSRange headRange=[htmlStr rangeOfString:@"</title>"];
    if (headRange.location == NSNotFound)return nil;
    NSMutableString *headStr=[[NSMutableString alloc]initWithString:[htmlStr substringToIndex:headRange.location+headRange.length]];

    
    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"block01\">"];
    if (startRange.location == NSNotFound)return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location]];
    
    NSRange endRange=[startStr rangeOfString:@"<div class=\"tp_content_1150_04\">"];
    if (endRange.location == NSNotFound)return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    
    NSRange deleRange =[finalStr rangeOfString:@"<div class=\"tp_content_1150_02\">"];
    NSRange nextRange =[finalStr rangeOfString:@"<div class=\"tp_content_1150_03\">"];

    NSRange range=NSMakeRange(deleRange.location, nextRange.location-deleRange.location);
    [finalStr replaceCharactersInRange:range withString:@"<br>"];
    [finalStr replaceString:@"href" by:@"ref"];
    CGSize size=[[UIScreen mainScreen] bounds].size;
    int divWidth=(int)size.width-20;
    NSString *finlHtml=[headStr stringByAppendingFormat:@"<link href=\"http://www.mingxing.com/css2015/css.css\" rel=\"stylesheet\" type=\"text/css\" /></head><body id=\"mainBody\" style=\"width:%dpx\"><font color=\"#000000\"><br><br>%@</div></font><br></body></html> ",divWidth,finalStr];
    NSMutableString *mutStr=[NSMutableString stringWithString:finlHtml];
    [mutStr replaceString:@"<img" by:@"zhou34enen"];
    [mutStr replaceString:@"zhou34enen" by:[NSString stringWithFormat:@"<img width=\"%lf\" ",size.width-20]];
    return mutStr;
    
}



@end
