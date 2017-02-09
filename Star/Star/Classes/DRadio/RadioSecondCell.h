//
//  DRadioAllList.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/7.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DRadioSecondListModel;
@interface RadioSecondCell : UITableViewCell

@property (nonatomic,strong) DRadioSecondListModel *radioListModel;

+ (instancetype)cellWithtableView:(UITableView *)tableView;

@end
