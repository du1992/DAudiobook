//
//  DMenuHeadView.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/20.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DMenuHeadView.h"
#import <BmobSDK/Bmob.h>
#define kIconView_W 40
#define kIconView_H 40
#define kTimeInterval 30
@interface DMenuHeadView ()

@property(nonatomic, strong) UIImageView    *iconView;
@property(nonatomic, strong) UILabel        *nameLable;
@property(nonatomic, strong) UIImageView    *levelView;

@property(nonatomic, strong) UILabel        *infoLabel;




@end

@implementation DMenuHeadView

- (void)setLayout{
   
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(MenuHeadViewTopDistance+200);
    }];
    
//    self.backView.frame=CGRectMake(0, 0,kScreenWidth, 300);
    
    [self.scrollImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.backView);
    }];
    
    
 
    
    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(16 * 15, 16));
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView);
        make.width.mas_equalTo(280);
        make.height.mas_offset(20);
        make.bottom.mas_equalTo(self).offset(-15);
    }];
    
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.infoLabel.mas_top).offset(-65);
        make.left.mas_equalTo(self).offset(20);
        make.size.mas_equalTo(CGSizeMake(kIconView_W, kIconView_H));
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).offset(10);
        make.width.mas_equalTo(320 - 20 - kIconView_W - 20);
    }];
    
    [self.tapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
    
//    UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTapClick)];
//    [self addGestureRecognizer:photoTap];
//    self.userInteractionEnabled = NO;

    
}
-(void)photoTapClick{
    if (self.headerViewBlock) {
        self.headerViewBlock();
    }
}
- (UIScrollView *)backView{
    if (!_backView) {
        _backView = [[UIScrollView alloc] init];
        _backView.backgroundColor = [UIColor redColor];
        _backView.bounces = NO;
        _backView.showsVerticalScrollIndicator = NO;
        _backView.showsHorizontalScrollIndicator = NO;
        _backView.translatesAutoresizingMaskIntoConstraints = NO;
        _backView.userInteractionEnabled = NO;
        [self addSubview:_backView];
    }
    return _backView;
}
- (UIImageView *)scrollImageView{
    if (!_scrollImageView ) {
        _scrollImageView = [[UIImageView alloc] init];
        _scrollImageView.contentMode = UIViewContentModeScaleAspectFit;
        _scrollImageView.clipsToBounds = YES;
        _scrollImageView.image=[UIImage imageNamed:@"风景沙漠"];
        _scrollImageView.userInteractionEnabled = NO;
        [self.backView addSubview:_scrollImageView];
    }
    return _scrollImageView;
}

-(UIImageView*)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = [UIImage imageNamed:@"小熊明星资讯"];
        _iconView.layer.cornerRadius = kIconView_W/2;
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.borderWidth = 2;
        _iconView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:self.iconView];
    }
    return _iconView;
}
-(UILabel*)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.text = @"小熊有声书";
        _nameLable.textColor = [UIColor whiteColor];
        _nameLable.font = AppFont(32);
        _nameLable.shadowColor = [UIColor blackColor];
        _nameLable.shadowOffset = CGSizeMake(0.5, 0.5);
        [self addSubview:_nameLable];
    }
    return _nameLable;
}
-(UILabel*)infoLabel{
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textColor = [UIColor whiteColor];
        _infoLabel.textAlignment = NSTextAlignmentLeft;
        _infoLabel.font = AppFont(15);
        _infoLabel.text = @"点击进入个人主页>>>>";
        _infoLabel.shadowColor = [UIColor blackColor];
        _infoLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        [self addSubview:self.infoLabel];
    }
    return _infoLabel;
}
-(UIButton*)tapButton{
    if (!_tapButton) {
        _tapButton=[UIButton new];
        [_tapButton addTarget:self action:@selector(photoTapClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_tapButton];
    }
    return _tapButton;
}
- (NSTimer *)timer {
    WEAKSELF
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
            [UIView animateWithDuration:kTimeInterval * 0.5 animations:^{
                weakSelf.backView.contentOffset = CGPointMake(0, 700);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:kTimeInterval * 0.5 animations:^{
                    weakSelf.backView.contentOffset = CGPointMake(0, 0);
                }];
            }];
        }];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

-(void)refreshvView{
    BmobUser*user = [BmobUser currentUser];
    if (user) {
        NSString*nickName=[user objectForKey:@"nickName"];
        if (nickName.length) {
           self.nameLable.text=nickName;
        }
        NSString*userLogo=[user objectForKey:@"userLogo"];
        if (userLogo.length) {
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:[DInterfaceUrl getImgString:userLogo]] placeholderImage:[UIImage imageNamed:@"小熊明星资讯"]];
        }
        
      
        
    }
    
}
@end
