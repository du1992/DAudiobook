//
//  DInterfaceUrl.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
NS_ASSUME_NONNULL_BEGIN


#pragma mark - Url链接

/* ========================================= 模拟Url ===========================================================*/

/*
  热门小说url
 */

#define HotNovelUrl @"热门"
/*
 相声url
 */

#define CrosstalkUrl @"相声"
/*
 玄幻小说url
 */

#define FantasyUrl @"玄幻"
/*
 都市小说url
 */

#define CityUrl @"都市"
/*
 恐怖小说url
 */

#define TerroristUrl @"恐怖"

/*
 历史小说url
 */

#define HistoryUrl @"历史"
/*
 武侠小说url
 */

#define MartialUrl @"武侠"
/*
 武侠小说url
 */

#define JokesUrl @"段子"

/*
 全部照片url
 */

#define AllUrl @"全部"

/*
 性感照片url
 */

#define SexyUrl @"性感"

/*
 丰满照片url
 */

#define PlumpUrl @"丰满"

/*
 丝袜照片url
 */

#define SilkStockingsUrl @"丝袜"

/*
 美腿照片url
 */

#define LegUrl @"美腿"

/*
 清新照片url
 */

#define SportUrl @"清新"

/*
 视频url
 */

#define VideoUrl @"视频"






@interface DInterfaceUrl : NSObject

//用户信息
+(void)userPopupWindow;

//获取随机名字
+(NSString*)getNameString;

//获取随机头像ID
+(NSString*)getUserLogoString;

//获取随机头像
+(NSString*)getImgString:(NSString*)imgId;




@end

NS_ASSUME_NONNULL_END
