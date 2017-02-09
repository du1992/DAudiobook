//
//  DRadioSecondListModel.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/7.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRadioSecondListModel : NSObject
/**
 *  头像
 */
@property (nonatomic,copy) NSString *coverimg;
/**
 *  标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  收听人数
 */
@property (nonatomic,assign) NSInteger musicVisit;
/**
 *  歌曲链接
 */
@property (nonatomic,copy) NSString *musicUrl;

@end
