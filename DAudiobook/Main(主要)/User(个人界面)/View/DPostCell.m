//
//  DPostTableViewCell.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "DPostCell.h"
#import "DPostModel.h"

@implementation DPostCell

- (void)setLayout{
    [self.backgroundsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(50);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
    [self.userLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backgroundsView.mas_top).offset(5);
        make.left.mas_equalTo(self.backgroundsView.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userLogoImageView.mas_right).offset(5);
        make.right.mas_equalTo(self.backgroundsView.mas_right).offset(-5);
        make.centerY.mas_equalTo(self.userLogoImageView.mas_centerY);
        make.height.equalTo(@20);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backgroundsView.mas_left).offset(5);
        make.right.mas_equalTo(self.backgroundsView.mas_right).offset(-5);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.backgroundsView.mas_bottom).offset(-5);
    }];
}

-(UIView*)backgroundsView{
    if (!_backgroundsView) {
        self.backgroundsView=[UIView new];
        self.backgroundsView.layer.masksToBounds = YES;
        self.backgroundsView.layer.cornerRadius = 9.0;
        self.backgroundsView.layer.borderWidth = 2;
        self.backgroundsView.layer.borderColor = AppColor(0, 153, 238).CGColor;
        [self.contentView addSubview:_backgroundsView];
        
    }
    
    return _backgroundsView;
}
-(UIImageView*)userLogoImageView{
    if (!_userLogoImageView) {
        _userLogoImageView = [[UIImageView alloc] init];
        _userLogoImageView.layer.cornerRadius = 30/2;
        _userLogoImageView.layer.masksToBounds = YES;
        _userLogoImageView.layer.borderWidth = 0.5;
        _userLogoImageView.layer.borderColor = AppColor(0, 153, 238).CGColor;
        [_backgroundsView addSubview:_userLogoImageView];
    }
    return _userLogoImageView;
}
-(UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel                 = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.font            = [UIFont boldSystemFontOfSize:12];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor=AppColor(0, 153, 238);
        [_backgroundsView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

-(UILabel*)contentLabel{
    if (!_contentLabel) {
        _contentLabel                 = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font            = AppFont(14);
        _contentLabel.textColor       = AppColor(159, 159, 159);
        _contentLabel.textAlignment   = NSTextAlignmentLeft;
        _contentLabel.numberOfLines   = 0;
        [_backgroundsView addSubview:_contentLabel];
    }
    return _contentLabel;
}

-(void)setData:(DPostModel *)model{
  
    
    if ([[BmobUser currentUser].objectId isEqualToString:model.authorID]&&![model.isAnonymous isEqualToString:@"1"]) {
        
        [self.backgroundsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(50);
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.top.mas_equalTo(self.mas_top).offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
        }];
    }else{
        
        [self.backgroundsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(10);
            make.right.mas_equalTo(self.mas_right).offset(-50);
            make.top.mas_equalTo(self.mas_top).offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
            
        }];
        
        
    }
    if ([model.isAnonymous isEqualToString:@"1"]) {
        self.userLogoImageView.image=ImageNamed(@"小熊明星资讯");
        self.nameLabel.text=@"匿名用户";
    }else{
      self.nameLabel.text=model.nickName;
      [self.userLogoImageView sd_setImageWithURL:[NSURL URLWithString:[DInterfaceUrl getImgString:model.userLogo]] placeholderImage:[UIImage imageNamed:@"小熊明星资讯"]];
    }
    
    self.contentLabel.text=model.content;
   
    
}

@end
