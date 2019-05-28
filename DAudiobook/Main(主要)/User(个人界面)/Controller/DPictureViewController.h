//
//  DPictureViewController.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/18.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DTableViewController.h"
#import "DContainerViewController.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - 全部照片
@interface DAllViewController : DTableViewController
@end

#pragma mark - 性感照片
@interface DSexyViewController : DAllViewController
@end

#pragma mark - 丰满照片
@interface DPlumpViewController : DAllViewController
@end

#pragma mark - 丝袜照片
@interface DSilkStockingsViewController : DAllViewController
@end

#pragma mark - 美腿照片
@interface DLegViewController : DAllViewController
@end

#pragma mark - 清新照片
@interface DSportViewController : DAllViewController
@end

#pragma mark - 照片控制器
@interface DPictureViewController : DViewController<DContainerViewControllerDelegate>


@end

NS_ASSUME_NONNULL_END
