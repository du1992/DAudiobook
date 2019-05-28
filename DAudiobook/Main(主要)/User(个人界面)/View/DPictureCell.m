//
//  DPictureCell.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/19.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DPictureCell.h"
#import "DPictureModel.h"


@implementation DPictureCell

- (void)setLayout{
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0,0, 10, 0));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pictureView.mas_top).offset(15);
        make.left.mas_equalTo(self.pictureView).offset(15);
    }];
    
    
    [self.dynamicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pictureView).offset(15);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(0, 0));
    }];
    
    
    
    self.backgroundColor=UIColorFromRGBValue(0xf5f7fb);
    
    
}

- (UIView *)pictureView{
    if (!_pictureView) {
        _pictureView=[[UIView alloc]init];
        _pictureView.backgroundColor=[UIColor whiteColor];
        [self addSubview:_pictureView];
    }
    return _pictureView;
}
- (UIImageView *)dynamicImageView{
    if (!_dynamicImageView) {
        _dynamicImageView=[UIImageView new];
        _dynamicImageView.contentMode = UIViewContentModeScaleAspectFill;
        _dynamicImageView.clipsToBounds = YES;
        _dynamicImageView.layer.cornerRadius=3;
        [self.pictureView addSubview:_dynamicImageView];
    }
    return _dynamicImageView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor=[UIColor blackColor];
        _titleLabel.font = AppFont(15);
         [self.pictureView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(void)setData:(DPictureModel *)model{
    self.titleLabel.text=model.title;
    if (model.imageWidth) {
        [self.dynamicImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.pictureView).offset(15);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(model.imageWidth,model.imageHeight));
        }];
    }
   
}
@end
