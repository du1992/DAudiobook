//
//  StarInfoHeaderView.h
//  Star
//
//  Created by JUNE_EN on 15/6/2.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarSelfInfo.h"
@interface StarInfoHeaderView : UIView
@property (nonatomic,weak)IBOutlet UIImageView *imgView;
@property (nonatomic,strong) StarSelfInfo *selfInfo;
@property (strong, nonatomic)  UIImageView *backGroundImageView;

@end
