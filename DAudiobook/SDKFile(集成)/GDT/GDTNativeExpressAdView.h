//
//  GDTNativeExpressAdView.h
//  GDTMobApp
//
//  Created by michaelxing on 2017/4/14.
//  Copyright © 2017年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GDTNativeExpressAdView : UIView

/**
 * 是否渲染完毕
 */
@property (nonatomic, assign) BOOL    isReady;

/*
 *  viewControllerForPresentingModalView
 *  详解：[必选]开发者需传入用来弹出目标页的ViewController，一般为当前ViewController
 */
@property (nonatomic, weak) UIViewController *controller;


/**
 *[必选]
 *原生模板广告渲染
 */
- (void)render;

@end
