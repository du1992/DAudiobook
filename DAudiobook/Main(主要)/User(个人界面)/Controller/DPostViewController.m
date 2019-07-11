//
//  DPostViewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/25.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import <BmobSDK/Bmob.h>
#import "DPostViewController.h"
#import "DPostModel.h"
#import "DPostCell.h"
#import "DAddViewController.h"

@interface DPostViewController ()

@end

@implementation DPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title=@"论坛";
    
    [self addBackItem];
    [self addRightBarButtonItem:[[UIImage imageNamed:@"编辑"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [self initializeRefresh];
    [self onHeaderRefreshing];
    
}
//添加
-(void)rightItemClick{
    DAddViewController*VC=[DAddViewController new];
    [self.navigationController pushViewController:VC animated:YES];
    
}
#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
    }
    NSString *className = @"DPost";
    BmobQuery *query = [BmobQuery queryWithClassName:className];
    [query orderByDescending:@"updatedAt"];
    query.limit = 20; //请求数量
    query.skip = self.listArray.count;//跳过的数据
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WEAKSELF
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (!error) {
            for (BmobObject *obj in array) {
                DPostModel *model    = [DPostModel new];
                [model modelDealWith:obj];
                [model calculateHeight];
                [self.listArray addObject:model];
            }
            [weakSelf.tableView reloadData];
            
        }
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DPostModel *model   = self.listArray[indexPath.row];
    return model.cellHeight;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DPostCell *cell = [DPostCell cellWithTableView:tableView];
    DPostModel *model   = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}


@end
