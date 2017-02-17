//
//  DShareView.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/17.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DShareView.h"
#import "Macro.h"


@interface DShareView ()


@property (nonatomic, strong) UIImageView       *programImageView;
@property (nonatomic, strong) UIImageView       *headerImageView;
@property (nonatomic, strong) UIImageView       *vipImageView;
@property (nonatomic, strong) UILabel           *userNameLable;
@property (nonatomic, strong) UILabel           *programLable;
@property (nonatomic, strong) NSMutableArray    *shareTerraceArray; //分享平台array


@end


@implementation DShareView

-(void)showInView:(UIView *)view  {
  
    UIView *control = [[UIView alloc] init];
    [view addSubview:control];
    control.backgroundColor = COLOR_RGBA(0, 0, 0, 0.6);
   [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    _buttonArray=[NSMutableArray array];
    self.bgControll=control;
    
//    if (ViewChoose == Share_XProgram) {
//        [self loadeSubViewA];
//    }else{
//        _programImageView=[[UIImageView alloc]init];
////        [_programImageView sd_setImageWithURL:[NSURL URLWithString:_model.posterImg] placeholderImage:[UIImage imageNamed:@"节目展位图"]];
        [self  loadeSubViewB];
//    }
}







-(void)loadeSubViewA{
    
    CGFloat width = WIDTH - 95;
    UIView *bgView = [self viewWithSuperView:self.bgControll];
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgControll);
        make.size.mas_equalTo(CGSizeMake(width,width * 9/16 + 68 + 80));
    }];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *programImageView = [self imageViewWithSuperView:bgView];
    self.programImageView = programImageView;
    [programImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(bgView);
        make.height.equalTo(bgView.mas_width).multipliedBy(9/16.0);
    }];
    
    UIView *centerView = [self viewWithSuperView:bgView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.equalTo(bgView);
        make.top.equalTo(programImageView.mas_bottom);
        make.height.mas_equalTo(68);
    }];
    //    centerView.backgroundColor = [UIColor redColor];
    
    UIImageView *userHeaderImageView = [self imageViewWithSuperView:centerView];
    self.headerImageView = userHeaderImageView;
    [userHeaderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(centerView).insets(UIEdgeInsetsMake(13, 10, 0, 0));
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    userHeaderImageView.layer.cornerRadius = 15;
    userHeaderImageView.clipsToBounds = YES;
    
    UIImageView *vipImageView = [self imageViewWithSuperView:centerView];
    self.vipImageView = vipImageView;
    vipImageView.image = [UIImage imageNamed:@"VIP"];
    [vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(userHeaderImageView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.size.mas_equalTo(CGSizeMake(12, 12));
    }];
    vipImageView.layer.cornerRadius = 6;
    vipImageView.clipsToBounds = YES;
    
    UILabel *nameLable = [self lableWithSuperView:centerView textColor:RGB(91, 91, 91) fontSize:14];
    self.userNameLable = nameLable;
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerView).offset(10);
        make.left.equalTo(userHeaderImageView.mas_right).offset(5);
        make.height.mas_equalTo(19);
        make.right.lessThanOrEqualTo(centerView).offset(-10);
    }];
    
    UILabel *programLable = [self lableWithSuperView:centerView textColor:RGB(29, 29, 38) fontSize:14];
    self.programLable = programLable;
    [programLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLable.mas_bottom);
        make.left.equalTo(userHeaderImageView.mas_right).offset(5);
        make.height.mas_equalTo(19);
        make.right.lessThanOrEqualTo(centerView).offset(-10);
    }];
    
    UIView *bottomView = [self viewWithSuperView:bgView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.bottom.equalTo(bgView);
        make.top.equalTo(centerView.mas_bottom);
        make.height.mas_equalTo(80);
    }];
    //    bottomView.backgroundColor = [UIColor yellowColor];
    
    UILabel *shareLabel = [self lableWithSuperView:bottomView textColor:RGB(105, 105, 105) fontSize:14];
    [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(bottomView);
        make.height.mas_equalTo(19);
    }];
    shareLabel.text = @"分享至";
    
    NSArray *shareArray = @[
                            @"UMShareToWechatSession" ,
                            @"UMShareToSina" ,
                            @"UMShareToQQ" ,
                            @"UMShareToWechatTimeline" ,
                            @"UMShareToQzone"
                            ];
    
    CGFloat shareSpace = (width - 30 * 5 ) / 6.0;
    
    for (int i = 0; i < [shareArray count]; i++) {
        UIButton *sharButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sharButton setImage:[UIImage imageNamed:shareArray[i]] forState:UIControlStateNormal];
        [bottomView addSubview:sharButton];
        [sharButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareLabel.mas_bottom).offset(5);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(shareSpace * (i + 1) + 30 * i);
        }];
        [sharButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        sharButton.tag = i;
    }
    
//    [programImageView sd_setImageWithURL:[NSURL URLWithString:_model.posterImg] placeholderImage:[UIImage imageNamed:@"节目展位图"]];
//    [userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:_model.user.headImage] placeholderImage:[UIImage imageNamed:@"user_default_header"]];
//    nameLable.text = _model.user.nickName;
//    programLable.text = _model.title;
}

-(void)loadeSubViewB{
    CGFloat width = WIDTH ;
    UIView *bottomView = [self viewWithSuperView:self.bgControll];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.bottom.equalTo(self.bgControll);
        make.top.equalTo(self.bgControll.mas_bottom).offset(115);
        make.height.mas_equalTo(115);
    }];
    
    UILabel *shareLabel = [self lableWithSuperView:bottomView textColor:RGB(105, 105, 105) fontSize:16];
    [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(15);
        make.centerX.equalTo(bottomView);
        make.height.mas_equalTo(20);
    }];
    shareLabel.text = @"亲，分享给小伙伴吧😀";
    
    NSArray *shareArray = @[
                            @"UMShareToWechatSession" ,
                            @"UMShareToSina" ,
                            @"UMShareToQQ" ,
                            @"UMShareToWechatTimeline" ,
                            @"UMShareToQzone"
                            ];
    
    CGFloat shareSpace = (width - 30 * 5 ) / 6.0;
    
    for (int i = 0; i < [shareArray count]; i++) {
        UIButton *sharButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sharButton setImage:[UIImage imageNamed:shareArray[i]] forState:UIControlStateNormal];
        [bottomView addSubview:sharButton];
        [sharButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareLabel.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(shareSpace * (i + 1) + 30 * i);
        }];
        sharButton.tag = i;
        [_buttonArray addObject:sharButton];
    }
    
    
//    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_model.user.headImage] placeholderImage:[UIImage imageNamed:@"user_default_header"]];
//    //    nameLable.text = _model.user.nickName;
//    _programLable.text = _model.title;
}


-(UIView *)viewWithSuperView:(UIView *)superView{
    UIView *view = [[UIView alloc] init];
    [superView addSubview:view];
    return view;
}

-(UILabel *)lableWithSuperView:(UIView *)superView textColor:(UIColor *)textColor fontSize:(CGFloat )fountSize{
    UILabel *label = [[UILabel alloc] init];
    [superView addSubview:label];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fountSize];
    return label;
}

-(UIImageView *)imageViewWithSuperView:(UIView *)superView{
    UIImageView *view = [[UIImageView alloc] init];
    [superView addSubview:view];
    return view;
}

@end
