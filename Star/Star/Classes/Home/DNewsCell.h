//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.

#import <UIKit/UIKit.h>
#import "DNews.h"
@interface DNewsCell : UITableViewCell
@property (nonatomic,strong) DNews *news;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
