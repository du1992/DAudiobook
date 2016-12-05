//
//  RankingsCell.m
//  Star
//
//  Created by lanou3g on 15/5/28.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "RankingsCell.h"
#import "UIImageView+WebCache.h"
#import "Macro.h"

@implementation RankingsCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID=@"ranking";
    RankingsCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}
-(void)setRanking:(Ranking *)ranking{
    if (_ranking != ranking) {
        _ranking=ranking;
        self.nameLabel.text=_ranking.name;
        NSURL *imgUrl=[NSURL URLWithString:_ranking.imgUrl];
#warning 占位图片没有设置
        [self.imgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"starRanking"]];
        self.heatLabel.text=ranking.heat;
        self.chartLabel.text=ranking.chart;
        [self.chartLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19.0]];
        _chartLabel.textColor=ranking.chartColor;
        
        self.imgView.clipsToBounds = YES;
        self.imgView.layer.cornerRadius = 33;
        self.imgView.layer.borderWidth = 3;
        
        
    }
}
@end
