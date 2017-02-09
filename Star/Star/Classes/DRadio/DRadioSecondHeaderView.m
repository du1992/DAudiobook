//
//  DRadioSecondHeaderView.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/8.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DRadioSecondHeaderView.h"
#import "Macro.h"
#import "UIImageView+WebCache.h"
#import "userinfo.h"
#import "DRadioSecondRadioInfo.h"



@interface DRadioSecondHeaderView ()
/**
 *  头部图片
 */
@property (nonatomic,strong) UIImageView *headView;
/**
 *  电台头像图片
 */
@property (nonatomic,strong) UIImageView *iconView;
/**
 *  电台名称
 */
@property (nonatomic,strong) UILabel *iconLabel;
/**
 *  描述
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 *  收听人数
 */
@property (nonatomic,strong) UILabel *likeLabel;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation DRadioSecondHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark - 初始化子控件
- (void)setupSubViews
{
    [self addSubview:self.headView];
    [self addSubview:self.iconLabel];
    [self addSubview:self.iconView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.likeLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:self.lineView];
}


#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)weakSelf = self;
    CGFloat headViewH = self.frame.size.height * 0.65;
    [weakSelf.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.left.equalTo(weakSelf.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(headViewH);
    }];
    
    
    [weakSelf.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.equalTo(weakSelf.iconLabel.mas_left).offset(-5);
    }];
    
    
    [weakSelf.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconView.mas_right).offset(5);
        make.centerY.equalTo(weakSelf.iconView.mas_centerY);
        make.height.equalTo(weakSelf.iconView.mas_height);
        make.right.equalTo(weakSelf.likeLabel.mas_left);
    }];
    
    
    [weakSelf.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconView.mas_bottom).offset(Padding);
        make.left.equalTo(weakSelf.iconView.mas_left);
        make.right.equalTo(weakSelf.iconLabel.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-Padding);
    }];
    
    
    [weakSelf.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.iconView.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60,20));
    }];
    
    [weakSelf.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(WIDTH, 1));
    }];
}


#pragma mark - 懒加载
- (UIImageView *)headView
{
    if (!_headView) {
        _headView = [[UIImageView alloc] init];
        _headView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headView;
}


- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.layer.cornerRadius = 15;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)iconLabel
{
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.textColor = [UIColor purpleColor];
        _iconLabel.font = [UIFont systemFontOfSize:12];
    }
    return _iconLabel;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}


- (UILabel *)likeLabel
{
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc] init];
        _likeLabel.textColor = [UIColor lightGrayColor];
        _likeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _likeLabel;
}


- (void)setRadioInfo:(DRadioSecondRadioInfo *)radioInfo
{
    _radioInfo = radioInfo;
    userinfo *user = radioInfo.userinfo;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.icon] placeholderImage:Placholder];
    [self.headView sd_setImageWithURL:[NSURL URLWithString:radioInfo.coverimg] placeholderImage:Placholder];
    self.iconLabel.text = user.uname;
    self.titleLabel.text = radioInfo.desc;
    self.likeLabel.text = [NSString stringWithFormat:@"🔊 %ld",radioInfo.musicvisitnum];
}


@end
