//
//  DTextJokesCell.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/15.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTextJokesCell.h"
#import "DJokesModel.h"

@interface DTextJokesCell ()
/** 底图阴影*/
@property (strong, nonatomic) UIView      *textJokesShadowView;

@end

@implementation DTextJokesCell

- (void)setLayout{
    [self.textJokesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(10,15, 10, 15));
    }];
    
    [self.textJokesShadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.textJokesView).insets(UIEdgeInsetsMake(0,0,0,0));
    }];
    
    
   [self.textJokesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.textJokesView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    
    
    self.backgroundColor=UIColorFromRGBValue(0xf5f7fb);

    
}
- (UILabel *)textJokesLabel{
    if (!_textJokesLabel) {
        _textJokesLabel = [UILabel new];
        _textJokesLabel.textColor=[UIColor whiteColor];
        _textJokesLabel.font = AppFont(15);
        _textJokesLabel.numberOfLines = 0;
        _textJokesLabel.shadowColor = [UIColor grayColor];
        _textJokesLabel.shadowOffset = CGSizeMake(0.1, 0.1);
        [self addSubview:_textJokesLabel];
    }
    return _textJokesLabel;
}
- (UIView *)textJokesView{
    if (!_textJokesView) {
        _textJokesView=[[UIView alloc]init];
        _textJokesView.layer.cornerRadius = 5;
        _textJokesView.layer.masksToBounds = YES;
        [self addSubview:_textJokesView];
    }
    return _textJokesView;
}
- (UIView *)textJokesShadowView{
    if (!_textJokesShadowView) {
        _textJokesShadowView=[[UIView alloc]init];
        _textJokesShadowView.layer.cornerRadius = 5;
        _textJokesShadowView.layer.masksToBounds = YES;
        _textJokesShadowView.backgroundColor=AppAlphaColor(0,0,0, 0.3);
        [self.textJokesView addSubview:_textJokesShadowView];
    }
    return _textJokesShadowView;
}



-(void)setData:(DJokesModel *)model{
    self.textJokesLabel.text=model.text;
    self.textJokesView.backgroundColor=AppColor(model.R,model.G,model.B);
}

@end
