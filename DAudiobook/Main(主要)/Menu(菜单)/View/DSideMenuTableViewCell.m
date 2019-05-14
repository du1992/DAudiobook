//
//  DSideMenuTableViewCell.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DSideMenuTableViewCell.h"
#import "DMenuModel.h"
@implementation DSideMenuTableViewCell

- (void)setLayout{
    
    self.contentView.backgroundColor=[UIColor whiteColor];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(0);
        make.right.mas_equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(26, 26));
        make.left.mas_equalTo(self.mas_left).offset(16);
    }];
    
    [self.describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.iconImageView.mas_right).offset(10);
    }];
    
    
};
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImageView];
    }
    return _iconImageView;
}
- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [UILabel new];
        _describeLabel.textColor=UIColorFromRGBValue(0x333333);
        _describeLabel.font = AppFont(15);
        [self addSubview:_describeLabel];
    }
    return _describeLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=UIColorFromRGBValue(0xf0f0f0);
        [self addSubview:_lineView];
    }
    return _lineView;
}

-(void)setData:(DMenuModel *)model{
    self.iconImageView.image=ImageNamed(model.pictureImage);
    self.describeLabel.text=model.title;
}
@end
