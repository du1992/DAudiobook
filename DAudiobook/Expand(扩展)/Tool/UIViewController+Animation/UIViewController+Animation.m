//
//  UIViewController+Animation.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/7.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "UIViewController+Animation.h"

@implementation UIViewController(Animation)


//水波纹
-(void)presentDropsWaterViewController:(UIViewController*)viewController{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.7;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self  presentViewController:viewController animated: NO completion:nil];
    
    
}




@end
