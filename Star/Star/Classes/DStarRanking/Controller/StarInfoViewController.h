//
//  StarInfoViewController.h
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ranking.h"
@interface StarInfoViewController : UITableViewController
@property (nonatomic,copy) NSString *linkUrl;
@property (nonatomic,copy) NSString *starName;
@property (nonatomic,strong) Ranking *ranking;



@end
