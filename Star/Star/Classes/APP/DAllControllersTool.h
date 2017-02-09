//
//  DAllControllersTool.h
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/1/30.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAllControllersTool : NSObject

/**
 *  决定究竟加载哪个界面(唯一调用此类的入口)
 *
 *  @param index 控制器的序列号
 */
+ (void)createViewControllerWithIndex:(NSUInteger)index;

@end
