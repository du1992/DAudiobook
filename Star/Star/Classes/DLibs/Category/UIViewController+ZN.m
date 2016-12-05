//
//  UIViewController+ZN.m
//  Star
//
//  Created by JUNE_EN on 15/5/31.
//  Copyright (c) 2015年 beijing. All rights reserved.
//

#import "UIViewController+ZN.h"

@implementation UIViewController (ZN)
-(void)viewFirstLoad{
    
}
#pragma mark 封装异步加载请求
-(void)dispathLoad:(void (^)())block mainQueue:(void (^)())mainBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        block();
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            mainBlock();
        });
        
    });
    
}
@end
