//
//  RankingsCell.h
//  Star
//
//  Created by lanou3g on 15/5/28.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ranking.h"
@interface RankingsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *chartLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *heatLabel;

@property (nonatomic,strong) Ranking *ranking;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
