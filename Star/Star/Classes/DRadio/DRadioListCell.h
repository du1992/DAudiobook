//
//  DRadioAllList.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/7.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRadioAllList;
@interface DRadioListCell : UITableViewCell

@property (nonatomic,strong) DRadioAllList *allList;

+ (instancetype)cellWith:(UITableView *)tabeView;

@end
