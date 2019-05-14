//
//  DAlbumViewCell.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/26.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DAlbumViewCell.h"
#import "DSongModel.h"


@implementation DAlbumViewCell

- (void)setLayout{
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-10);
    }];
    
    [self.desLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        
        
    }];
    
    
    UIView*lineView=[[UIView alloc]init];
    lineView.backgroundColor=UIColorFromRGBValue(0xe4e3e3);
    [self addSubview:lineView];
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    
}
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor=AppColor(140, 146, 156);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)desLabel{
    
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.font = [UIFont systemFontOfSize:12];
        _desLabel.textColor=AppColor(116, 120, 126);
        [self addSubview:_desLabel];
    }
    return _desLabel;
}


-(void)setData:(DSongModel *)model
{
    
    self.titleLabel.text=model.title;
    self.desLabel.text=[NSString stringWithFormat:@"简介：%@",model.trackIntro];
    
    
}

@end
