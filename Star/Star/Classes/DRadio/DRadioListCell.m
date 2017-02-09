//
//  DRadioAllList.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/7.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DRadioListCell.h"
#import "UIImageView+WebCache.h"
#import "DRadioAllList.h"
#import "DRadioUserInfo.h"

@interface DRadioListCell ()
/**
 *  配图
 */
@property (weak, nonatomic) IBOutlet UIImageView *CoverImageView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  电台作者名
 */
@property (weak, nonatomic) IBOutlet UILabel *unameLabel;
/**
 *  电台简介
 */
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
/**
 *  电台收听量
 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation DRadioListCell

+ (instancetype)cellWith:(UITableView *)tabeView
{
    static NSString *ID = @"DRadiocell";
    DRadioListCell *listCell = [tabeView dequeueReusableCellWithIdentifier:ID];
    if (!listCell) {
        listCell = [[[NSBundle mainBundle] loadNibNamed:@"DRadioListCell" owner:nil options:nil] lastObject];
    }
    return listCell;
}


- (void)setAllList:(DRadioAllList *)allList
{
    _allList = allList;
    DRadioUserInfo *user = allList.userinfo;
    
    //给子控件设置数据
    self.CoverImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.CoverImageView sd_setImageWithURL:[NSURL URLWithString:allList.coverimg] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.titleLabel.text = allList.title;
    
    self.unameLabel.text = [NSString stringWithFormat:@"by: %@",user.uname];
    
    self.desLabel.text = allList.desc;
    
    self.countLabel.text = [NSString stringWithFormat:@"🔊 %ld",allList.count];
    
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

@end
