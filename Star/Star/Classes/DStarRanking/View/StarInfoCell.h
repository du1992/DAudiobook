//
//  StarInfoCell.h
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarInfo.h"
@interface StarInfoCell : UITableViewCell
@property (nonatomic,strong) StarInfo *starInfo;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
