//
//  DAllControllersTool.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/4/22.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "DMenuModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DAllControllersTool : NSObject

/**
 *  决定究竟加载哪个界面(唯一调用此类的入口)
 *
 *  @param menuModel 控制器的序列号
 */
+ (void)createViewControllerWithIndex:(DMenuModel*)menuModel;

@property (nonatomic,strong) MMDrawerController *drawerController;
@property (nonatomic,strong) NSMutableArray     *controllerArray;
+ (instancetype)shareOpenController;



@end

NS_ASSUME_NONNULL_END
