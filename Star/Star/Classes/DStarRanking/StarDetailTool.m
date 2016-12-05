//
//  StarDetailTool.m
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarDetailTool.h"
#import "NSMutableString+ReplaceByString.h"
@implementation StarDetailTool
+(NSString *)starDetail:(NSString *)htmlString
{
    NSString *htmlStr=[NSString stringWithContentsOfURL:[NSURL URLWithString:htmlString] encoding:NSUTF8StringEncoding error:nil];
    if (nil ==htmlStr ||htmlStr.length < 5000)return nil;
    NSRange headRange=[htmlStr rangeOfString:@"</title>"];
    if (headRange.location == NSNotFound)return nil;
    NSMutableString *headStr=[[NSMutableString alloc]initWithString:[htmlStr substringToIndex:headRange.location+headRange.length]];

    NSRange startRange=[htmlStr rangeOfString:@"<div class=\"content_box\">"];
    if (startRange.location == NSNotFound)return nil;
    NSMutableString *startStr=[[NSMutableString alloc]initWithString:[htmlStr substringFromIndex:startRange.location]];
    
    NSRange endRange=[startStr rangeOfString:@"<div class=\"item_880_05\">"];
    if (endRange.location == NSNotFound)return nil;
    NSMutableString *finalStr=[[NSMutableString alloc]initWithString:[startStr substringToIndex:endRange.location]];
    
    NSRange deleRange =[finalStr rangeOfString:@"<div class=\"item_880_03\">"];
     NSRange nextRange =[finalStr rangeOfString:@"<div class=\"zy\">"];
    NSRange range=NSMakeRange(deleRange.location, nextRange.location-deleRange.location);
    [finalStr replaceCharactersInRange:range withString:@"<br>"];
    [finalStr replaceString:@"href" by:@"ref"];
    CGSize size=[[UIScreen mainScreen] bounds].size;
    int divWidth=(int)size.width-20;
    NSString *finlHtml=[headStr stringByAppendingFormat:@"<link href=\"http://www.mingxing.com/css2015/css.css\" rel=\"stylesheet\" type=\"text/css\" /></head><body id=\"mainBody\" style=\"width:%dpx\"><font color=\"#000000\"><br><br>%@</div></font><br></body></html> ",divWidth,finalStr];
    NSMutableString *mutStr=[NSMutableString stringWithString:finlHtml];
    [mutStr replaceString:@"<img" by:@"zhou34enen"];
    [mutStr replaceString:@"zhou34enen" by:[NSString stringWithFormat:@"<img width=\"%lf\" ",size.width-20]];
    
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    // 3.2.获得文件的全路径
//    NSString *path = [doc stringByAppendingPathComponent:@"temp.html"];
//    NSLog(@"%@",path);
//    [mutStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
//  
    return mutStr;
    
}



@end
