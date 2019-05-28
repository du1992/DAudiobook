//
//  DJokesViewController.m
//  DAudiobook
//
//  Created by DUCHENGWEN on 2019/5/15.
//  Copyright © 2019 liujiliu. All rights reserved.
//

#import "DJokesViewController.h"
#import "DJokesModel.h"
#import "DTextJokesCell.h"
#import "DJokesModel.h"

@interface DJokesViewController ()

@end

@implementation DJokesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"段子";
    [self addBackItem];
    self.tableView.backgroundColor=UIColorFromRGBValue(0xf5f7fb);
    [self onHeaderRefreshing];
}

#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
        [self.tableView  reloadData];
    }
    NSMutableArray*arry=[DJokesModel mj_objectArrayWithKeyValuesArray:input];
    for (int a=0; a<arry.count; a++) {
        DJokesModel*model=arry[a];
        [model calculateHeight];
        [self.listArray addObject:model];
    }
    [self.tableView  reloadData];
       
}
//获取参数
-(NSMutableDictionary *)getJSON{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:[self.pageModel pageOutput]];
    [dic setObject:@"1" forKey:@"type"];
    return dic;
}
//获取URL
-(NSString *)getURL{
    return JokesUrl;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJokesModel *model   = self.listArray[indexPath.row];
    return model.cellHeight;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DTextJokesCell *cell = [DTextJokesCell cellWithTableView:tableView];
    DJokesModel *model   = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
}

@end
