//
//  DHomeViewController.m
//  InterstellarNotes
//
//  Created by DUCHENGWEN on 2019/1/9.
//  Copyright © 2019年 liujiliu. All rights reserved.
//

#import "DHomeViewController.h"
#import "DRadioListCell.h"
#import "DRadioModel.h"
#import "DAlbumViewController.h"

#pragma mark - 热门小说
@implementation DHotNovelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self onHeaderRefreshing];
    [self GDTadvertising];

}
#pragma mark - 共享方法
//数据处理
-(void)dataProcessingIsRemove:(BOOL)isRemove input:(id)input{
    if (isRemove) {
        [self.listArray removeAllObjects];
    }
    [self.listArray addObjectsFromArray:[DRadioModel mj_objectArrayWithKeyValuesArray:input]];
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
    return HotNovelUrl;
}
//获取title
-(NSString *)getMenuTitle{
    return @"热门";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85;
}
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DRadioListCell *cell = [DRadioListCell cellWithTableView:tableView];
    DRadioModel *model = self.listArray[indexPath.row];
    [cell setData:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DRadioModel *model = self.listArray[indexPath.row];
    DAlbumViewController *VC = [[DAlbumViewController alloc] init];
    VC.model=model;
    [self.navigationController pushViewController:VC animated:YES];
    
}

@end



#pragma mark - 相声评书
@implementation DCrosstalkViewController

//获取URL
-(NSString *)getURL{
    return CrosstalkUrl;
}
//获取title
-(NSString *)getMenuTitle{
    return @"相声";
}

@end




#pragma mark - 玄幻小说
@implementation DFantasyViewController

//获取URL
-(NSString *)getURL{
    return FantasyUrl;
}
//获取title
-(NSString *)getMenuTitle{
    return @"玄幻";
}

@end


#pragma mark - 都市小说
@implementation DCityViewController

//获取URL
-(NSString *)getURL{
    return CityUrl;
}
//获取title
-(NSString *)getMenuTitle{
    return @"都市";
}
@end


#pragma mark - 恐怖小说
@implementation DTerroristViewController

//获取URL
-(NSString *)getURL{
    return TerroristUrl;
}
//获取title
-(NSString *)getMenuTitle{
    return @"恐怖";
}

@end


#pragma mark - 历史小说
@implementation DHistoryViewController

//获取URL
-(NSString *)getURL{
    return HistoryUrl;
}
//获取title
-(NSString *)getMenuTitle{
    return @"历史";
}

@end


#pragma mark - 武侠小说
@implementation DMartialViewController

//获取URL
-(NSString *)getURL{
    return MartialUrl;
}
//获取title
-(NSString *)getMenuTitle{
    return @"武侠";
}

@end
