//
//  UIView+MBProgressHUD.h
//  kaoLa
//
//  Created by Dengyongjun on 16/5/21.
//  Copyright © 2016年 kenneth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#define kDefaultShowTime 1
#define kLoginShowTime 11
#define kLogintwoTime 2
#define kLogintenTime 6
#define kLogintThree 3
#define kLoginThirty 39
#define kLoginquickly 0.5

#define kNetWorkLoadingMessage @"加载中....."
#define kNetWorkError          @"网络连接失败,请稍后再试"


@interface UIView (MBProgressHUD)

- (MBProgressHUD *)showLoadingMeg:(NSString *)meg;
- (void)hideLoading;
- (void)showLoadingMeg:(NSString *)meg time:(NSUInteger)time;
- (void)delayHideLoading;//2秒后消失

@end
