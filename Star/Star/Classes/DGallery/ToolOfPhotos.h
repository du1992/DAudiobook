//
//  ToolOfPhotos.h
//  Star
//
//  Created by DUCHENGWEN on 2016/12/4.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
#import "TFHppleElement.h"
@interface ToolOfPhotos : NSObject
//抓取html网页数据
+(NSMutableArray *)photosData:(NSString *)htmlString;
@end
