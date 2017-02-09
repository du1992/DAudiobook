//
//  DSideMenuTableViewCell.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DSideMenuTableViewCell : UITableViewCell

/**
 *  菜单标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  菜单图标
 */
@property (nonatomic,copy) NSString *iconImage;
/**
 *  选中cell时文字的颜色
 */
@property (nonatomic,strong) UIColor *TextColor;

+ (instancetype)cellWith:(UITableView *)tableView;


@end
