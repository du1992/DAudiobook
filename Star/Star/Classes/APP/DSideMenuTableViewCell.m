//
//  DSideMenuTableViewCell.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DSideMenuTableViewCell.h"
#import "Macro.h"

@interface DSideMenuTableViewCell ()
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end


@implementation DSideMenuTableViewCell


- (void)awakeFromNib
{
    //设置选中状态背景图片
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = RGB(229, 230, 232);
    
    //设置cell的背景
//    self.titleLabel.textColor = [UIColor lightGrayColor];
//    self.backgroundColor = [UIColor yellowColor];
    
    self.iconImageView.contentMode = UIViewContentModeCenter;
}


+ (instancetype)cellWith:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    DSideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DSideMenuTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setIconImage:(NSString *)iconImage
{
    self.iconImageView.image =  [UIImage imageNamed:iconImage];
}


//- (void)setTextColor:(UIColor *)TextColor
//{
//    self.titleLabel.textColor = TextColor;
//}


//重写这个方法，取消高亮效果
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
