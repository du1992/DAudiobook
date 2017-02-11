//
//  StarInfoHeaderView.m
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "StarInfoHeaderView.h"
#import "UIImageView+WebCache.h"
@interface StarInfoHeaderView()

@property (nonatomic,weak)IBOutlet UILabel *detailInfoLabel;
@property (nonatomic,weak)IBOutlet UILabel *birthAddressLabel;
//@property (nonatomic,weak)IBOutlet UILabel *constellationLabel;
//@property (nonatomic,weak)IBOutlet UILabel *heightLabel;
//@property (nonatomic,weak)IBOutlet UILabel *weightLabel;
//@property (nonatomic,weak)IBOutlet UILabel *jobLabel;


@end
@implementation StarInfoHeaderView

- (void)awakeFromNib{
    _backGroundImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //  毛玻璃视图
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.alpha = 1;
    effectView.frame = _backGroundImageView.frame;
    [_backGroundImageView addSubview:effectView];
    [self addSubview:_backGroundImageView];
    [self sendSubviewToBack:_backGroundImageView];
    
}

-(void)setSelfInfo:(StarSelfInfo *)selfInfo{
    if (_selfInfo !=selfInfo) {
        _selfInfo =selfInfo;
        self.birthAddressLabel.text=selfInfo.job;
        self.detailInfoLabel.text=selfInfo.detailInfo;
       
        
    }

}

@end
