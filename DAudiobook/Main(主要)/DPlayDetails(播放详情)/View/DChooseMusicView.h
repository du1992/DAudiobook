//
//  DChooseMusicView.h
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/28.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DView.h"
NS_ASSUME_NONNULL_BEGIN


@interface DChooseMusicView : DView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) void (^chooseMusicUpdateTata) (NSInteger curIndex);

/** 内容视图 */
@property(nonatomic,strong)UIView      *bottomView;
/** 视图 */
@property(nonatomic,strong)UITableView *tableView;
/** 标题 */
@property(nonatomic,strong)UILabel     *titleLabel;
/** 数据*/
@property (nonatomic, strong) NSMutableArray      *listArray;


/**
 *  点击按钮弹出
 */
-(void)show;
/**
 *  点击半透明部分或者取消按钮，弹出视图消失
 */
-(void)dismiss;


@end

NS_ASSUME_NONNULL_END
