//
//  UIView+MBProgressHUD.m
//  kaoLa
//
//  Created by Dengyongjun on 16/5/21.
//  Copyright © 2016年 kenneth. All rights reserved.
//

#import "UIView+MBProgressHUD.h"

@implementation UIView (MBProgressHUD)

- (MBProgressHUD *)showLoadingMeg:(NSString *)meg
{
    MBProgressHUD *hudView = [MBProgressHUD HUDForView:self];
    if (!hudView) {
        hudView = [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
    else
    {
        [hudView show:YES];
    }
    hudView.detailsLabelText = meg;
    return hudView;
}
- (void)hideLoading
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}
- (void)showLoadingMeg:(NSString *)meg time:(NSUInteger)time
{
    MBProgressHUD *hud = [self showLoadingMeg:meg];
    hud.mode = MBProgressHUDModeCustomView;
    if (time > 0) {
        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:time];
    }
}
- (void)delayHideLoading
{
    [self performSelector:@selector(hideLoading) withObject:nil afterDelay:kDefaultShowTime];
}

@end
