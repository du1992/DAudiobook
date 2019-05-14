//
//  DMenuModel.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DMenuBusinessType) {
    
    kHotNovelType=0,     //热门小说
    kCrosstalkType=1,    //相声评书
    kFantasyType=2,      //玄幻小说
    kCityType=3,         //都市小说
    kTerrorisType=4,     //恐怖小说
    kHistoryType=5,      //历史小说
    kMartiaType=6,       //武侠小说
};


@interface DMenuModel : DBaseModel

/** 标题*/
@property (strong, nonatomic) NSString *title;
/** 图片*/
@property (strong, nonatomic) NSString *pictureImage;
/** 类型*/
@property (assign, nonatomic) DMenuBusinessType menuType;


/** 菜单界面列表 */
+(NSMutableArray*)getMenuModeldataArry;


@end

NS_ASSUME_NONNULL_END
