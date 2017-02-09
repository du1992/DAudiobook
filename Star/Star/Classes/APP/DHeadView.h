//
//  DHeadView.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHeadView : UIView

typedef void(^HeaderViewClickEvent)(NSString *titleStr);

@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic, copy) HeaderViewClickEvent headerViewBlock;

@property(nonatomic, strong) NSString *uesrName;
@property(nonatomic, strong) UIImage  *userIcon;
@property(nonatomic, strong) NSString *userInfo;

@end
