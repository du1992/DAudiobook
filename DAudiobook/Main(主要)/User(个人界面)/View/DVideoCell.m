//
//  DVideoCell.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DVideoCell.h"
#import "DVideoModel.h"

@implementation DVideoCell

- (void)setLayout{
    [self.videoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(190);
    }];
    [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.center.mas_equalTo(self.videoImageView);
    }];

    
    
    [self.videoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.videoImageView.mas_bottom).offset(0);
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(20);
    }];
    
    
    self.backgroundColor=UIColorFromRGBValue(0xf5f7fb);
    
    
}

- (UIImageView *)videoImageView{
    if (!_videoImageView) {
        _videoImageView=[UIImageView new];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds = YES;
        [self.contentView addSubview:_videoImageView];
    }
    return _videoImageView;
}
- (UILabel *)videoTitle{
    if (!_videoTitle) {
        _videoTitle = [UILabel new];
        _videoTitle.textColor=[UIColor blackColor];
        _videoTitle.font = AppFont(15);
        _videoTitle.backgroundColor=AppAlphaColor(255,255,255, 0.7);
        [self.contentView addSubview:_videoTitle];
    }
    return _videoTitle;
}
-(UIImageView *)playImageView{
    if (!_playImageView) {
        _playImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:_playImageView];
        _playImageView.image=ImageNamed(@"play");
    }
    return _playImageView;
}

-(void)setData:(DVideoModel *)model{
    
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:ImageNamed(@"timeline_image_placeholder")];
    self.videoTitle.text=model.title;
}

@end
