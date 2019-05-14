//
//  DAlbumHeadView.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/27.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DAlbumHeadView.h"
#import "DRadioModel.h"

@implementation DAlbumHeadView

- (void)setLayout{
    
   
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
    }];
    
   
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 100));
        make.top.mas_equalTo(self.mas_top).offset(20);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
   
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImageView.mas_bottom).offset(6);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(1);
        make.left.mas_equalTo(self.mas_left).offset(5);
        make.right.mas_equalTo(self.mas_right).offset(-5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(0);
    }];
   
    
}
- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView=[[UIImageView alloc]init];
        _bgImageView.contentMode=UIViewContentModeScaleAspectFill;
        _bgImageView.clipsToBounds = YES;
         [self addSubview:_bgImageView];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.frame=CGRectMake(0, 0, kScreenWidth, 300);
        [_bgImageView addSubview:blurView];
    }
    return _bgImageView;
}

- (UIImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView=[[UIImageView alloc]init];
        _coverImageView.layer.cornerRadius=5;
        _coverImageView.clipsToBounds = YES;
        [self addSubview:_coverImageView];
    }
    return _coverImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        [self addSubview:_titleLabel];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.shadowColor = [UIColor grayColor]; //文本阴影颜色
        _titleLabel.shadowOffset = CGSizeMake(1.0, 1.0);//阴影大小
    }
    return _titleLabel;
}

- (UILabel *)introduceLabel{
    if (!_introduceLabel) {
        _introduceLabel=[[UILabel alloc]init];
        [self addSubview:_introduceLabel];
        _introduceLabel.font = [UIFont systemFontOfSize:12];
        _introduceLabel.textColor=[UIColor whiteColor];
        _introduceLabel.numberOfLines = 0;
        _introduceLabel.shadowColor = [UIColor grayColor]; //文本阴影颜色
        _introduceLabel.shadowOffset = CGSizeMake(1.0, 1.0);//阴影大小
        _introduceLabel.textAlignment = UITextAlignmentCenter;
        
    }
    return _introduceLabel;
}



-(void)setData:(DRadioModel *)model{
      [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
     [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
     self.titleLabel.text=model.title;
    if (model.albumIntro.length) {
         self.introduceLabel.text=model.albumIntro;
    }else{
         self.introduceLabel.text=@"暂无专辑介绍：--------------玩去吧";
    }
    
}
@end
