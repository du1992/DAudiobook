//
//  DRadioListCell.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/23.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DRadioListCell.h"
#import "DRadioModel.h"

@implementation DRadioListCell

- (void)setLayout{
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(15);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(self.mas_left).offset(15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.coverImageView.mas_top).offset(1);
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.coverImageView.mas_bottom).offset(1);
        make.left.mas_equalTo(self.coverImageView.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
};
- (UIImageView *)coverImageView{
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        _coverImageView.contentMode=UIViewContentModeScaleAspectFill;
        _coverImageView.clipsToBounds = YES;
        _coverImageView.layer.cornerRadius=3;
        [self addSubview:_coverImageView];
    }
    return _coverImageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor=UIColorFromRGBValue(0x333333);
        _titleLabel.font = AppFont(15);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UILabel *)desLabel{
    if (!_desLabel) {
        _desLabel = [UILabel new];
        _desLabel.textColor=[UIColor grayColor];
        _desLabel.font = AppFont(13);
        [self addSubview:_desLabel];
    }
    return _desLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=UIColorFromRGBValue(0xf0f0f0);
        [self addSubview:_lineView];
    }
    return _lineView;
}

-(void)setData:(DRadioModel *)model{
   
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:ImageNamed(@"timeline_image_placeholder")];
    self.titleLabel.text=model.title;
    self.desLabel.text=@"2019年5月1日";
    
}

@end
