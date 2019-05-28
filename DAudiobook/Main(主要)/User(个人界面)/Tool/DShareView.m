//
//  DShareView.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/27.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DShareView.h"
#import <UShareUI/UShareUI.h>

@interface DShareView ()


@property (nonatomic, strong) UIImageView       *programImageView;
@property (nonatomic, strong) UIImageView       *headerImageView;
@property (nonatomic, strong) UIImageView       *vipImageView;
@property (nonatomic, strong) UILabel           *userNameLable;
@property (nonatomic, strong) UILabel           *programLable;
@property (nonatomic, strong) NSMutableArray    *shareTerraceArray; //分享平台array


@end


@implementation DShareView

-(void)setLayout{
    self.backgroundColor=AppAlphaColor(0, 0, 0, 0.6);
    self.hidden=YES;
    UITapGestureRecognizer* tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self addGestureRecognizer:tapGes];
    
    [self loadeSubView];
    
    
}



-(void)loadeSubView{

    
   self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,kScreenHeight,kScreenWidth,115)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];
    self.bottomView.layer.cornerRadius=5;
    self.bottomView.clipsToBounds = YES;
    
    UILabel *shareLabel = [self lableWithSuperView:self.bottomView textColor:AppColor(105, 105, 105) fontSize:16];
    [shareLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(15);
        make.centerX.equalTo(self.bottomView);
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
    
    CGFloat shareSpace = (kScreenWidth - 30 * 5 ) / 6.0;
    
    for (int i = 0; i < [shareArray count]; i++) {
        UIButton *sharButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sharButton setImage:[UIImage imageNamed:shareArray[i]] forState:UIControlStateNormal];
        [self.bottomView addSubview:sharButton];
        [sharButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(shareLabel.mas_bottom).offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(shareSpace * (i + 1) + 30 * i);
        }];
        sharButton.tag = i;
        [_buttonArray addObject:sharButton];
        
      [sharButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
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





-(void)shareButtonAction:(UIButton *)button{
    
    switch (button.tag) {
        case 0:
            [self  shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            
            break;
        case 1:
            [self  shareWebPageToPlatformType:UMSocialPlatformType_Sina];
            
            break;
            
        case 2:
            [self  shareWebPageToPlatformType:UMSocialPlatformType_QQ];
            
            break;
        case 3:
            [self  shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            break;
            
        case 4:
            
            break;
    }
}
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage* thumbURL =  [UIImage imageNamed:@"小熊明星资讯"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"小熊有声书" descr:@"有趣的视频，好听的音乐都在这里。" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl=[NSString stringWithFormat:@"www.baidu.com"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
   
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSLog(@"");
    }];
    [self dismiss];
}

/**
 *  点击按钮弹出
 */
-(void)show{
    self.hidden=NO;
    [UIView animateWithDuration: 0.35 animations: ^{
        self.bottomView.frame=CGRectMake(0,kScreenHeight-100,kScreenWidth,115);
    } completion:^(BOOL finished) {
        
    }];
}
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss{
    [UIView animateWithDuration: 0.35 animations: ^{
        self.bottomView.frame=CGRectMake(0,kScreenHeight,kScreenWidth,115);
        
    } completion:^(BOOL finished) {
        self.hidden=YES;
    }];
    
}

@end
