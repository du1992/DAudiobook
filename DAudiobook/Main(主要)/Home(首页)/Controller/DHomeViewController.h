//
//  DHomeViewController.h
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/9.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

#pragma mark - 热门小说
@interface DHotNovelViewController : DTableViewController
@end

#pragma mark - 相声评书
@interface DCrosstalkViewController : DHotNovelViewController
@end

#pragma mark - 玄幻小说
@interface DFantasyViewController : DHotNovelViewController
@end

#pragma mark - 都市小说
@interface DCityViewController : DHotNovelViewController
@end

#pragma mark - 恐怖灵异小说
@interface DTerroristViewController : DHotNovelViewController
@end

#pragma mark - 历史小说
@interface DHistoryViewController : DHotNovelViewController
@end

#pragma mark - 武侠小说
@interface DMartialViewController : DHotNovelViewController
@end



NS_ASSUME_NONNULL_END
