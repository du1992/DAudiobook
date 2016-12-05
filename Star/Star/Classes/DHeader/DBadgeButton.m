//
//  DBadgeButton.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2016/12/3.
//  Copyright © 2016年 beijing. All rights reserved.
//

#import "DBadgeButton.h"
#import "UIImage+stretch.h"

@implementation DBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden=YES;
        self.userInteractionEnabled=NO;
        [self setBackgroundImage:[UIImage strethImage:@"main_badge_os7"] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:11];
    }
    return self;
}
+(instancetype)badgeButton{
    return [[self alloc] init];
}
-(void)setBadgeValue:(NSString *)badgeValue{
    //copy的属性重写set方法  需要用copy
    _badgeValue=[badgeValue copy];
    if (badgeValue.length>0) {
        self.hidden=NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        //设置frame 此处不管位置 只管 size
        NSDictionary *attr=[NSDictionary dictionary];
        attr=@{NSFontAttributeName:[UIFont systemFontOfSize:11]};
        CGSize valueSize=[badgeValue sizeWithAttributes:attr];
        //iOS7下已经过期
        //        CGSize valueSize=[badgeValue sizeWithFont:self.titleLabel.font];
        CGRect frame=self.frame;
        CGFloat width=self.currentBackgroundImage.size.width;
        CGFloat height=self.currentBackgroundImage.size.height;
        //长度为1的时候不用拉伸
        if(badgeValue.length>1){
            width=valueSize.width+10;
        }
        frame.size.width=width;
        frame.size.height=height;
        self.frame=frame;
    }else{
        self.hidden=YES;
    }
    
}

@end
