//
//  DRadioViewController.m
//  DStarNews
//
//  Created by DUCHENGWEN on 2017/2/7.
//  Copyright © 2017年 beijing. All rights reserved.
//

#import "DRadioViewController.h"
#import "Macro.h"
#import "MMDrawerBarButtonItem.h"
#import "UIBarButtonItem+Helper.h"
#import "UIViewController+MMDrawerController.h"
#import "DRadioSecondViewController.h"
#import "DRadioAllList.h"
#import "DRadioListCell.h"
#import "Business.h"
#import "RadioCarousel.h"
@interface DRadioViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *radioTableView;
@property (nonatomic,strong) NSMutableArray *radioAllListArray;

@end

@implementation DRadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  setupNavItem];
    [self.view addSubview:self.radioTableView];
    [self  creatUrlRequest];
}
#pragma mark - 发送网络请求
- (void)creatUrlRequest
{
    //为了防止无网络，把数据存储到本地了
    NSError *error;
    NSString *textFileContents = [NSString stringWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"D0" ofType:@"txt"]encoding:NSUTF8StringEncoding error: & error];
    NSDictionary *responseObject = [self dictionaryWithJsonString:textFileContents ] ;
    NSDictionary *dataDic = responseObject[@"data"];
    //设置表格的数据
    self.radioAllListArray = [DRadioAllList mj_objectArrayWithKeyValuesArray:dataDic[@"alllist"]];
    
    
    //电台网络请求
   [[Business sharedInstance] getRadio:radioUrl succ:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
       NSDictionary *dataDic = responseObject[@"data"];
       if (dataDic) {
           //设置表格的数据
           self.radioAllListArray = [DRadioAllList mj_objectArrayWithKeyValuesArray:dataDic[@"alllist"]];
           [self.radioTableView reloadData];
       }
       
    } fail:^(NSString *error) {
      
     
   }];
}

#pragma mark - 表格数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.radioAllListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRadioListCell *cell = [DRadioListCell cellWith:tableView];
    cell.allList = self.radioAllListArray[indexPath.row];
    return cell;
}


#pragma mark - 表格代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DRadioSecondViewController *secondVC = [[DRadioSecondViewController alloc] init];
    DRadioAllList *model = self.radioAllListArray[indexPath.row];
    [secondVC passContentidForRadio:model.radioid];
    
    [self.navigationController pushViewController:secondVC animated:YES];
}




#pragma mark - 懒加载

- (NSMutableArray *)radioAllListArray
{
    
    if (!_radioAllListArray) {
        _radioAllListArray = [NSMutableArray array];
    }
    return _radioAllListArray;
}

- (UITableView *)radioTableView
{
    if (!_radioTableView) {
        _radioTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _radioTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _radioTableView.delegate = self;
        _radioTableView.dataSource = self;
    }
    return _radioTableView;
}

#pragma mark - 设置导航栏
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"电台" target:nil action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}
- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
